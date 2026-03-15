module Main where

import Actions (addPriceRecord, addProduct, createPriceRecord, createProduct)
import Queries (getCurrentPriceRecord, getNumProducts, getPriceRecords)
import State (initState)
import Types
  ( Product (pId),
    Role (..),
  )

main :: IO ()
main = do
  product1 <- createProduct "Farm A" "Coffee"

  let state1 = addProduct product1 initState
  let pid = pId product1

  price1 <- createPriceRecord pid "Farm A" Producer 500
  price2 <- createPriceRecord pid "Distributor B" Distributor 800
  price3 <- createPriceRecord pid "Shop C" Retailer 1200

  let state2 = addPriceRecord price1 state1
  let state3 = state2 >>= addPriceRecord price2
  let state4 = state3 >>= addPriceRecord price3

  case state4 of
    Left err -> putStrLn err
    Right finalState -> do
      print (getNumProducts finalState)
      print (getPriceRecords pid finalState)
      print (getCurrentPriceRecord pid finalState)