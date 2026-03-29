{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Types where

import PlutusTx
import PlutusTx.Prelude
import PlutusLedgerApi.V2 (BuiltinByteString, POSIXTime)
import Prelude (Show)

type Actor = BuiltinByteString
type Creator = BuiltinByteString
type ProductId = BuiltinByteString

data Role = Producer | Distributor | Retailer
    deriving stock (Show)

{-# INLINABLE eqRole #-}
eqRole :: Role -> Role -> Bool
eqRole Producer Producer = True
eqRole Distributor Distributor = True
eqRole Retailer Retailer = True
eqRole _ _ = False

PlutusTx.unstableMakeIsData ''Role
PlutusTx.makeLift ''Role

data Product = Product
    { pId        :: ProductId
    , pName      :: BuiltinByteString
    , pCreator   :: Creator
    , pTimestamp :: POSIXTime
    }
    deriving stock (Show)

PlutusTx.unstableMakeIsData ''Product
PlutusTx.makeLift ''Product

data PriceRecord = PriceRecord
    { prProductId :: ProductId
    , prActor     :: Actor
    , prRole      :: Role
    , prAmount    :: Integer -- in cents
    , prTimestamp :: POSIXTime
    }
    deriving stock (Show)

PlutusTx.unstableMakeIsData ''PriceRecord
PlutusTx.makeLift ''PriceRecord