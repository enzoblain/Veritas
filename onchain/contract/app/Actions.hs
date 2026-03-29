{-# LANGUAGE NoImplicitPrelude #-}

module Actions where

import PlutusTx.Prelude
import Queries (getCurrentPriceRecord)
import State (State (..), stateContainsProductId)
import Types
    ( Actor
    , Creator
    , PriceRecord (..)
    , Product (..)
    , ProductId
    , Role (Distributor, Producer, Retailer)
    , eqRole
    )
import PlutusLedgerApi.V2 (POSIXTime)

{-# INLINABLE roleRank #-}
roleRank :: Role -> Integer
roleRank Producer    = 0
roleRank Distributor = 1
roleRank Retailer    = 2

{-# INLINABLE createProduct #-}
createProduct :: ProductId -> Creator -> BuiltinByteString -> POSIXTime -> Product
createProduct pid c n ts =
    Product
        { pId = pid
        , pName = n
        , pCreator = c
        , pTimestamp = ts
        }

{-# INLINABLE addProduct #-}
addProduct :: Product -> State -> State
addProduct p s =
    s { sProducts = p : sProducts s }

{-# INLINABLE createPriceRecord #-}
createPriceRecord :: ProductId -> Actor -> Role -> Integer -> POSIXTime -> PriceRecord
createPriceRecord pid a r amount ts =
    PriceRecord
        { prProductId = pid
        , prActor = a
        , prRole = r
        , prAmount = amount
        , prTimestamp = ts
        }

{-# INLINABLE addPriceRecord #-}
addPriceRecord :: PriceRecord -> State -> Either BuiltinByteString State
addPriceRecord p s
    | not (stateContainsProductId (prProductId p) s) =
        Left "Product does not exist"
    | otherwise =
        case getCurrentPriceRecord (prProductId p) s of
            Nothing ->
                if eqRole (prRole p) Producer
                    then Right s { sPriceRecords = p : sPriceRecords s }
                    else Left "First price must be set by a Producer"
            Just l
                | prActor p == prActor l ->
                    Left "Same actor cannot add two consecutive price records"
                | prAmount p < prAmount l ->
                    Left "Price cannot decrease"
                | eqRole (prRole p) Producer ->
                    Left "Producer can only set the first price record"
                | eqRole (prRole p) Distributor && roleRank Distributor >= roleRank (prRole l) ->
                    Right s { sPriceRecords = p : sPriceRecords s }
                | roleRank (prRole p) > roleRank (prRole l) ->
                    Right s { sPriceRecords = p : sPriceRecords s }
                | otherwise ->
                    Left "Invalid role order"