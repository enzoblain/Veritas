{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module Types where

import PlutusTx
import PlutusTx.Prelude
import PlutusLedgerApi.V2 (POSIXTime)
import Prelude (Show, Eq)
import GHC.Generics (Generic)

type Actor = BuiltinByteString
type Creator = BuiltinByteString
type ProductId = BuiltinByteString

data Role = Producer | Distributor | Retailer
  deriving (Show, Generic, Eq)

PlutusTx.makeIsDataIndexed ''Role [('Producer,0),('Distributor,1),('Retailer,2)]

data Product = Product
  { pId :: ProductId
  , pName :: BuiltinByteString
  , pCreator :: Creator
  , pTimestamp :: POSIXTime
  }
  deriving (Show, Generic)

PlutusTx.makeIsDataIndexed ''Product [('Product,0)]

data PriceRecord = PriceRecord
  { prProductId :: ProductId
  , prActor :: Actor
  , prRole :: Role
  , prAmount :: Integer
  , prTimestamp :: POSIXTime
  }
  deriving (Show, Generic)

PlutusTx.makeIsDataIndexed ''PriceRecord [('PriceRecord,0)]