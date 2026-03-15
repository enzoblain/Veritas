module Utils where

import Data.Time.Clock.POSIX (POSIXTime, getPOSIXTime)
import Data.UUID (toString)
import Data.UUID.V4 (nextRandom)

generateId :: IO String
generateId = do
  uuid <- nextRandom
  return ("VRT-" ++ toString uuid)

getTimestamp :: IO POSIXTime
getTimestamp = getPOSIXTime