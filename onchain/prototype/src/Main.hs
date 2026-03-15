module Main where

import Actions (addPriceRecord, createProduct)
import Queries (getCurrentPrice, getNumProducts, getPriceRecords)
import State (initState)
import Types
  ( PriceRecord (..),
    Product (..),
    Role (..),
  )

main :: IO ()
main = do
  let product1 =
        Product
          { pId = "coffee-1",
            pCreator = "Farm A",
            pTimestamp = 1
          }

  let state1 = createProduct product1 initState

  let price1 =
        PriceRecord
          { prProductId = "coffee-1",
            prActor = "Farm A",
            prRole = Producer,
            prAmount = 500,
            prTimestamp = 2
          }

  let price2 =
        PriceRecord
          { prProductId = "coffee-1",
            prActor = "Distributor B",
            prRole = Distributor,
            prAmount = 800,
            prTimestamp = 3
          }

  let price3 =
        PriceRecord
          { prProductId = "coffee-1",
            prActor = "Shop C",
            prRole = Retailer,
            prAmount = 1200,
            prTimestamp = 4
          }

  let maybeState2 = addPriceRecord price1 state1
  let maybeState3 = maybeState2 >>= addPriceRecord price2
  let maybeState4 = maybeState3 >>= addPriceRecord price3

  case maybeState4 of
    Nothing -> putStrLn "Erreur : impossible d'ajouter un price record."
    Just finalState -> do
      print (getNumProducts finalState)
      print (getPriceRecords "coffee-1" finalState)
      print (getCurrentPrice "coffee-1" finalState)