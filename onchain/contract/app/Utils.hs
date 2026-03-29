{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Utils where

import PlutusTx
import PlutusTx.Prelude
import PlutusLedgerApi.V2 (BuiltinByteString, POSIXTime, ScriptContext, TxInfo(..), scriptContextTxInfo)
import Plutus.V1.Ledger.Time (POSIXTimeRange, contains)
import Plutus.V1.Ledger.Interval (ivFrom)

import qualified PlutusTx.Builtins as Builtins

{-# INLINABLE generateId #-}
generateId :: BuiltinByteString -> POSIXTime -> BuiltinByteString
generateId seed ts =
    let input = seed <> Builtins.consByteString 45 (toBuiltin (integerToBS (getPOSIX ts)))
        digest = Builtins.blake2b_256 input
    in "VRT-" <> digest

{-# INLINABLE getPOSIX #-}
getPOSIX :: POSIXTime -> Integer
getPOSIX (POSIXTime i) = i

{-# INLINABLE integerToBS #-}
integerToBS :: Integer -> BuiltinByteString
integerToBS = Builtins.encodeUtf8 . toBuiltin . show

{-# INLINABLE getTimestamp #-}
getTimestamp :: ScriptContext -> POSIXTime
getTimestamp ctx =
    let info = scriptContextTxInfo ctx
        range = txInfoValidRange info
    in case ivFrom range of
        LowerBound (Finite t) _ -> t
        _                       -> 0