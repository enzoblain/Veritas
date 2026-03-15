module Actions where

import State (State (..), stateContainsProductId)
import Types (PriceRecord (prProductId), Product)

createProduct :: Product -> State -> State
createProduct p s = s {sProducts = p : sProducts s}

addPriceRecord :: PriceRecord -> State -> Maybe State
addPriceRecord p s
  | stateContainsProductId (prProductId p) s =
      Just s {sPriceRecords = p : sPriceRecords s}
  | otherwise = Nothing