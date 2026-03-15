module Queries where

import State (State (..))
import Types (PriceRecord (prProductId), ProductId)

getPriceRecords :: ProductId -> State -> [PriceRecord]
getPriceRecords pid s =
  filter (\pr -> prProductId pr == pid) (sPriceRecords s)

getCurrentPrice :: ProductId -> State -> Maybe PriceRecord
getCurrentPrice pid s =
  case getPriceRecords pid s of
    [] -> Nothing
    (x : _) -> Just x

getNumProducts :: State -> Int
getNumProducts s = length (sProducts s)