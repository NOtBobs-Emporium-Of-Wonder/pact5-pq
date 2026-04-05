{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_pact_tng (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "pact_tng"
version :: Version
version = Version [5,4,1] []

synopsis :: String
synopsis = "Smart contract language library and REPL"
copyright :: String
copyright = "Copyright (C) 2022 Kadena"
homepage :: String
homepage = "https://github.com/kadena-community/pact-5"
