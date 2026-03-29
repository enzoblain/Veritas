{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}

module State where

import PlutusTx
import PlutusTx.Prelude
import Types (PriceRecord, Product, ProductId, pId)
import qualified Prelude as Haskell
import Prelude (Show)

data State = State
    { sProducts     :: [Product]
    , sPriceRecords :: [PriceRecord]
    }
    deriving stock (Show)

PlutusTx.unstableMakeIsData ''State
PlutusTx.makeLift ''State

{-# INLINABLE initState #-}
initState :: State
initState =
    State
        { sProducts = []
        , sPriceRecords = []
        }

{-# INLINABLE stateContainsProductId #-}
stateContainsProductId :: ProductId -> State -> Bool
stateContainsProductId pid s =
    Haskell.any (\p -> pId p == pid) (sProducts s)