module Actions where

import Queries (getCurrentPriceRecord)
import State (State (..), stateContainsProductId)
import Types (Actor, Creator, PriceRecord (..), Product (..), ProductId, Role (Distributor, Producer))
import Utils (generateId, getTimestamp)

createProduct :: Creator -> String -> IO Product
createProduct c n = do
  pid <- generateId (c ++ n)
  ts <- getTimestamp
  return
    Product
      { pId = pid,
        pName = n,
        pCreator = c,
        pTimestamp = ts
      }

addProduct :: Product -> State -> State
addProduct p s =
  s {sProducts = p : sProducts s}

createPriceRecord :: ProductId -> Actor -> Role -> Integer -> IO PriceRecord
createPriceRecord pid a r p = do
  ts <- getTimestamp
  return
    PriceRecord
      { prProductId = pid,
        prActor = a,
        prRole = r,
        prAmount = p,
        prTimestamp = ts
      }

addPriceRecord :: PriceRecord -> State -> Either String State
addPriceRecord p s
  | not (stateContainsProductId (prProductId p) s) =
      Left "Product does not exist"
  | otherwise =
      case getCurrentPriceRecord (prProductId p) s of
        Nothing ->
          if prRole p == Producer
            then Right s {sPriceRecords = p : sPriceRecords s}
            else Left "First price must be set by a Producer"
        Just l
          | prActor p == prActor l ->
              Left "Same actor cannot add two consecutive price records"
          | prAmount p < prAmount l ->
              Left "Price cannot decrease"
          | prRole p == Producer ->
              Left "Producer can only set the first price record"
          | prRole p == Distributor && fromEnum Distributor >= fromEnum (prRole l) ->
              Right s {sPriceRecords = p : sPriceRecords s}
          | fromEnum (prRole p) > fromEnum (prRole l) ->
              Right s {sPriceRecords = p : sPriceRecords s}
          | otherwise ->
              Left "Invalid role order"