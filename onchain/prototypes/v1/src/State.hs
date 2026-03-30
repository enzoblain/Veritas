module State where

import Types (PriceRecord, Product, ProductId, pId)

data State = State
  { sProducts :: [Product],
    sPriceRecords :: [PriceRecord]
  }

initState :: State
initState =
  State
    { sProducts = [],
      sPriceRecords = []
    }

stateContainsProductId :: ProductId -> State -> Bool
stateContainsProductId pid s =
  any (\p -> pId p == pid) (sProducts s)
