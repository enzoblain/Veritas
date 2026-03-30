module Main where

import Actions (addPriceRecord, addProduct, createPriceRecord, createProduct)
import Queries
  ( getCurrentPriceRecord,
    getNumProducts,
    getPriceRecords,
  )
import State (initState)
import Types (PriceRecord (..), Product (pId), Role (..))

assert :: String -> Bool -> IO ()
assert name cond =
  putStrLn $
    prefix ++ " " ++ name
  where
    prefix =
      if cond
        then "[PASS]"
        else "[FAIL]"

assertLeft :: String -> Either String a -> IO ()
assertLeft name res =
  assert name $
    case res of
      Left _ -> True
      Right _ -> False

assertRight :: String -> Either String a -> IO ()
assertRight name res =
  assert name $
    case res of
      Right _ -> True
      Left _ -> False

runAllTests :: IO ()
runAllTests = do
  putStrLn "=== VERITAS TEST SUITE ==="

  product1 <- createProduct "Farm A" "Coffee"
  let pid = pId product1
  let state1 = addProduct product1 initState

  priceProducer <- createPriceRecord pid "Farm A" Producer 500
  priceDistributor <- createPriceRecord pid "Distributor B" Distributor 800
  priceRetailer <- createPriceRecord pid "Shop C" Retailer 1200

  fakePrice <- createPriceRecord "fake-id" "Nobody" Producer 100
  badFirstDistributor <- createPriceRecord pid "Distributor X" Distributor 400
  badLowerPrice <- createPriceRecord pid "Distributor C" Distributor 300
  sameActorAgain <- createPriceRecord pid "Distributor B" Distributor 900
  secondProducer <- createPriceRecord pid "Farm Z" Producer 900
  backToDistributor <- createPriceRecord pid "Distributor Z" Distributor 1400
  secondRetailer <- createPriceRecord pid "Shop D" Retailer 1300

  let res1 = addPriceRecord fakePrice state1
  assertLeft "Refuse price for non-existing product" res1

  let res2 = addPriceRecord badFirstDistributor state1
  assertLeft "First price must be Producer" res2

  let res3 = addPriceRecord priceProducer state1
  assertRight "Accept first Producer price" res3

  case res3 of
    Left err -> putStrLn ("Unexpected error: " ++ err)
    Right state2 -> do
      assert "Product count = 1" (getNumProducts state2 == 1)

      assert "Current price after first record = 500" $
        case getCurrentPriceRecord pid state2 of
          Just pr -> prAmount pr == 500
          Nothing -> False

      let res4 = addPriceRecord badLowerPrice state2
      assertLeft "Refuse decreasing price" res4

      let res5 = addPriceRecord secondProducer state2
      assertLeft "Refuse second Producer" res5

      let res6 = addPriceRecord priceDistributor state2
      assertRight "Accept first Distributor" res6

      case res6 of
        Left err -> putStrLn ("Unexpected error: " ++ err)
        Right state3 -> do
          let res7 = addPriceRecord sameActorAgain state3
          assertLeft "Refuse same actor twice consecutively" res7

          let res8 = addPriceRecord priceRetailer state3
          assertRight "Accept Retailer after Distributor" res8

          case res8 of
            Left err -> putStrLn ("Unexpected error: " ++ err)
            Right finalState -> do
              let res9 = addPriceRecord backToDistributor finalState
              assertLeft "Refuse going back to Distributor after Retailer" res9

              let res10 = addPriceRecord secondRetailer finalState
              assertLeft "Refuse second Retailer" res10

              let history = getPriceRecords pid finalState
              assert "There are 3 price records" (length history == 3)

              assert "Current price = 1200" $
                case getCurrentPriceRecord pid finalState of
                  Just pr -> prAmount pr == 1200
                  Nothing -> False

main :: IO ()
main = runAllTests