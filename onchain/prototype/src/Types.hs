module Types where

import Data.Time.Clock.POSIX (POSIXTime)

type Actor = String

type ProductId = String

data Role = Producer | Distributor | Retailer deriving (Show, Enum, Eq)

data Product = Product
  { pId :: ProductId,
    pCreator :: Actor,
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