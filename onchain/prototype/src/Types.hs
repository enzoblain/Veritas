module Types where

import Data.Time.Clock.POSIX (POSIXTime)

type Actor = String

type Creator = String

type ProductId = String

data Role = Producer | Distributor | Retailer deriving (Show, Enum, Eq)

data Product = Product
  { pId :: ProductId,
    pName :: String,
    pCreator :: Creator,
    pTimestamp :: POSIXTime
  }
  deriving (Show)

data PriceRecord = PriceRecord
  { prProductId :: ProductId,
    prActor :: Actor,
    prRole :: Role,
    prAmount :: Integer, -- in cents
    prTimestamp :: POSIXTime
  }
  deriving (Show)