module Utils where

import Crypto.Hash (Blake2b_256, Digest, hash)
import Data.ByteString.Char8 (pack)
import Data.Time.Clock.POSIX (POSIXTime, getPOSIXTime)

generateId :: String -> IO String
generateId seed = do
  ts <- getTimestamp
  let input = seed ++ show ts
  let digest = hash (pack input) :: Digest Blake2b_256
  return ("VRT-" ++ show digest)

getTimestamp :: IO POSIXTime
getTimestamp = getPOSIXTime