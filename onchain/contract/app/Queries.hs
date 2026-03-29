{-# LANGUAGE NoImplicitPrelude #-}

module Queries where

import PlutusTx.Prelude
import State (State (..))
import Types (PriceRecord (..), ProductId)

{-# INLINABLE filter #-}
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter f (x:xs) =
    if f x
        then x : filter f xs
        else filter f xs

{-# INLINABLE length #-}
length :: [a] -> Integer
length [] = 0
length (_:xs) = 1 + length xs

{-# INLINABLE getPriceRecords #-}
getPriceRecords :: ProductId -> State -> [PriceRecord]
getPriceRecords pid s =
    filter (\pr -> prProductId pr == pid) (sPriceRecords s)

{-# INLINABLE getCurrentPriceRecord #-}
getCurrentPriceRecord :: ProductId -> State -> Maybe PriceRecord
getCurrentPriceRecord pid s =
    case getPriceRecords pid s of
        []      -> Nothing
        x : _   -> Just x

{-# INLINABLE getNumProducts #-}
getNumProducts :: State -> Integer
getNumProducts s =
    length (sProducts s)