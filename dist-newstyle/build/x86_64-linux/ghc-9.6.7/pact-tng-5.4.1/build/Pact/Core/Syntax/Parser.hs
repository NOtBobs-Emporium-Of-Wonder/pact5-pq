{-# OPTIONS_GHC -w #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE PatternGuards #-}
{-# LANGUAGE NoStrictData #-}
{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Pact.Core.Syntax.Parser where

import Control.Lens(preview, view, _head, _3)
import Control.Monad(when)
import Control.Monad.Except

import Data.Decimal(DecimalRaw(..))
import Data.Char(digitToInt)
import Data.Text(Text)
import Data.List.NonEmpty(NonEmpty(..))
import Data.Either(lefts, rights)
import Data.Maybe(catMaybes)

import qualified Data.Map.Strict as M
import qualified Data.Text as T
import qualified Data.Text.Read as T
import qualified Data.List.NonEmpty as NE

import Pact.Core.Names hiding (Arg)
import Pact.Core.Info
import Pact.Core.Literal
import Pact.Core.Builtin
import Pact.Core.Type(PrimType(..))
import Pact.Core.Errors
import Pact.Core.Syntax.ParseTree
import Pact.Core.Syntax.LexUtils
import qualified Control.Monad as Happy_Prelude
import qualified Data.Bool as Happy_Prelude
import qualified Data.Function as Happy_Prelude
import qualified Data.Int as Happy_Prelude
import qualified Data.List as Happy_Prelude
import qualified Data.Maybe as Happy_Prelude
import qualified Data.String as Happy_Prelude
import qualified Data.Tuple as Happy_Prelude
import qualified GHC.Err as Happy_Prelude
import qualified GHC.Num as Happy_Prelude
import qualified Text.Show as Happy_Prelude
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 2.2

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
newtype HappyWrap8 = HappyWrap8 ([ParsedTopLevel])
happyIn8 :: ([ParsedTopLevel]) -> (HappyAbsSyn )
happyIn8 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap8 x)
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> HappyWrap8
happyOut8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut8 #-}
newtype HappyWrap9 = HappyWrap9 ([ParsedTopLevel])
happyIn9 :: ([ParsedTopLevel]) -> (HappyAbsSyn )
happyIn9 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap9 x)
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> HappyWrap9
happyOut9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut9 #-}
newtype HappyWrap10 = HappyWrap10 ([ReplTopLevel SpanInfo])
happyIn10 :: ([ReplTopLevel SpanInfo]) -> (HappyAbsSyn )
happyIn10 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap10 x)
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> HappyWrap10
happyOut10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut10 #-}
newtype HappyWrap11 = HappyWrap11 ([ReplTopLevel SpanInfo])
happyIn11 :: ([ReplTopLevel SpanInfo]) -> (HappyAbsSyn )
happyIn11 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap11 x)
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> HappyWrap11
happyOut11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut11 #-}
newtype HappyWrap12 = HappyWrap12 (ParsedTopLevel)
happyIn12 :: (ParsedTopLevel) -> (HappyAbsSyn )
happyIn12 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap12 x)
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> HappyWrap12
happyOut12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut12 #-}
newtype HappyWrap13 = HappyWrap13 (ReplTopLevel SpanInfo)
happyIn13 :: (ReplTopLevel SpanInfo) -> (HappyAbsSyn )
happyIn13 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap13 x)
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> HappyWrap13
happyOut13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut13 #-}
newtype HappyWrap14 = HappyWrap14 (Governance)
happyIn14 :: (Governance) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap14 x)
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> HappyWrap14
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
newtype HappyWrap15 = HappyWrap15 (Text)
happyIn15 :: (Text) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap15 x)
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> HappyWrap15
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
newtype HappyWrap16 = HappyWrap16 (ParsedModule)
happyIn16 :: (ParsedModule) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap16 x)
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> HappyWrap16
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
newtype HappyWrap17 = HappyWrap17 (ParsedInterface)
happyIn17 :: (ParsedInterface) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap17 x)
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> HappyWrap17
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
newtype HappyWrap18 = HappyWrap18 (ExtDecl SpanInfo)
happyIn18 :: (ExtDecl SpanInfo) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap18 x)
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> HappyWrap18
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
newtype HappyWrap19 = HappyWrap19 (Import SpanInfo)
happyIn19 :: (Import SpanInfo) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap19 x)
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> HappyWrap19
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
newtype HappyWrap20 = HappyWrap20 ((NonEmpty (Def SpanInfo), [ExtDecl SpanInfo]))
happyIn20 :: ((NonEmpty (Def SpanInfo), [ExtDecl SpanInfo])) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap20 x)
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> HappyWrap20
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
newtype HappyWrap21 = HappyWrap21 ([Either (Def SpanInfo) (ExtDecl SpanInfo)])
happyIn21 :: ([Either (Def SpanInfo) (ExtDecl SpanInfo)]) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap21 x)
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> HappyWrap21
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
newtype HappyWrap22 = HappyWrap22 (ParsedDef)
happyIn22 :: (ParsedDef) -> (HappyAbsSyn )
happyIn22 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap22 x)
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> HappyWrap22
happyOut22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut22 #-}
newtype HappyWrap23 = HappyWrap23 ([Either ParsedIfDef (Import SpanInfo)])
happyIn23 :: ([Either ParsedIfDef (Import SpanInfo)]) -> (HappyAbsSyn )
happyIn23 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap23 x)
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> HappyWrap23
happyOut23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut23 #-}
newtype HappyWrap24 = HappyWrap24 (ParsedIfDef)
happyIn24 :: (ParsedIfDef) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap24 x)
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> HappyWrap24
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
newtype HappyWrap25 = HappyWrap25 (SpanInfo -> IfDefun SpanInfo)
happyIn25 :: (SpanInfo -> IfDefun SpanInfo) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap25 x)
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> HappyWrap25
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
newtype HappyWrap26 = HappyWrap26 (SpanInfo -> IfDefCap SpanInfo)
happyIn26 :: (SpanInfo -> IfDefCap SpanInfo) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap26 x)
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> HappyWrap26
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
newtype HappyWrap27 = HappyWrap27 (SpanInfo -> IfDefPact SpanInfo)
happyIn27 :: (SpanInfo -> IfDefPact SpanInfo) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap27 x)
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> HappyWrap27
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
newtype HappyWrap28 = HappyWrap28 (Maybe [Text])
happyIn28 :: (Maybe [Text]) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap28 x)
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> HappyWrap28
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
newtype HappyWrap29 = HappyWrap29 ([Text])
happyIn29 :: ([Text]) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap29 x)
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> HappyWrap29
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
newtype HappyWrap30 = HappyWrap30 (SpanInfo -> ParsedDefConst)
happyIn30 :: (SpanInfo -> ParsedDefConst) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap30 x)
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> HappyWrap30
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
newtype HappyWrap31 = HappyWrap31 (SpanInfo -> ParsedDefun)
happyIn31 :: (SpanInfo -> ParsedDefun) -> (HappyAbsSyn )
happyIn31 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap31 x)
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> HappyWrap31
happyOut31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut31 #-}
newtype HappyWrap32 = HappyWrap32 (SpanInfo -> DefSchema SpanInfo)
happyIn32 :: (SpanInfo -> DefSchema SpanInfo) -> (HappyAbsSyn )
happyIn32 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap32 x)
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> HappyWrap32
happyOut32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut32 #-}
newtype HappyWrap33 = HappyWrap33 (SpanInfo -> DefTable SpanInfo)
happyIn33 :: (SpanInfo -> DefTable SpanInfo) -> (HappyAbsSyn )
happyIn33 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap33 x)
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> HappyWrap33
happyOut33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut33 #-}
newtype HappyWrap34 = HappyWrap34 (SpanInfo -> DefCap SpanInfo)
happyIn34 :: (SpanInfo -> DefCap SpanInfo) -> (HappyAbsSyn )
happyIn34 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap34 x)
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> HappyWrap34
happyOut34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut34 #-}
newtype HappyWrap35 = HappyWrap35 (SpanInfo -> DefPact SpanInfo)
happyIn35 :: (SpanInfo -> DefPact SpanInfo) -> (HappyAbsSyn )
happyIn35 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap35 x)
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> HappyWrap35
happyOut35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut35 #-}
newtype HappyWrap36 = HappyWrap36 (NE.NonEmpty (PactStep SpanInfo))
happyIn36 :: (NE.NonEmpty (PactStep SpanInfo)) -> (HappyAbsSyn )
happyIn36 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap36 x)
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> HappyWrap36
happyOut36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut36 #-}
newtype HappyWrap37 = HappyWrap37 ([PactStep SpanInfo])
happyIn37 :: ([PactStep SpanInfo]) -> (HappyAbsSyn )
happyIn37 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap37 x)
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> HappyWrap37
happyOut37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut37 #-}
newtype HappyWrap38 = HappyWrap38 (PactStep SpanInfo)
happyIn38 :: (PactStep SpanInfo) -> (HappyAbsSyn )
happyIn38 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap38 x)
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> HappyWrap38
happyOut38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut38 #-}
newtype HappyWrap39 = HappyWrap39 (Maybe DCapMeta)
happyIn39 :: (Maybe DCapMeta) -> (HappyAbsSyn )
happyIn39 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap39 x)
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> HappyWrap39
happyOut39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut39 #-}
newtype HappyWrap40 = HappyWrap40 (DCapMeta)
happyIn40 :: (DCapMeta) -> (HappyAbsSyn )
happyIn40 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap40 x)
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> HappyWrap40
happyOut40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut40 #-}
newtype HappyWrap41 = HappyWrap41 (DCapMeta)
happyIn41 :: (DCapMeta) -> (HappyAbsSyn )
happyIn41 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap41 x)
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> HappyWrap41
happyOut41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut41 #-}
newtype HappyWrap42 = HappyWrap42 ([MArg SpanInfo])
happyIn42 :: ([MArg SpanInfo]) -> (HappyAbsSyn )
happyIn42 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap42 x)
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> HappyWrap42
happyOut42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut42 #-}
newtype HappyWrap43 = HappyWrap43 (MArg SpanInfo)
happyIn43 :: (MArg SpanInfo) -> (HappyAbsSyn )
happyIn43 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap43 x)
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> HappyWrap43
happyOut43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut43 #-}
newtype HappyWrap44 = HappyWrap44 ([Arg SpanInfo])
happyIn44 :: ([Arg SpanInfo]) -> (HappyAbsSyn )
happyIn44 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap44 x)
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> HappyWrap44
happyOut44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut44 #-}
newtype HappyWrap45 = HappyWrap45 (Type)
happyIn45 :: (Type) -> (HappyAbsSyn )
happyIn45 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap45 x)
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> HappyWrap45
happyOut45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut45 #-}
newtype HappyWrap46 = HappyWrap46 ([ModuleName])
happyIn46 :: ([ModuleName]) -> (HappyAbsSyn )
happyIn46 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap46 x)
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> HappyWrap46
happyOut46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut46 #-}
newtype HappyWrap47 = HappyWrap47 (Text)
happyIn47 :: (Text) -> (HappyAbsSyn )
happyIn47 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap47 x)
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> HappyWrap47
happyOut47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut47 #-}
newtype HappyWrap48 = HappyWrap48 (Text)
happyIn48 :: (Text) -> (HappyAbsSyn )
happyIn48 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap48 x)
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> HappyWrap48
happyOut48 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut48 #-}
newtype HappyWrap49 = HappyWrap49 (Maybe [PropertyExpr SpanInfo])
happyIn49 :: (Maybe [PropertyExpr SpanInfo]) -> (HappyAbsSyn )
happyIn49 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap49 x)
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> HappyWrap49
happyOut49 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut49 #-}
newtype HappyWrap50 = HappyWrap50 ([PropertyExpr SpanInfo])
happyIn50 :: ([PropertyExpr SpanInfo]) -> (HappyAbsSyn )
happyIn50 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap50 x)
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> HappyWrap50
happyOut50 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut50 #-}
newtype HappyWrap51 = HappyWrap51 ([PactAnn SpanInfo])
happyIn51 :: ([PactAnn SpanInfo]) -> (HappyAbsSyn )
happyIn51 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap51 x)
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> HappyWrap51
happyOut51 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut51 #-}
newtype HappyWrap52 = HappyWrap52 (Maybe (Text, PactDocType))
happyIn52 :: (Maybe (Text, PactDocType)) -> (HappyAbsSyn )
happyIn52 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap52 x)
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> HappyWrap52
happyOut52 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut52 #-}
newtype HappyWrap53 = HappyWrap53 (Maybe Type)
happyIn53 :: (Maybe Type) -> (HappyAbsSyn )
happyIn53 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap53 x)
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> HappyWrap53
happyOut53 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut53 #-}
newtype HappyWrap54 = HappyWrap54 (NE.NonEmpty ParsedExpr)
happyIn54 :: (NE.NonEmpty ParsedExpr) -> (HappyAbsSyn )
happyIn54 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap54 x)
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> HappyWrap54
happyOut54 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut54 #-}
newtype HappyWrap55 = HappyWrap55 ([ParsedExpr])
happyIn55 :: ([ParsedExpr]) -> (HappyAbsSyn )
happyIn55 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap55 x)
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> HappyWrap55
happyOut55 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut55 #-}
newtype HappyWrap56 = HappyWrap56 (ParsedExpr)
happyIn56 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn56 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap56 x)
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> HappyWrap56
happyOut56 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut56 #-}
newtype HappyWrap57 = HappyWrap57 (SpanInfo -> ParsedExpr)
happyIn57 :: (SpanInfo -> ParsedExpr) -> (HappyAbsSyn )
happyIn57 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap57 x)
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> HappyWrap57
happyOut57 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut57 #-}
newtype HappyWrap58 = HappyWrap58 (ParsedExpr)
happyIn58 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn58 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap58 x)
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> HappyWrap58
happyOut58 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut58 #-}
newtype HappyWrap59 = HappyWrap59 ([ParsedExpr])
happyIn59 :: ([ParsedExpr]) -> (HappyAbsSyn )
happyIn59 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap59 x)
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> HappyWrap59
happyOut59 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut59 #-}
newtype HappyWrap60 = HappyWrap60 ([ParsedExpr])
happyIn60 :: ([ParsedExpr]) -> (HappyAbsSyn )
happyIn60 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap60 x)
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> HappyWrap60
happyOut60 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut60 #-}
newtype HappyWrap61 = HappyWrap61 ([ParsedExpr])
happyIn61 :: ([ParsedExpr]) -> (HappyAbsSyn )
happyIn61 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap61 x)
{-# INLINE happyIn61 #-}
happyOut61 :: (HappyAbsSyn ) -> HappyWrap61
happyOut61 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut61 #-}
newtype HappyWrap62 = HappyWrap62 (SpanInfo -> ParsedExpr)
happyIn62 :: (SpanInfo -> ParsedExpr) -> (HappyAbsSyn )
happyIn62 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap62 x)
{-# INLINE happyIn62 #-}
happyOut62 :: (HappyAbsSyn ) -> HappyWrap62
happyOut62 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut62 #-}
newtype HappyWrap63 = HappyWrap63 ([MArg SpanInfo])
happyIn63 :: ([MArg SpanInfo]) -> (HappyAbsSyn )
happyIn63 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap63 x)
{-# INLINE happyIn63 #-}
happyOut63 :: (HappyAbsSyn ) -> HappyWrap63
happyOut63 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut63 #-}
newtype HappyWrap64 = HappyWrap64 (SpanInfo -> ParsedExpr)
happyIn64 :: (SpanInfo -> ParsedExpr) -> (HappyAbsSyn )
happyIn64 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap64 x)
{-# INLINE happyIn64 #-}
happyOut64 :: (HappyAbsSyn ) -> HappyWrap64
happyOut64 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut64 #-}
newtype HappyWrap65 = HappyWrap65 ([Binder SpanInfo])
happyIn65 :: ([Binder SpanInfo]) -> (HappyAbsSyn )
happyIn65 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap65 x)
{-# INLINE happyIn65 #-}
happyOut65 :: (HappyAbsSyn ) -> HappyWrap65
happyOut65 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut65 #-}
newtype HappyWrap66 = HappyWrap66 (SpanInfo -> ParsedExpr)
happyIn66 :: (SpanInfo -> ParsedExpr) -> (HappyAbsSyn )
happyIn66 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap66 x)
{-# INLINE happyIn66 #-}
happyOut66 :: (HappyAbsSyn ) -> HappyWrap66
happyOut66 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut66 #-}
newtype HappyWrap67 = HappyWrap67 ([ParsedExpr])
happyIn67 :: ([ParsedExpr]) -> (HappyAbsSyn )
happyIn67 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap67 x)
{-# INLINE happyIn67 #-}
happyOut67 :: (HappyAbsSyn ) -> HappyWrap67
happyOut67 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut67 #-}
newtype HappyWrap68 = HappyWrap68 ([Either ParsedExpr [(Field, MArg SpanInfo)]])
happyIn68 :: ([Either ParsedExpr [(Field, MArg SpanInfo)]]) -> (HappyAbsSyn )
happyIn68 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap68 x)
{-# INLINE happyIn68 #-}
happyOut68 :: (HappyAbsSyn ) -> HappyWrap68
happyOut68 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut68 #-}
newtype HappyWrap69 = HappyWrap69 ([(Field, MArg SpanInfo)])
happyIn69 :: ([(Field, MArg SpanInfo)]) -> (HappyAbsSyn )
happyIn69 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap69 x)
{-# INLINE happyIn69 #-}
happyOut69 :: (HappyAbsSyn ) -> HappyWrap69
happyOut69 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut69 #-}
newtype HappyWrap70 = HappyWrap70 ((Field, MArg SpanInfo))
happyIn70 :: ((Field, MArg SpanInfo)) -> (HappyAbsSyn )
happyIn70 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap70 x)
{-# INLINE happyIn70 #-}
happyOut70 :: (HappyAbsSyn ) -> HappyWrap70
happyOut70 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut70 #-}
newtype HappyWrap71 = HappyWrap71 ([(Field, MArg SpanInfo)])
happyIn71 :: ([(Field, MArg SpanInfo)]) -> (HappyAbsSyn )
happyIn71 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap71 x)
{-# INLINE happyIn71 #-}
happyOut71 :: (HappyAbsSyn ) -> HappyWrap71
happyOut71 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut71 #-}
newtype HappyWrap72 = HappyWrap72 (ParsedExpr)
happyIn72 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn72 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap72 x)
{-# INLINE happyIn72 #-}
happyOut72 :: (HappyAbsSyn ) -> HappyWrap72
happyOut72 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut72 #-}
newtype HappyWrap73 = HappyWrap73 (ParsedExpr)
happyIn73 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn73 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap73 x)
{-# INLINE happyIn73 #-}
happyOut73 :: (HappyAbsSyn ) -> HappyWrap73
happyOut73 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut73 #-}
newtype HappyWrap74 = HappyWrap74 (ParsedExpr)
happyIn74 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn74 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap74 x)
{-# INLINE happyIn74 #-}
happyOut74 :: (HappyAbsSyn ) -> HappyWrap74
happyOut74 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut74 #-}
newtype HappyWrap75 = HappyWrap75 (ParsedName)
happyIn75 :: (ParsedName) -> (HappyAbsSyn )
happyIn75 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap75 x)
{-# INLINE happyIn75 #-}
happyOut75 :: (HappyAbsSyn ) -> HappyWrap75
happyOut75 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut75 #-}
newtype HappyWrap76 = HappyWrap76 (ParsedTyName)
happyIn76 :: (ParsedTyName) -> (HappyAbsSyn )
happyIn76 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap76 x)
{-# INLINE happyIn76 #-}
happyOut76 :: (HappyAbsSyn ) -> HappyWrap76
happyOut76 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut76 #-}
newtype HappyWrap77 = HappyWrap77 ((Text, Maybe Text, SpanInfo))
happyIn77 :: ((Text, Maybe Text, SpanInfo)) -> (HappyAbsSyn )
happyIn77 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap77 x)
{-# INLINE happyIn77 #-}
happyOut77 :: (HappyAbsSyn ) -> HappyWrap77
happyOut77 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut77 #-}
newtype HappyWrap78 = HappyWrap78 (ParsedExpr)
happyIn78 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn78 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap78 x)
{-# INLINE happyIn78 #-}
happyOut78 :: (HappyAbsSyn ) -> HappyWrap78
happyOut78 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut78 #-}
newtype HappyWrap79 = HappyWrap79 (ParsedExpr)
happyIn79 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn79 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap79 x)
{-# INLINE happyIn79 #-}
happyOut79 :: (HappyAbsSyn ) -> HappyWrap79
happyOut79 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut79 #-}
newtype HappyWrap80 = HappyWrap80 (ParsedExpr)
happyIn80 :: (ParsedExpr) -> (HappyAbsSyn )
happyIn80 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap80 x)
{-# INLINE happyIn80 #-}
happyOut80 :: (HappyAbsSyn ) -> HappyWrap80
happyOut80 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut80 #-}
newtype HappyWrap81 = HappyWrap81 ([(Field, ParsedExpr)])
happyIn81 :: ([(Field, ParsedExpr)]) -> (HappyAbsSyn )
happyIn81 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap81 x)
{-# INLINE happyIn81 #-}
happyOut81 :: (HappyAbsSyn ) -> HappyWrap81
happyOut81 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut81 #-}
newtype HappyWrap82 = HappyWrap82 ((Field, ParsedExpr))
happyIn82 :: ((Field, ParsedExpr)) -> (HappyAbsSyn )
happyIn82 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap82 x)
{-# INLINE happyIn82 #-}
happyOut82 :: (HappyAbsSyn ) -> HappyWrap82
happyOut82 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut82 #-}
newtype HappyWrap83 = HappyWrap83 ([(Field, ParsedExpr)])
happyIn83 :: ([(Field, ParsedExpr)]) -> (HappyAbsSyn )
happyIn83 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap83 x)
{-# INLINE happyIn83 #-}
happyOut83 :: (HappyAbsSyn ) -> HappyWrap83
happyOut83 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut83 #-}
newtype HappyWrap84 = HappyWrap84 ([PropertyExpr SpanInfo])
happyIn84 :: ([PropertyExpr SpanInfo]) -> (HappyAbsSyn )
happyIn84 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap84 x)
{-# INLINE happyIn84 #-}
happyOut84 :: (HappyAbsSyn ) -> HappyWrap84
happyOut84 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut84 #-}
newtype HappyWrap85 = HappyWrap85 ([PropertyExpr SpanInfo])
happyIn85 :: ([PropertyExpr SpanInfo]) -> (HappyAbsSyn )
happyIn85 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap85 x)
{-# INLINE happyIn85 #-}
happyOut85 :: (HappyAbsSyn ) -> HappyWrap85
happyOut85 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut85 #-}
newtype HappyWrap86 = HappyWrap86 (PropertyExpr SpanInfo)
happyIn86 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn86 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap86 x)
{-# INLINE happyIn86 #-}
happyOut86 :: (HappyAbsSyn ) -> HappyWrap86
happyOut86 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut86 #-}
newtype HappyWrap87 = HappyWrap87 (PropertyExpr SpanInfo)
happyIn87 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn87 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap87 x)
{-# INLINE happyIn87 #-}
happyOut87 :: (HappyAbsSyn ) -> HappyWrap87
happyOut87 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut87 #-}
newtype HappyWrap88 = HappyWrap88 (PropertyExpr SpanInfo)
happyIn88 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn88 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap88 x)
{-# INLINE happyIn88 #-}
happyOut88 :: (HappyAbsSyn ) -> HappyWrap88
happyOut88 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut88 #-}
newtype HappyWrap89 = HappyWrap89 (PropertyExpr SpanInfo)
happyIn89 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn89 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap89 x)
{-# INLINE happyIn89 #-}
happyOut89 :: (HappyAbsSyn ) -> HappyWrap89
happyOut89 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut89 #-}
newtype HappyWrap90 = HappyWrap90 (PropertyExpr SpanInfo)
happyIn90 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn90 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap90 x)
{-# INLINE happyIn90 #-}
happyOut90 :: (HappyAbsSyn ) -> HappyWrap90
happyOut90 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut90 #-}
newtype HappyWrap91 = HappyWrap91 (PropertyExpr SpanInfo)
happyIn91 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn91 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap91 x)
{-# INLINE happyIn91 #-}
happyOut91 :: (HappyAbsSyn ) -> HappyWrap91
happyOut91 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut91 #-}
newtype HappyWrap92 = HappyWrap92 (PropertyExpr SpanInfo)
happyIn92 :: (PropertyExpr SpanInfo) -> (HappyAbsSyn )
happyIn92 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap92 x)
{-# INLINE happyIn92 #-}
happyOut92 :: (HappyAbsSyn ) -> HappyWrap92
happyOut92 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut92 #-}
newtype HappyWrap93 = HappyWrap93 ((ParsedName, SpanInfo))
happyIn93 :: ((ParsedName, SpanInfo)) -> (HappyAbsSyn )
happyIn93 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap93 x)
{-# INLINE happyIn93 #-}
happyOut93 :: (HappyAbsSyn ) -> HappyWrap93
happyOut93 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut93 #-}
happyInTok :: (PosToken) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (PosToken)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


{-# NOINLINE happyTokenStrings #-}
happyTokenStrings = ["let","letstar","lam","module","interface","import","defun","defcap","defconst","defschema","deftable","defpact","bless","implements","true","false","docAnn","modelAnn","eventAnn","managedAnn","step","steprb","'{'","'}'","'('","')'","'['","']'","','","'::'","':'","':='","'.'","IDENT","NUM","STR","TICK","%eof"]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\xf8\x00\x00\x00\xfe\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x01\x00\x00\xf3\xff\xff\xff\xf3\xff\xff\xff\xd6\x01\x00\x00\xf3\xff\xff\xff\x07\x00\x00\x00\xf5\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\x00\x00\x00\xcb\x00\x00\x00\xed\x01\x00\x00\xbe\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\x00\x00\x00\x35\x00\x00\x00\x75\x00\x00\x00\x65\x00\x00\x00\x7d\x00\x00\x00\x00\x00\x00\x00\xbf\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x98\x00\x00\x00\x9a\x00\x00\x00\xb6\x00\x00\x00\x00\x00\x00\x00\xdc\x00\x00\x00\x00\x00\x00\x00\xc6\x00\x00\x00\xd7\x00\x00\x00\xe7\x00\x00\x00\xf0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6a\x00\x00\x00\x00\x00\x00\x00\x7a\x00\x00\x00\xf2\x00\x00\x00\xf6\x00\x00\x00\x10\x01\x00\x00\x1e\x01\x00\x00\x14\x01\x00\x00\x1a\x01\x00\x00\xa2\x00\x00\x00\xed\x01\x00\x00\xed\x01\x00\x00\x86\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3c\x01\x00\x00\x3c\x01\x00\x00\x00\x00\x00\x00\xf3\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x4a\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x41\x01\x00\x00\x00\x00\x00\x00\x40\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x97\x00\x00\x00\x42\x01\x00\x00\x50\x01\x00\x00\x48\x01\x00\x00\xe8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x51\x01\x00\x00\x51\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf6\xff\xff\xff\x01\x00\x00\x00\x64\x01\x00\x00\x00\x00\x00\x00\x68\x01\x00\x00\x65\x01\x00\x00\x63\x01\x00\x00\x71\x01\x00\x00\x00\x00\x00\x00\x77\x01\x00\x00\x00\x00\x00\x00\x7f\x01\x00\x00\x86\x01\x00\x00\x0b\x00\x00\x00\x04\x02\x00\x00\x8b\x01\x00\x00\x04\x02\x00\x00\x8e\x01\x00\x00\x95\x01\x00\x00\x04\x02\x00\x00\x93\x01\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x41\x00\x00\x00\xbd\x01\x00\x00\xfa\x01\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9e\x01\x00\x00\x9e\x01\x00\x00\x00\x00\x00\x00\xb9\x00\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\xa6\x01\x00\x00\x0b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb0\x01\x00\x00\xba\x01\x00\x00\x00\x00\x00\x00\x28\x02\x00\x00\xf2\xff\xff\xff\x00\x00\x00\x00\xc1\x01\x00\x00\x0b\x00\x00\x00\xc7\x01\x00\x00\x00\x00\x00\x00\xcd\x01\x00\x00\x2e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x02\x00\x00\x00\x00\x00\x00\x39\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd8\x01\x00\x00\xda\x01\x00\x00\xeb\x01\x00\x00\xef\x01\x00\x00\xf1\x01\x00\x00\xce\x01\x00\x00\xd4\x01\x00\x00\xe5\x01\x00\x00\xfc\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x02\x00\x00\xa6\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x22\x02\x00\x00\x37\x02\x00\x00\x36\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x02\x00\x00\x48\x02\x00\x00\x4d\x02\x00\x00\x52\x02\x00\x00\x57\x02\x00\x00\x5c\x02\x00\x00\x3b\x02\x00\x00\x59\x02\x00\x00\x5e\x02\x00\x00\x00\x02\x00\x00\x68\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\x6d\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x71\x02\x00\x00\x72\x02\x00\x00\x00\x00\x00\x00\xee\x01\x00\x00\x00\x00\x00\x00\x0b\x00\x00\x00\x00\x00\x00\x00\x79\x02\x00\x00\x7a\x02\x00\x00\x7b\x02\x00\x00\x77\x02\x00\x00\x78\x02\x00\x00\x7c\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\x7d\x02\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xca\x00\x00\x00\x7e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x02\x00\x00\x01\x00\x00\x00\x81\x02\x00\x00\x81\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x02\x00\x00\x88\x02\x00\x00\x00\x00\x00\x00\x89\x02\x00\x00\x76\x02\x00\x00\x85\x02\x00\x00\x87\x02\x00\x00\x05\x00\x00\x00\x95\x00\x00\x00\x04\x02\x00\x00\x87\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\x02\x00\x00\x8a\x02\x00\x00\x8d\x02\x00\x00\x8c\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x19\x00\x00\x00\x34\x00\x00\x00\x8f\x02\x00\x00\x3b\x00\x00\x00\x6e\x00\x00\x00\x90\x02\x00\x00\x53\x01\x00\x00\x78\x00\x00\x00\x01\x00\x00\x00\x91\x02\x00\x00\x92\x02\x00\x00\xf2\xff\xff\xff\x01\x00\x00\x00\x01\x00\x00\x00\x0b\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x6b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x02\x00\x00\x00\x00\x00\x00\x93\x02\x00\x00\x00\x00\x00\x00\x6c\x02\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x94\x02\x00\x00\x00\x00\x00\x00\x95\x02\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\x04\x02\x00\x00\x00\x00\x00\x00\x04\x02\x00\x00\xdc\x01\x00\x00\x00\x00\x00\x00\x97\x02\x00\x00\x00\x00\x00\x00\x98\x02\x00\x00\xdc\x01\x00\x00\x9b\x02\x00\x00\x99\x02\x00\x00\x9e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9f\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x91\x00\x00\x00\xa8\x02\x00\x00\x82\x02\x00\x00\x86\x02\x00\x00\x9a\x02\x00\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf7\xff\xff\xff\x1f\x01\x00\x00\x28\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x02\x00\x00\xe5\xff\xff\xff\x00\x00\x00\x00\x7f\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x00\x00\x00\x00\x00\x00\x1f\x01\x00\x00\x00\x00\x00\x00\x62\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x02\x00\x00\xbb\x00\x00\x00\x4e\x01\x00\x00\x69\x02\x00\x00\x00\x00\x00\x00\x96\x02\x00\x00\x9c\x02\x00\x00\x9d\x02\x00\x00\x00\x00\x00\x00\x3b\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x57\x01\x00\x00\x44\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe3\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa1\x02\x00\x00\xa2\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa9\x02\x00\x00\x30\x02\x00\x00\xa0\x02\x00\x00\x00\x00\x00\x00\xa4\x02\x00\x00\x68\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa7\x02\x00\x00\xaa\x02\x00\x00\x00\x00\x00\x00\xa3\x02\x00\x00\x61\x01\x00\x00\x43\x02\x00\x00\xc4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdf\x00\x00\x00\xa5\x02\x00\x00\xe8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6a\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa6\x02\x00\x00\xad\x02\x00\x00\x00\x00\x00\x00\xab\x02\x00\x00\x00\x00\x00\x00\x74\x01\x00\x00\x00\x00\x00\x00\x7d\x01\x00\x00\x00\x00\x00\x00\xac\x02\x00\x00\xae\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6b\x00\x00\x00\x00\x00\x00\x00\x31\x02\x00\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xaf\x02\x00\x00\x00\x00\x00\x00\xb5\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x00\x00\x00\x00\x00\x00\x00\x1f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xea\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x02\x00\x00\xb0\x02\x00\x00\x00\x00\x00\x00\xe7\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb8\x02\x00\x00\xb1\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb3\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb2\x02\x00\x00\x00\x00\x00\x00\xb4\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x02\x00\x00\x74\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb6\x02\x00\x00\x3a\x02\x00\x00\xb9\x02\x00\x00\xba\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbc\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbb\x02\x00\x00\xea\x01\x00\x00\xea\x01\x00\x00\x03\x01\x00\x00\xbd\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc0\x02\x00\x00\xc1\x02\x00\x00\xc2\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc3\x02\x00\x00\x00\x00\x00\x00\xc6\x02\x00\x00\xc8\x02\x00\x00\xc9\x02\x00\x00\xc9\x02\x00\x00\x00\x00\x00\x00\xc9\x02\x00\x00\xc9\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc9\x02\x00\x00\x3f\x02\x00\x00\x00\x00\x00\x00\xc4\x02\x00\x00\x7b\x00\x00\x00\x44\x02\x00\x00\x49\x02\x00\x00\xca\x02\x00\x00\x4e\x02\x00\x00\x53\x02\x00\x00\x00\x00\x00\x00\xb5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x27\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x01\x00\x00\x00\x00\x00\x00\xbf\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc5\x02\x00\x00\x00\x00\x00\x00\x90\x01\x00\x00\x9a\x01\x00\x00\x00\x00\x00\x00\xa3\x01\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x65\x02\x00\x00\xb8\x00\x00\x00\x00\x00\x00\x00\x67\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\xf6\xff\xff\xff\xf9\xff\xff\xff\x00\x00\x00\x00\xfb\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\xff\xff\xff\x94\xff\xff\xff\x72\xff\xff\xff\x76\xff\xff\xff\x75\xff\xff\xff\x74\xff\xff\xff\x71\xff\xff\xff\x6f\xff\xff\xff\x6e\xff\xff\xff\x59\xff\xff\xff\x00\x00\x00\x00\x8e\xff\xff\xff\x6c\xff\xff\xff\x62\xff\xff\xff\x61\xff\xff\xff\x60\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7f\xff\xff\xff\x00\x00\x00\x00\x7c\xff\xff\xff\x00\x00\x00\x00\x93\xff\xff\xff\x92\xff\xff\xff\x91\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\xff\xff\xff\x00\x00\x00\x00\x5a\xff\xff\xff\x5e\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf1\xff\xff\xff\xf7\xff\xff\xff\xf5\xff\xff\xff\xf4\xff\xff\xff\xf2\xff\xff\xff\xf3\xff\xff\xff\x00\x00\x00\x00\xfa\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5f\xff\xff\xff\x86\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x95\xff\xff\xff\x81\xff\xff\xff\x90\xff\xff\xff\x8f\xff\xff\xff\x8c\xff\xff\xff\x00\x00\x00\x00\x6d\xff\xff\xff\x64\xff\xff\xff\x6b\xff\xff\xff\x63\xff\xff\xff\x00\x00\x00\x00\x8a\xff\xff\xff\x8d\xff\xff\xff\x80\xff\xff\xff\x7e\xff\xff\xff\x7d\xff\xff\xff\x59\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5b\xff\xff\xff\x5d\xff\xff\xff\x5c\xff\xff\xff\x9e\xff\xff\xff\xee\xff\xff\xff\xed\xff\xff\xff\xec\xff\xff\xff\xeb\xff\xff\xff\x99\xff\xff\xff\x99\xff\xff\xff\xf0\xff\xff\xff\xef\xff\xff\xff\xcb\xff\xff\xff\x9e\xff\xff\xff\xa1\xff\xff\xff\x9f\xff\xff\xff\xa0\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa7\xff\xff\xff\x00\x00\x00\x00\xc9\xff\xff\xff\xcb\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x99\xff\xff\xff\x00\x00\x00\x00\x77\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x65\xff\xff\xff\x8b\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x7b\xff\xff\xff\x00\x00\x00\x00\x85\xff\xff\xff\x98\xff\xff\xff\x96\xff\xff\xff\x00\x00\x00\x00\x84\xff\xff\xff\x99\xff\xff\xff\x00\x00\x00\x00\x89\xff\xff\xff\xdf\xff\xff\xff\xe8\xff\xff\xff\x00\x00\x00\x00\xe3\xff\xff\xff\xe0\xff\xff\xff\x00\x00\x00\x00\x9b\xff\xff\xff\x9a\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xab\xff\xff\xff\xb4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe5\xff\xff\xff\x56\xff\xff\xff\xa8\xff\xff\xff\xd5\xff\xff\xff\x00\x00\x00\x00\xd6\xff\xff\xff\x00\x00\x00\x00\xa2\xff\xff\xff\xa3\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd7\xff\xff\xff\xd8\xff\xff\xff\xe9\xff\xff\xff\x00\x00\x00\x00\x58\xff\xff\xff\xcc\xff\xff\xff\xca\xff\xff\xff\xe4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\xff\xff\xff\x9c\xff\xff\xff\xc8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe1\xff\xff\xff\xe2\xff\xff\xff\xea\xff\xff\xff\x88\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x97\xff\xff\xff\x78\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x7a\xff\xff\xff\xb2\xff\xff\xff\x79\xff\xff\xff\x00\x00\x00\x00\x82\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\xff\xff\xff\x00\x00\x00\x00\x99\xff\xff\xff\xd9\xff\xff\xff\xdc\xff\xff\xff\xda\xff\xff\xff\xdb\xff\xff\xff\xde\xff\xff\xff\xdd\xff\xff\xff\x00\x00\x00\x00\xa9\xff\xff\xff\xae\xff\xff\xff\x00\x00\x00\x00\x66\xff\xff\xff\xb5\xff\xff\xff\x9e\xff\xff\xff\x57\xff\xff\xff\x55\xff\xff\xff\x4f\xff\xff\xff\x4e\xff\xff\xff\x4d\xff\xff\xff\x51\xff\xff\xff\x50\xff\xff\xff\x52\xff\xff\xff\x4c\xff\xff\xff\x4b\xff\xff\xff\x46\xff\xff\xff\x45\xff\xff\xff\x4a\xff\xff\xff\x49\xff\xff\xff\x56\xff\xff\xff\x56\xff\xff\xff\x47\xff\xff\xff\x48\xff\xff\xff\x3f\xff\xff\xff\x43\xff\xff\xff\x42\xff\xff\xff\x41\xff\xff\xff\xa4\xff\xff\xff\x99\xff\xff\xff\x9e\xff\xff\xff\x99\xff\xff\xff\x99\xff\xff\xff\xd1\xff\xff\xff\xd3\xff\xff\xff\xd0\xff\xff\xff\xd2\xff\xff\xff\xd4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xaf\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xac\xff\xff\xff\xad\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe6\xff\xff\xff\xe7\xff\xff\xff\x83\xff\xff\xff\xb3\xff\xff\xff\xb4\xff\xff\xff\x00\x00\x00\x00\xb4\xff\xff\xff\xaa\xff\xff\xff\x67\xff\xff\xff\xc7\xff\xff\xff\x54\xff\xff\xff\x53\xff\xff\xff\x40\xff\xff\xff\x3e\xff\xff\xff\x44\xff\xff\xff\xb4\xff\xff\xff\xc6\xff\xff\xff\xb4\xff\xff\xff\xb4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xb0\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x69\xff\xff\xff\x00\x00\x00\x00\x9e\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x9b\xff\xff\xff\x9e\xff\xff\xff\x9e\xff\xff\xff\x00\x00\x00\x00\x9e\xff\xff\xff\x9e\xff\xff\xff\xcf\xff\xff\xff\xb9\xff\xff\xff\xb1\xff\xff\xff\xcd\xff\xff\xff\xb9\xff\xff\xff\xc5\xff\xff\xff\x6a\xff\xff\xff\x68\xff\xff\xff\x00\x00\x00\x00\xc3\xff\xff\xff\xc2\xff\xff\xff\xc0\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xbb\xff\xff\xff\xba\xff\xff\xff\xb6\xff\xff\xff\xb8\xff\xff\xff\xce\xff\xff\xff\x00\x00\x00\x00\xc4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc1\xff\xff\xff\x00\x00\x00\x00\xa5\xff\xff\xff\xb7\xff\xff\xff\x00\x00\x00\x00\xa6\xff\xff\xff\xa5\xff\xff\xff\xa5\xff\xff\xff\x00\x00\x00\x00\xa5\xff\xff\xff\x00\x00\x00\x00\xbf\xff\xff\xff\xbe\xff\xff\xff\x00\x00\x00\x00\xbd\xff\xff\xff\xbc\xff\xff\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\xff\xff\x04\x00\x00\x00\x05\x00\x00\x00\x1b\x00\x00\x00\x12\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x02\x00\x00\x00\x0b\x00\x00\x00\x04\x00\x00\x00\x04\x00\x00\x00\x23\x00\x00\x00\x05\x00\x00\x00\x26\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x05\x00\x00\x00\x0b\x00\x00\x00\x1c\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x25\x00\x00\x00\x1a\x00\x00\x00\x34\x00\x00\x00\x27\x00\x00\x00\x25\x00\x00\x00\x27\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x3b\x00\x00\x00\x1c\x00\x00\x00\x1d\x00\x00\x00\x1e\x00\x00\x00\x22\x00\x00\x00\x20\x00\x00\x00\x25\x00\x00\x00\x1c\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x45\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x1b\x00\x00\x00\x1b\x00\x00\x00\x16\x00\x00\x00\x30\x00\x00\x00\x18\x00\x00\x00\x32\x00\x00\x00\x16\x00\x00\x00\x17\x00\x00\x00\x23\x00\x00\x00\x23\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x49\x00\x00\x00\x4a\x00\x00\x00\x4b\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x29\x00\x00\x00\x2a\x00\x00\x00\x1d\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x1b\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x30\x00\x00\x00\x31\x00\x00\x00\x32\x00\x00\x00\x1b\x00\x00\x00\x23\x00\x00\x00\x23\x00\x00\x00\x36\x00\x00\x00\x19\x00\x00\x00\x38\x00\x00\x00\x24\x00\x00\x00\x3a\x00\x00\x00\x23\x00\x00\x00\x1e\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x0b\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x0e\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x18\x00\x00\x00\x1e\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x2c\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x23\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x02\x00\x00\x00\x23\x00\x00\x00\x04\x00\x00\x00\x1d\x00\x00\x00\x23\x00\x00\x00\x19\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x1e\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x0b\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x2c\x00\x00\x00\x02\x00\x00\x00\x10\x00\x00\x00\x04\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x1a\x00\x00\x00\x1e\x00\x00\x00\x1a\x00\x00\x00\x20\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x30\x00\x00\x00\x1c\x00\x00\x00\x32\x00\x00\x00\x1e\x00\x00\x00\x23\x00\x00\x00\x20\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x1a\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x1f\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x1b\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x1f\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x22\x00\x00\x00\x29\x00\x00\x00\x2a\x00\x00\x00\x18\x00\x00\x00\x1e\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x30\x00\x00\x00\x1f\x00\x00\x00\x32\x00\x00\x00\x30\x00\x00\x00\x22\x00\x00\x00\x32\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\x30\x00\x00\x00\x19\x00\x00\x00\x32\x00\x00\x00\x20\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x20\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\x30\x00\x00\x00\x18\x00\x00\x00\x32\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x23\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x1c\x00\x00\x00\x1d\x00\x00\x00\x1e\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x1b\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\x30\x00\x00\x00\x18\x00\x00\x00\x32\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x1b\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x1f\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x31\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x36\x00\x00\x00\x1a\x00\x00\x00\x38\x00\x00\x00\x30\x00\x00\x00\x3a\x00\x00\x00\x32\x00\x00\x00\x33\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1e\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x23\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x22\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x20\x00\x00\x00\x1f\x00\x00\x00\x23\x00\x00\x00\x30\x00\x00\x00\x22\x00\x00\x00\x32\x00\x00\x00\x13\x00\x00\x00\x3d\x00\x00\x00\x35\x00\x00\x00\x12\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1a\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x25\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x1c\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1b\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1c\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x1a\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1a\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x20\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x20\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x23\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x20\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1b\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x30\x00\x00\x00\x1a\x00\x00\x00\x32\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x18\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x18\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x41\x00\x00\x00\x42\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x1b\x00\x00\x00\x46\x00\x00\x00\x47\x00\x00\x00\x48\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x18\x00\x00\x00\x13\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x1b\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x1b\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x00\x00\x1a\x00\x00\x00\x20\x00\x00\x00\x1c\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x1c\x00\x00\x00\x3e\x00\x00\x00\x3f\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x1d\x00\x00\x00\x49\x00\x00\x00\x4a\x00\x00\x00\x4b\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x4e\x00\x00\x00\x4f\x00\x00\x00\x50\x00\x00\x00\x51\x00\x00\x00\x52\x00\x00\x00\x53\x00\x00\x00\x54\x00\x00\x00\x55\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x23\x00\x00\x00\x0d\x00\x00\x00\x16\x00\x00\x00\x17\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1d\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x23\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x23\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x1b\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x23\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x23\x00\x00\x00\x16\x00\x00\x00\x17\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x1b\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x23\x00\x00\x00\x4c\x00\x00\x00\x4d\x00\x00\x00\x29\x00\x00\x00\x2a\x00\x00\x00\x29\x00\x00\x00\x2a\x00\x00\x00\x21\x00\x00\x00\x21\x00\x00\x00\x1b\x00\x00\x00\x1b\x00\x00\x00\x1b\x00\x00\x00\x20\x00\x00\x00\x20\x00\x00\x00\x19\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x20\x00\x00\x00\x45\x00\x00\x00\x1a\x00\x00\x00\x22\x00\x00\x00\x22\x00\x00\x00\x20\x00\x00\x00\x1a\x00\x00\x00\x1a\x00\x00\x00\x1a\x00\x00\x00\x18\x00\x00\x00\x1a\x00\x00\x00\x45\x00\x00\x00\x23\x00\x00\x00\x19\x00\x00\x00\x23\x00\x00\x00\x13\x00\x00\x00\x13\x00\x00\x00\x1a\x00\x00\x00\x23\x00\x00\x00\x20\x00\x00\x00\x08\x00\x00\x00\x23\x00\x00\x00\x1b\x00\x00\x00\x4a\x00\x00\x00\x23\x00\x00\x00\x23\x00\x00\x00\x1b\x00\x00\x00\x23\x00\x00\x00\x23\x00\x00\x00\x1b\x00\x00\x00\x1b\x00\x00\x00\x3c\x00\x00\x00\x15\x00\x00\x00\x14\x00\x00\x00\x14\x00\x00\x00\x07\x00\x00\x00\x4d\x00\x00\x00\x4d\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x00\x00\x23\x00\x00\x00\x2a\x00\x00\x00\x27\x00\x00\x00\xff\xff\xff\xff\x37\x00\x00\x00\x2d\x00\x00\x00\x2d\x00\x00\x00\x23\x00\x00\x00\xff\xff\xff\xff\x2d\x00\x00\x00\x25\x00\x00\x00\x25\x00\x00\x00\x39\x00\x00\x00\x39\x00\x00\x00\x22\x00\x00\x00\x25\x00\x00\x00\x2d\x00\x00\x00\x23\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1e\x00\x00\x00\xff\xff\xff\xff\x2d\x00\x00\x00\x24\x00\x00\x00\x2d\x00\x00\x00\x22\x00\x00\x00\x2d\x00\x00\x00\x22\x00\x00\x00\x22\x00\x00\x00\x2d\x00\x00\x00\x2d\x00\x00\x00\x22\x00\x00\x00\x3e\x00\x00\x00\x22\x00\x00\x00\xff\xff\xff\xff\x23\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\x25\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x44\x00\x00\x00\xff\xff\xff\xff\x45\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x45\x00\x00\x00\xff\xff\xff\xff\x45\x00\x00\x00\x45\x00\x00\x00\x43\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x43\x00\x00\x00\x45\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x00\x00\x30\x00\x00\x00\x31\x00\x00\x00\x79\x00\x00\x00\x6f\x00\x00\x00\x32\x00\x00\x00\x33\x00\x00\x00\xf6\x00\x00\x00\x34\x00\x00\x00\xf7\x00\x00\x00\x37\x00\x00\x00\x7a\x00\x00\x00\x30\x00\x00\x00\xe6\x00\x00\x00\x32\x00\x00\x00\x33\x00\x00\x00\x9a\x00\x00\x00\x34\x00\x00\x00\x73\x00\x00\x00\x6f\x00\x00\x00\x70\x00\x00\x00\xf8\x00\x00\x00\xf9\x00\x00\x00\x71\x00\x00\x00\x0b\x00\x00\x00\x4a\x00\x00\x00\xff\xff\xff\xff\x74\x00\x00\x00\xff\xff\xff\xff\xfa\x00\x00\x00\xfb\x00\x00\x00\xfc\x00\x00\x00\x4b\x00\x00\x00\xfd\x00\x00\x00\x2a\x01\x00\x00\xfe\x00\x00\x00\x1d\x00\x00\x00\xff\x00\x00\x00\x71\x00\x00\x00\x9b\x00\x00\x00\x00\x01\x00\x00\x01\x01\x00\x00\x02\x01\x00\x00\x03\x01\x00\x00\xe7\x00\x00\x00\x35\x00\x00\x00\x9c\x00\x00\x00\x0c\x00\x00\x00\xa8\x00\x00\x00\xa9\x00\x00\x00\xaa\x00\x00\x00\xed\x00\x00\x00\x42\x01\x00\x00\xab\x00\x00\x00\x35\x00\x00\x00\xac\x00\x00\x00\x0c\x00\x00\x00\x3b\x00\x00\x00\x3c\x00\x00\x00\xd7\x00\x00\x00\xd7\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x2c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x5d\x01\x00\x00\x5e\x01\x00\x00\xb7\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x41\x01\x00\x00\x5f\x01\x00\x00\xb8\x00\x00\x00\x0c\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x0c\x00\x00\x00\x3f\x01\x00\x00\xd7\x00\x00\x00\x50\x00\x00\x00\x23\x00\x00\x00\x88\x00\x00\x00\x24\x00\x00\x00\x51\x00\x00\x00\x25\x00\x00\x00\xd7\x00\x00\x00\x89\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x29\x00\x00\x00\x30\x00\x00\x00\x3a\x00\x00\x00\x3b\x00\x00\x00\x3e\x00\x00\x00\xa2\x00\x00\x00\x3f\x00\x00\x00\xcb\x00\x00\x00\x92\x00\x00\x00\xa3\x00\x00\x00\xa4\x00\x00\x00\xcc\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x29\x00\x00\x00\x30\x00\x00\x00\x3a\x00\x00\x00\x3b\x00\x00\x00\x16\x00\x00\x00\x4d\x00\x00\x00\x17\x00\x00\x00\x2a\x00\x00\x00\x18\x00\x00\x00\xbd\x00\x00\x00\xbe\x00\x00\x00\x3e\x01\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\xbf\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\xd7\x00\x00\x00\x16\x00\x00\x00\x3a\x01\x00\x00\x17\x00\x00\x00\x2a\x00\x00\x00\x18\x00\x00\x00\xf6\x00\x00\x00\x4f\x00\x00\x00\xf7\x00\x00\x00\x4a\x00\x00\x00\xd7\x00\x00\x00\x1a\x01\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x1b\x01\x00\x00\xbd\x00\x00\x00\xbe\x00\x00\x00\xb1\x00\x00\x00\xf8\x00\x00\x00\xf9\x00\x00\x00\x47\x01\x00\x00\xf6\x00\x00\x00\xb2\x00\x00\x00\xf7\x00\x00\x00\x2e\x00\x00\x00\x2f\x00\x00\x00\xfa\x00\x00\x00\xfb\x00\x00\x00\xfc\x00\x00\x00\x29\x01\x00\x00\xfd\x00\x00\x00\x47\x00\x00\x00\xfe\x00\x00\x00\x46\x00\x00\x00\xff\x00\x00\x00\xf8\x00\x00\x00\xf9\x00\x00\x00\x00\x01\x00\x00\x01\x01\x00\x00\x02\x01\x00\x00\x03\x01\x00\x00\x81\x00\x00\x00\x82\x00\x00\x00\xfa\x00\x00\x00\xfb\x00\x00\x00\xfc\x00\x00\x00\x0b\x00\x00\x00\xfd\x00\x00\x00\x0c\x00\x00\x00\xfe\x00\x00\x00\x62\x00\x00\x00\xff\x00\x00\x00\x63\x00\x00\x00\x64\x00\x00\x00\x00\x01\x00\x00\x01\x01\x00\x00\x02\x01\x00\x00\x03\x01\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x29\x00\x00\x00\x45\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x54\x01\x00\x00\x50\x01\x00\x00\x51\x01\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x48\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x1e\x00\x00\x00\xd4\x00\x00\x00\xd5\x00\x00\x00\x1f\x00\x00\x00\x61\x01\x00\x00\x5e\x01\x00\x00\x16\x00\x00\x00\x43\x00\x00\x00\x17\x00\x00\x00\x2a\x00\x00\x00\x18\x00\x00\x00\x62\x01\x00\x00\x13\x01\x00\x00\x0c\x00\x00\x00\x5e\x00\x00\x00\x14\x01\x00\x00\x0c\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x90\x00\x00\x00\x8a\x00\x00\x00\x8b\x00\x00\x00\x44\x00\x00\x00\x0c\x00\x00\x00\x42\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x41\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x8d\x00\x00\x00\x8a\x00\x00\x00\x8b\x00\x00\x00\x16\x00\x00\x00\x0c\x00\x00\x00\x17\x00\x00\x00\x40\x00\x00\x00\x18\x00\x00\x00\x6a\x00\x00\x00\x89\x00\x00\x00\x8a\x00\x00\x00\x8b\x00\x00\x00\x4f\x00\x00\x00\x0c\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x4b\x01\x00\x00\x4c\x01\x00\x00\x4d\x01\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x68\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x27\x01\x00\x00\x8a\x00\x00\x00\x8b\x00\x00\x00\x16\x00\x00\x00\x0c\x00\x00\x00\x39\x00\x00\x00\x66\x00\x00\x00\x18\x00\x00\x00\x67\x00\x00\x00\x56\x01\x00\x00\x8a\x00\x00\x00\x8b\x00\x00\x00\x65\x00\x00\x00\x0c\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x4f\x01\x00\x00\x50\x01\x00\x00\x51\x01\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x23\x00\x00\x00\x5a\x00\x00\x00\x24\x00\x00\x00\x1f\x00\x00\x00\x25\x00\x00\x00\x0c\x00\x00\x00\x20\x00\x00\x00\x7b\x00\x00\x00\x7e\x00\x00\x00\x83\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x7b\x00\x00\x00\x7c\x00\x00\x00\x84\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x55\x00\x00\x00\x52\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x76\x00\x00\x00\x3b\x01\x00\x00\x7d\x00\x00\x00\x52\x00\x00\x00\x3c\x01\x00\x00\x0c\x00\x00\x00\x70\x00\x00\x00\x56\x00\x00\x00\x53\x00\x00\x00\x6f\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x5d\x00\x00\x00\xa6\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x54\x00\x00\x00\xa2\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\xa1\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x97\x00\x00\x00\xa0\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x84\x00\x00\x00\x73\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x9d\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\xd1\x00\x00\x00\x97\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\xd0\x00\x00\x00\x90\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x76\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\xda\x00\x00\x00\x8f\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x5b\x01\x00\x00\xd7\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x76\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x5a\x01\x00\x00\xce\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x60\x01\x00\x00\x97\x00\x00\x00\x0c\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\xbd\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x42\x00\x00\x00\x87\x00\x00\x00\xbb\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\xb9\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x16\x00\x00\x00\x70\x00\x00\x00\x37\x00\x00\x00\x08\x01\x00\x00\x18\x00\x00\x00\x0d\x01\x00\x00\x16\x00\x00\x00\x0c\x01\x00\x00\x17\x00\x00\x00\x07\x01\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x16\x00\x00\x00\x0b\x01\x00\x00\x17\x00\x00\x00\x06\x01\x00\x00\x18\x00\x00\x00\x0a\x01\x00\x00\x58\x00\x00\x00\x09\x01\x00\x00\x17\x00\x00\x00\xd9\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x41\x00\x00\x00\x86\x00\x00\x00\x16\x00\x00\x00\xe6\x00\x00\x00\x17\x00\x00\x00\x05\x01\x00\x00\x18\x00\x00\x00\x7e\x00\x00\x00\x7f\x00\x00\x00\xa6\x00\x00\x00\xb4\x00\x00\x00\x63\x00\x00\x00\x64\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x04\x01\x00\x00\x2a\x00\x00\x00\x2b\x00\x00\x00\x2c\x00\x00\x00\x3b\x00\x00\x00\x3e\x00\x00\x00\xc7\x00\x00\x00\x3f\x00\x00\x00\xb0\x00\x00\x00\xc8\x00\x00\x00\xc9\x00\x00\x00\xca\x00\x00\x00\xcb\x00\x00\x00\xed\x00\x00\x00\xee\x00\x00\x00\xef\x00\x00\x00\xf0\x00\x00\x00\xf1\x00\x00\x00\xf2\x00\x00\x00\xf3\x00\x00\x00\xf4\x00\x00\x00\x3b\x00\x00\x00\xae\x00\x00\x00\xaf\x00\x00\x00\x3f\x00\x00\x00\xb0\x00\x00\x00\xeb\x00\x00\x00\xb1\x00\x00\x00\xc0\x00\x00\x00\xc1\x00\x00\x00\xc2\x00\x00\x00\xc3\x00\x00\x00\xc4\x00\x00\x00\xc5\x00\x00\x00\x91\x00\x00\x00\x92\x00\x00\x00\x93\x00\x00\x00\x94\x00\x00\x00\x95\x00\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe9\x00\x00\x00\x6c\x00\x00\x00\x77\x00\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\x4f\x00\x00\x00\x6c\x00\x00\x00\x6d\x00\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe0\x00\x00\x00\x6c\x00\x00\x00\x16\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe5\x00\x00\x00\x6c\x00\x00\x00\x0f\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe4\x00\x00\x00\x6c\x00\x00\x00\x4a\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe3\x00\x00\x00\x6c\x00\x00\x00\x46\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe2\x00\x00\x00\x6c\x00\x00\x00\x45\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xe1\x00\x00\x00\x6c\x00\x00\x00\x43\x01\x00\x00\x6a\x00\x00\x00\x6b\x00\x00\x00\xdf\x00\x00\x00\x6c\x00\x00\x00\x42\x01\x00\x00\x53\x01\x00\x00\x54\x01\x00\x00\xde\x00\x00\x00\x58\x01\x00\x00\x59\x01\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x06\x00\x00\x00\x05\x00\x00\x00\xda\x00\x00\x00\x5f\x00\x00\x00\x60\x00\x00\x00\x4f\x00\x00\x00\xb4\x00\x00\x00\xb5\x00\x00\x00\x63\x01\x00\x00\x5e\x01\x00\x00\x66\x01\x00\x00\x5e\x01\x00\x00\x87\x00\x00\x00\x86\x00\x00\x00\x21\x01\x00\x00\x20\x01\x00\x00\x1f\x01\x00\x00\x76\x00\x00\x00\x1d\x01\x00\x00\x19\x01\x00\x00\x2d\x01\x00\x00\x05\x00\x00\x00\x76\x00\x00\x00\x4d\x00\x00\x00\x31\x01\x00\x00\x18\x01\x00\x00\x12\x01\x00\x00\x76\x00\x00\x00\x30\x01\x00\x00\x2e\x01\x00\x00\x25\x01\x00\x00\x24\x01\x00\x00\x23\x01\x00\x00\x68\x00\x00\x00\x2c\x01\x00\x00\x3d\x01\x00\x00\x4f\x00\x00\x00\x70\x00\x00\x00\x70\x00\x00\x00\x4f\x01\x00\x00\x38\x01\x00\x00\x40\x01\x00\x00\x09\x00\x00\x00\x34\x01\x00\x00\x65\x01\x00\x00\x5c\x00\x00\x00\x4a\x01\x00\x00\x4f\x00\x00\x00\x68\x01\x00\x00\x56\x01\x00\x00\x38\x01\x00\x00\x66\x01\x00\x00\x69\x01\x00\x00\x48\x00\x00\x00\x9e\x00\x00\x00\x71\x00\x00\x00\x9d\x00\x00\x00\xdc\x00\x00\x00\x15\x01\x00\x00\x14\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x98\x00\x00\x00\xd7\x00\x00\x00\xa7\x00\x00\x00\xa6\x00\x00\x00\x00\x00\x00\x00\x5b\x00\x00\x00\x76\x00\x00\x00\x74\x00\x00\x00\xd5\x00\x00\x00\x00\x00\x00\x00\x8c\x00\x00\x00\xce\x00\x00\x00\xbb\x00\x00\x00\x5a\x00\x00\x00\x58\x00\x00\x00\xb9\x00\x00\x00\x21\x01\x00\x00\xcf\x00\x00\x00\xeb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x59\x01\x00\x00\x00\x00\x00\x00\x1d\x01\x00\x00\x2e\x01\x00\x00\x1b\x01\x00\x00\x38\x01\x00\x00\x10\x01\x00\x00\x35\x01\x00\x00\x34\x01\x00\x00\x0e\x01\x00\x00\x0d\x01\x00\x00\x32\x01\x00\x00\xd2\x00\x00\x00\x31\x01\x00\x00\x00\x00\x00\x00\xeb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x44\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\x00\x00\x00\x00\x00\x00\x00\xdb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2a\x01\x00\x00\x00\x00\x00\x00\x26\x01\x00\x00\x25\x01\x00\x00\x36\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5c\x01\x00\x00\x48\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (4, 193) [
        (4 , happyReduce_4),
        (5 , happyReduce_5),
        (6 , happyReduce_6),
        (7 , happyReduce_7),
        (8 , happyReduce_8),
        (9 , happyReduce_9),
        (10 , happyReduce_10),
        (11 , happyReduce_11),
        (12 , happyReduce_12),
        (13 , happyReduce_13),
        (14 , happyReduce_14),
        (15 , happyReduce_15),
        (16 , happyReduce_16),
        (17 , happyReduce_17),
        (18 , happyReduce_18),
        (19 , happyReduce_19),
        (20 , happyReduce_20),
        (21 , happyReduce_21),
        (22 , happyReduce_22),
        (23 , happyReduce_23),
        (24 , happyReduce_24),
        (25 , happyReduce_25),
        (26 , happyReduce_26),
        (27 , happyReduce_27),
        (28 , happyReduce_28),
        (29 , happyReduce_29),
        (30 , happyReduce_30),
        (31 , happyReduce_31),
        (32 , happyReduce_32),
        (33 , happyReduce_33),
        (34 , happyReduce_34),
        (35 , happyReduce_35),
        (36 , happyReduce_36),
        (37 , happyReduce_37),
        (38 , happyReduce_38),
        (39 , happyReduce_39),
        (40 , happyReduce_40),
        (41 , happyReduce_41),
        (42 , happyReduce_42),
        (43 , happyReduce_43),
        (44 , happyReduce_44),
        (45 , happyReduce_45),
        (46 , happyReduce_46),
        (47 , happyReduce_47),
        (48 , happyReduce_48),
        (49 , happyReduce_49),
        (50 , happyReduce_50),
        (51 , happyReduce_51),
        (52 , happyReduce_52),
        (53 , happyReduce_53),
        (54 , happyReduce_54),
        (55 , happyReduce_55),
        (56 , happyReduce_56),
        (57 , happyReduce_57),
        (58 , happyReduce_58),
        (59 , happyReduce_59),
        (60 , happyReduce_60),
        (61 , happyReduce_61),
        (62 , happyReduce_62),
        (63 , happyReduce_63),
        (64 , happyReduce_64),
        (65 , happyReduce_65),
        (66 , happyReduce_66),
        (67 , happyReduce_67),
        (68 , happyReduce_68),
        (69 , happyReduce_69),
        (70 , happyReduce_70),
        (71 , happyReduce_71),
        (72 , happyReduce_72),
        (73 , happyReduce_73),
        (74 , happyReduce_74),
        (75 , happyReduce_75),
        (76 , happyReduce_76),
        (77 , happyReduce_77),
        (78 , happyReduce_78),
        (79 , happyReduce_79),
        (80 , happyReduce_80),
        (81 , happyReduce_81),
        (82 , happyReduce_82),
        (83 , happyReduce_83),
        (84 , happyReduce_84),
        (85 , happyReduce_85),
        (86 , happyReduce_86),
        (87 , happyReduce_87),
        (88 , happyReduce_88),
        (89 , happyReduce_89),
        (90 , happyReduce_90),
        (91 , happyReduce_91),
        (92 , happyReduce_92),
        (93 , happyReduce_93),
        (94 , happyReduce_94),
        (95 , happyReduce_95),
        (96 , happyReduce_96),
        (97 , happyReduce_97),
        (98 , happyReduce_98),
        (99 , happyReduce_99),
        (100 , happyReduce_100),
        (101 , happyReduce_101),
        (102 , happyReduce_102),
        (103 , happyReduce_103),
        (104 , happyReduce_104),
        (105 , happyReduce_105),
        (106 , happyReduce_106),
        (107 , happyReduce_107),
        (108 , happyReduce_108),
        (109 , happyReduce_109),
        (110 , happyReduce_110),
        (111 , happyReduce_111),
        (112 , happyReduce_112),
        (113 , happyReduce_113),
        (114 , happyReduce_114),
        (115 , happyReduce_115),
        (116 , happyReduce_116),
        (117 , happyReduce_117),
        (118 , happyReduce_118),
        (119 , happyReduce_119),
        (120 , happyReduce_120),
        (121 , happyReduce_121),
        (122 , happyReduce_122),
        (123 , happyReduce_123),
        (124 , happyReduce_124),
        (125 , happyReduce_125),
        (126 , happyReduce_126),
        (127 , happyReduce_127),
        (128 , happyReduce_128),
        (129 , happyReduce_129),
        (130 , happyReduce_130),
        (131 , happyReduce_131),
        (132 , happyReduce_132),
        (133 , happyReduce_133),
        (134 , happyReduce_134),
        (135 , happyReduce_135),
        (136 , happyReduce_136),
        (137 , happyReduce_137),
        (138 , happyReduce_138),
        (139 , happyReduce_139),
        (140 , happyReduce_140),
        (141 , happyReduce_141),
        (142 , happyReduce_142),
        (143 , happyReduce_143),
        (144 , happyReduce_144),
        (145 , happyReduce_145),
        (146 , happyReduce_146),
        (147 , happyReduce_147),
        (148 , happyReduce_148),
        (149 , happyReduce_149),
        (150 , happyReduce_150),
        (151 , happyReduce_151),
        (152 , happyReduce_152),
        (153 , happyReduce_153),
        (154 , happyReduce_154),
        (155 , happyReduce_155),
        (156 , happyReduce_156),
        (157 , happyReduce_157),
        (158 , happyReduce_158),
        (159 , happyReduce_159),
        (160 , happyReduce_160),
        (161 , happyReduce_161),
        (162 , happyReduce_162),
        (163 , happyReduce_163),
        (164 , happyReduce_164),
        (165 , happyReduce_165),
        (166 , happyReduce_166),
        (167 , happyReduce_167),
        (168 , happyReduce_168),
        (169 , happyReduce_169),
        (170 , happyReduce_170),
        (171 , happyReduce_171),
        (172 , happyReduce_172),
        (173 , happyReduce_173),
        (174 , happyReduce_174),
        (175 , happyReduce_175),
        (176 , happyReduce_176),
        (177 , happyReduce_177),
        (178 , happyReduce_178),
        (179 , happyReduce_179),
        (180 , happyReduce_180),
        (181 , happyReduce_181),
        (182 , happyReduce_182),
        (183 , happyReduce_183),
        (184 , happyReduce_184),
        (185 , happyReduce_185),
        (186 , happyReduce_186),
        (187 , happyReduce_187),
        (188 , happyReduce_188),
        (189 , happyReduce_189),
        (190 , happyReduce_190),
        (191 , happyReduce_191),
        (192 , happyReduce_192),
        (193 , happyReduce_193)
        ]

happyRuleArr :: HappyAddr
happyRuleArr = HappyA# "\x00\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x05\x00\x00\x00\x01\x00\x00\x00\x05\x00\x00\x00\x03\x00\x00\x00\x05\x00\x00\x00\x03\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x07\x00\x00\x00\x01\x00\x00\x00\x07\x00\x00\x00\x01\x00\x00\x00\x08\x00\x00\x00\x07\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x0a\x00\x00\x00\x01\x00\x00\x00\x0a\x00\x00\x00\x04\x00\x00\x00\x0a\x00\x00\x00\x04\x00\x00\x00\x0b\x00\x00\x00\x05\x00\x00\x00\x0b\x00\x00\x00\x06\x00\x00\x00\x0c\x00\x00\x00\x01\x00\x00\x00\x0d\x00\x00\x00\x02\x00\x00\x00\x0d\x00\x00\x00\x02\x00\x00\x00\x0d\x00\x00\x00\x01\x00\x00\x00\x0d\x00\x00\x00\x01\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0e\x00\x00\x00\x03\x00\x00\x00\x0f\x00\x00\x00\x02\x00\x00\x00\x0f\x00\x00\x00\x02\x00\x00\x00\x0f\x00\x00\x00\x01\x00\x00\x00\x0f\x00\x00\x00\x01\x00\x00\x00\x10\x00\x00\x00\x03\x00\x00\x00\x10\x00\x00\x00\x03\x00\x00\x00\x10\x00\x00\x00\x03\x00\x00\x00\x10\x00\x00\x00\x03\x00\x00\x00\x10\x00\x00\x00\x03\x00\x00\x00\x11\x00\x00\x00\x07\x00\x00\x00\x12\x00\x00\x00\x08\x00\x00\x00\x13\x00\x00\x00\x07\x00\x00\x00\x14\x00\x00\x00\x03\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x02\x00\x00\x00\x15\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x05\x00\x00\x00\x17\x00\x00\x00\x08\x00\x00\x00\x18\x00\x00\x00\x04\x00\x00\x00\x19\x00\x00\x00\x07\x00\x00\x00\x1a\x00\x00\x00\x09\x00\x00\x00\x1b\x00\x00\x00\x08\x00\x00\x00\x1c\x00\x00\x00\x01\x00\x00\x00\x1d\x00\x00\x00\x02\x00\x00\x00\x1d\x00\x00\x00\x01\x00\x00\x00\x1e\x00\x00\x00\x05\x00\x00\x00\x1e\x00\x00\x00\x06\x00\x00\x00\x1e\x00\x00\x00\x06\x00\x00\x00\x1e\x00\x00\x00\x07\x00\x00\x00\x1f\x00\x00\x00\x01\x00\x00\x00\x1f\x00\x00\x00\x01\x00\x00\x00\x1f\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x01\x00\x00\x00\x20\x00\x00\x00\x03\x00\x00\x00\x21\x00\x00\x00\x01\x00\x00\x00\x22\x00\x00\x00\x02\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x23\x00\x00\x00\x03\x00\x00\x00\x23\x00\x00\x00\x01\x00\x00\x00\x24\x00\x00\x00\x04\x00\x00\x00\x24\x00\x00\x00\x02\x00\x00\x00\x24\x00\x00\x00\x00\x00\x00\x00\x25\x00\x00\x00\x03\x00\x00\x00\x25\x00\x00\x00\x04\x00\x00\x00\x25\x00\x00\x00\x04\x00\x00\x00\x25\x00\x00\x00\x01\x00\x00\x00\x26\x00\x00\x00\x03\x00\x00\x00\x26\x00\x00\x00\x01\x00\x00\x00\x27\x00\x00\x00\x02\x00\x00\x00\x28\x00\x00\x00\x01\x00\x00\x00\x29\x00\x00\x00\x01\x00\x00\x00\x29\x00\x00\x00\x00\x00\x00\x00\x2a\x00\x00\x00\x04\x00\x00\x00\x2b\x00\x00\x00\x02\x00\x00\x00\x2b\x00\x00\x00\x02\x00\x00\x00\x2b\x00\x00\x00\x01\x00\x00\x00\x2b\x00\x00\x00\x01\x00\x00\x00\x2b\x00\x00\x00\x01\x00\x00\x00\x2b\x00\x00\x00\x00\x00\x00\x00\x2c\x00\x00\x00\x01\x00\x00\x00\x2c\x00\x00\x00\x01\x00\x00\x00\x2c\x00\x00\x00\x00\x00\x00\x00\x2d\x00\x00\x00\x02\x00\x00\x00\x2d\x00\x00\x00\x00\x00\x00\x00\x2e\x00\x00\x00\x01\x00\x00\x00\x2f\x00\x00\x00\x02\x00\x00\x00\x2f\x00\x00\x00\x01\x00\x00\x00\x30\x00\x00\x00\x03\x00\x00\x00\x30\x00\x00\x00\x01\x00\x00\x00\x31\x00\x00\x00\x01\x00\x00\x00\x31\x00\x00\x00\x01\x00\x00\x00\x31\x00\x00\x00\x01\x00\x00\x00\x32\x00\x00\x00\x03\x00\x00\x00\x33\x00\x00\x00\x02\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x34\x00\x00\x00\x02\x00\x00\x00\x34\x00\x00\x00\x01\x00\x00\x00\x35\x00\x00\x00\x03\x00\x00\x00\x35\x00\x00\x00\x01\x00\x00\x00\x36\x00\x00\x00\x05\x00\x00\x00\x37\x00\x00\x00\x04\x00\x00\x00\x37\x00\x00\x00\x02\x00\x00\x00\x37\x00\x00\x00\x00\x00\x00\x00\x38\x00\x00\x00\x05\x00\x00\x00\x38\x00\x00\x00\x05\x00\x00\x00\x39\x00\x00\x00\x06\x00\x00\x00\x39\x00\x00\x00\x05\x00\x00\x00\x3a\x00\x00\x00\x02\x00\x00\x00\x3b\x00\x00\x00\x02\x00\x00\x00\x3b\x00\x00\x00\x00\x00\x00\x00\x3c\x00\x00\x00\x02\x00\x00\x00\x3c\x00\x00\x00\x02\x00\x00\x00\x3c\x00\x00\x00\x00\x00\x00\x00\x3d\x00\x00\x00\x03\x00\x00\x00\x3e\x00\x00\x00\x03\x00\x00\x00\x3e\x00\x00\x00\x03\x00\x00\x00\x3f\x00\x00\x00\x03\x00\x00\x00\x3f\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x01\x00\x00\x00\x40\x00\x00\x00\x02\x00\x00\x00\x41\x00\x00\x00\x01\x00\x00\x00\x41\x00\x00\x00\x01\x00\x00\x00\x42\x00\x00\x00\x03\x00\x00\x00\x42\x00\x00\x00\x01\x00\x00\x00\x42\x00\x00\x00\x03\x00\x00\x00\x43\x00\x00\x00\x03\x00\x00\x00\x43\x00\x00\x00\x01\x00\x00\x00\x43\x00\x00\x00\x03\x00\x00\x00\x44\x00\x00\x00\x03\x00\x00\x00\x44\x00\x00\x00\x01\x00\x00\x00\x45\x00\x00\x00\x03\x00\x00\x00\x45\x00\x00\x00\x01\x00\x00\x00\x46\x00\x00\x00\x03\x00\x00\x00\x46\x00\x00\x00\x01\x00\x00\x00\x47\x00\x00\x00\x01\x00\x00\x00\x47\x00\x00\x00\x01\x00\x00\x00\x48\x00\x00\x00\x03\x00\x00\x00\x49\x00\x00\x00\x01\x00\x00\x00\x4a\x00\x00\x00\x03\x00\x00\x00\x4a\x00\x00\x00\x03\x00\x00\x00\x4b\x00\x00\x00\x03\x00\x00\x00\x4b\x00\x00\x00\x01\x00\x00\x00\x4b\x00\x00\x00\x00\x00\x00\x00\x4c\x00\x00\x00\x01\x00\x00\x00\x4d\x00\x00\x00\x02\x00\x00\x00\x4d\x00\x00\x00\x00\x00\x00\x00\x4e\x00\x00\x00\x01\x00\x00\x00\x4e\x00\x00\x00\x03\x00\x00\x00\x4e\x00\x00\x00\x03\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x4f\x00\x00\x00\x01\x00\x00\x00\x50\x00\x00\x00\x01\x00\x00\x00\x50\x00\x00\x00\x01\x00\x00\x00\x51\x00\x00\x00\x01\x00\x00\x00\x51\x00\x00\x00\x01\x00\x00\x00\x51\x00\x00\x00\x01\x00\x00\x00\x51\x00\x00\x00\x01\x00\x00\x00\x52\x00\x00\x00\x01\x00\x00\x00\x52\x00\x00\x00\x01\x00\x00\x00\x53\x00\x00\x00\x03\x00\x00\x00\x53\x00\x00\x00\x01\x00\x00\x00\x54\x00\x00\x00\x01\x00\x00\x00\x54\x00\x00\x00\x01\x00\x00\x00\x55\x00\x00\x00\x03\x00\x00\x00\x55\x00\x00\x00\x01\x00\x00\x00\x55\x00\x00\x00\x03\x00\x00\x00"#

happyCatchStates :: [Happy_Prelude.Int]
happyCatchStates = []

happy_n_terms = 40 :: Happy_Prelude.Int
happy_n_nonterms = 86 :: Happy_Prelude.Int

happy_n_starts = 4 :: Happy_Prelude.Int

happyReduce_4 = happySpecReduce_1  0# happyReduction_4
happyReduction_4 happy_x_1
         =  case happyOut9 happy_x_1 of { (HappyWrap9 happy_var_1) -> 
        happyIn8
                 (reverse happy_var_1
        )}

happyReduce_5 = happySpecReduce_2  1# happyReduction_5
happyReduction_5 happy_x_2
        happy_x_1
         =  case happyOut9 happy_x_1 of { (HappyWrap9 happy_var_1) -> 
        case happyOut12 happy_x_2 of { (HappyWrap12 happy_var_2) -> 
        happyIn9
                 (happy_var_2:happy_var_1
        )}}

happyReduce_6 = happySpecReduce_0  1# happyReduction_6
happyReduction_6  =  happyIn9
                 ([]
        )

happyReduce_7 = happySpecReduce_1  2# happyReduction_7
happyReduction_7 happy_x_1
         =  case happyOut11 happy_x_1 of { (HappyWrap11 happy_var_1) -> 
        happyIn10
                 (reverse happy_var_1
        )}

happyReduce_8 = happySpecReduce_2  3# happyReduction_8
happyReduction_8 happy_x_2
        happy_x_1
         =  case happyOut11 happy_x_1 of { (HappyWrap11 happy_var_1) -> 
        case happyOut13 happy_x_2 of { (HappyWrap13 happy_var_2) -> 
        happyIn11
                 (happy_var_2:happy_var_1
        )}}

happyReduce_9 = happySpecReduce_0  3# happyReduction_9
happyReduction_9  =  happyIn11
                 ([]
        )

happyReduce_10 = happySpecReduce_1  4# happyReduction_10
happyReduction_10 happy_x_1
         =  case happyOut16 happy_x_1 of { (HappyWrap16 happy_var_1) -> 
        happyIn12
                 (TLModule happy_var_1
        )}

happyReduce_11 = happySpecReduce_1  4# happyReduction_11
happyReduction_11 happy_x_1
         =  case happyOut17 happy_x_1 of { (HappyWrap17 happy_var_1) -> 
        happyIn12
                 (TLInterface happy_var_1
        )}

happyReduce_12 = happySpecReduce_1  4# happyReduction_12
happyReduction_12 happy_x_1
         =  case happyOut56 happy_x_1 of { (HappyWrap56 happy_var_1) -> 
        happyIn12
                 (TLTerm happy_var_1
        )}

happyReduce_13 = happySpecReduce_1  4# happyReduction_13
happyReduction_13 happy_x_1
         =  case happyOut19 happy_x_1 of { (HappyWrap19 happy_var_1) -> 
        happyIn12
                 (TLUse happy_var_1
        )}

happyReduce_14 = happySpecReduce_1  5# happyReduction_14
happyReduction_14 happy_x_1
         =  case happyOut12 happy_x_1 of { (HappyWrap12 happy_var_1) -> 
        happyIn13
                 (RTLTopLevel happy_var_1
        )}

happyReduce_15 = happySpecReduce_3  5# happyReduction_15
happyReduction_15 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut31 happy_x_2 of { (HappyWrap31 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn13
                 (RTLDefun (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_16 = happySpecReduce_3  5# happyReduction_16
happyReduction_16 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut30 happy_x_2 of { (HappyWrap30 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn13
                 (RTLDefConst (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_17 = happySpecReduce_1  6# happyReduction_17
happyReduction_17 happy_x_1
         =  case happyOut15 happy_x_1 of { (HappyWrap15 happy_var_1) -> 
        happyIn14
                 (KeyGov happy_var_1
        )}

happyReduce_18 = happySpecReduce_1  6# happyReduction_18
happyReduction_18 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn14
                 (CapGov (getIdent happy_var_1)
        )}

happyReduce_19 = happySpecReduce_1  7# happyReduction_19
happyReduction_19 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn15
                 (getStr happy_var_1
        )}

happyReduce_20 = happySpecReduce_1  7# happyReduction_20
happyReduction_20 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn15
                 (getTick happy_var_1
        )}

happyReduce_21 = happyReduce 7# 8# happyReduction_21
happyReduction_21 (happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        case happyOut14 happy_x_4 of { (HappyWrap14 happy_var_4) -> 
        case happyOut51 happy_x_5 of { (HappyWrap51 happy_var_5) -> 
        case happyOut20 happy_x_6 of { (HappyWrap20 happy_var_6) -> 
        case happyOutTok happy_x_7 of { happy_var_7 -> 
        happyIn16
                 (Module (getIdent happy_var_3) happy_var_4 (snd happy_var_6) (fst happy_var_6) happy_var_5
      (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_7))
        ) `HappyStk` happyRest}}}}}}

happyReduce_22 = happyReduce 6# 9# happyReduction_22
happyReduction_22 (happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        case happyOut51 happy_x_4 of { (HappyWrap51 happy_var_4) -> 
        case happyOut23 happy_x_5 of { (HappyWrap23 happy_var_5) -> 
        case happyOutTok happy_x_6 of { happy_var_6 -> 
        happyIn17
                 (Interface (getIdent happy_var_3) (reverse (lefts happy_var_5)) (reverse (rights happy_var_5)) happy_var_4
      (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_6))
        ) `HappyStk` happyRest}}}}}

happyReduce_23 = happySpecReduce_1  10# happyReduction_23
happyReduction_23 happy_x_1
         =  case happyOut19 happy_x_1 of { (HappyWrap19 happy_var_1) -> 
        happyIn18
                 (ExtImport happy_var_1
        )}

happyReduce_24 = happyReduce 4# 10# happyReduction_24
happyReduction_24 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        case happyOutTok happy_x_4 of { happy_var_4 -> 
        happyIn18
                 (ExtImplements (mkModName happy_var_3) (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_4))
        ) `HappyStk` happyRest}}}

happyReduce_25 = happyReduce 4# 10# happyReduction_25
happyReduction_25 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut15 happy_x_3 of { (HappyWrap15 happy_var_3) -> 
        case happyOutTok happy_x_4 of { happy_var_4 -> 
        happyIn18
                 (ExtBless happy_var_3 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_4))
        ) `HappyStk` happyRest}}}

happyReduce_26 = happyReduce 5# 11# happyReduction_26
happyReduction_26 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        case happyOut28 happy_x_4 of { (HappyWrap28 happy_var_4) -> 
        case happyOutTok happy_x_5 of { happy_var_5 -> 
        happyIn19
                 (Import (mkModName happy_var_3) Nothing happy_var_4 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_5))
        ) `HappyStk` happyRest}}}}

happyReduce_27 = happyReduce 6# 11# happyReduction_27
happyReduction_27 (happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        case happyOutTok happy_x_4 of { happy_var_4 -> 
        case happyOut28 happy_x_5 of { (HappyWrap28 happy_var_5) -> 
        case happyOutTok happy_x_6 of { happy_var_6 -> 
        happyIn19
                 (Import (mkModName happy_var_3) (Just (getStr happy_var_4)) happy_var_5 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_6))
        ) `HappyStk` happyRest}}}}}

happyReduce_28 = happyMonadReduce 1# 12# happyReduction_28
happyReduction_28 (happy_x_1 `HappyStk`
        happyRest) tk
         = happyThen ((case happyOut21 happy_x_1 of { (HappyWrap21 happy_var_1) -> 
        ( ensureAtLeastOneDef happy_var_1)})
        ) (\r -> happyReturn (happyIn20 r))

happyReduce_29 = happySpecReduce_2  13# happyReduction_29
happyReduction_29 happy_x_2
        happy_x_1
         =  case happyOut21 happy_x_1 of { (HappyWrap21 happy_var_1) -> 
        case happyOut22 happy_x_2 of { (HappyWrap22 happy_var_2) -> 
        happyIn21
                 ((Left happy_var_2):happy_var_1
        )}}

happyReduce_30 = happySpecReduce_2  13# happyReduction_30
happyReduction_30 happy_x_2
        happy_x_1
         =  case happyOut21 happy_x_1 of { (HappyWrap21 happy_var_1) -> 
        case happyOut18 happy_x_2 of { (HappyWrap18 happy_var_2) -> 
        happyIn21
                 ((Right happy_var_2) : happy_var_1
        )}}

happyReduce_31 = happySpecReduce_1  13# happyReduction_31
happyReduction_31 happy_x_1
         =  case happyOut22 happy_x_1 of { (HappyWrap22 happy_var_1) -> 
        happyIn21
                 ([Left happy_var_1]
        )}

happyReduce_32 = happySpecReduce_1  13# happyReduction_32
happyReduction_32 happy_x_1
         =  case happyOut18 happy_x_1 of { (HappyWrap18 happy_var_1) -> 
        happyIn21
                 ([Right happy_var_1]
        )}

happyReduce_33 = happySpecReduce_3  14# happyReduction_33
happyReduction_33 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut31 happy_x_2 of { (HappyWrap31 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (Dfun (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_34 = happySpecReduce_3  14# happyReduction_34
happyReduction_34 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut30 happy_x_2 of { (HappyWrap30 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (DConst (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_35 = happySpecReduce_3  14# happyReduction_35
happyReduction_35 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut34 happy_x_2 of { (HappyWrap34 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (DCap (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_36 = happySpecReduce_3  14# happyReduction_36
happyReduction_36 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut32 happy_x_2 of { (HappyWrap32 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (DSchema (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_37 = happySpecReduce_3  14# happyReduction_37
happyReduction_37 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut33 happy_x_2 of { (HappyWrap33 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (DTable (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_38 = happySpecReduce_3  14# happyReduction_38
happyReduction_38 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut35 happy_x_2 of { (HappyWrap35 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn22
                 (DPact (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_39 = happySpecReduce_2  15# happyReduction_39
happyReduction_39 happy_x_2
        happy_x_1
         =  case happyOut23 happy_x_1 of { (HappyWrap23 happy_var_1) -> 
        case happyOut24 happy_x_2 of { (HappyWrap24 happy_var_2) -> 
        happyIn23
                 ((Left happy_var_2):happy_var_1
        )}}

happyReduce_40 = happySpecReduce_2  15# happyReduction_40
happyReduction_40 happy_x_2
        happy_x_1
         =  case happyOut23 happy_x_1 of { (HappyWrap23 happy_var_1) -> 
        case happyOut19 happy_x_2 of { (HappyWrap19 happy_var_2) -> 
        happyIn23
                 ((Right happy_var_2) : happy_var_1
        )}}

happyReduce_41 = happySpecReduce_1  15# happyReduction_41
happyReduction_41 happy_x_1
         =  case happyOut24 happy_x_1 of { (HappyWrap24 happy_var_1) -> 
        happyIn23
                 ([Left happy_var_1]
        )}

happyReduce_42 = happySpecReduce_1  15# happyReduction_42
happyReduction_42 happy_x_1
         =  case happyOut19 happy_x_1 of { (HappyWrap19 happy_var_1) -> 
        happyIn23
                 ([Right happy_var_1]
        )}

happyReduce_43 = happySpecReduce_3  16# happyReduction_43
happyReduction_43 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut25 happy_x_2 of { (HappyWrap25 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn24
                 (IfDfun (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_44 = happySpecReduce_3  16# happyReduction_44
happyReduction_44 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut30 happy_x_2 of { (HappyWrap30 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn24
                 (IfDConst (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_45 = happySpecReduce_3  16# happyReduction_45
happyReduction_45 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut26 happy_x_2 of { (HappyWrap26 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn24
                 (IfDCap (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_46 = happySpecReduce_3  16# happyReduction_46
happyReduction_46 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut32 happy_x_2 of { (HappyWrap32 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn24
                 (IfDSchema (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_47 = happySpecReduce_3  16# happyReduction_47
happyReduction_47 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut27 happy_x_2 of { (HappyWrap27 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn24
                 (IfDPact (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}}

happyReduce_48 = happyReduce 7# 17# happyReduction_48
happyReduction_48 (happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        happyIn25
                 (IfDefun (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_7
        ) `HappyStk` happyRest}}}}

happyReduce_49 = happyReduce 8# 18# happyReduction_49
happyReduction_49 (happy_x_8 `HappyStk`
        happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        case happyOut39 happy_x_8 of { (HappyWrap39 happy_var_8) -> 
        happyIn26
                 (IfDefCap (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_7 happy_var_8
        ) `HappyStk` happyRest}}}}}

happyReduce_50 = happyReduce 7# 19# happyReduction_50
happyReduction_50 (happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        happyIn27
                 (IfDefPact (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_7
        ) `HappyStk` happyRest}}}}

happyReduce_51 = happySpecReduce_3  20# happyReduction_51
happyReduction_51 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut29 happy_x_2 of { (HappyWrap29 happy_var_2) -> 
        happyIn28
                 (Just (reverse happy_var_2)
        )}

happyReduce_52 = happySpecReduce_0  20# happyReduction_52
happyReduction_52  =  happyIn28
                 (Nothing
        )

happyReduce_53 = happySpecReduce_2  21# happyReduction_53
happyReduction_53 happy_x_2
        happy_x_1
         =  case happyOut29 happy_x_1 of { (HappyWrap29 happy_var_1) -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        happyIn29
                 ((getIdent happy_var_2):happy_var_1
        )}}

happyReduce_54 = happySpecReduce_0  21# happyReduction_54
happyReduction_54  =  happyIn29
                 ([]
        )

happyReduce_55 = happyReduce 5# 22# happyReduction_55
happyReduction_55 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut56 happy_x_4 of { (HappyWrap56 happy_var_4) -> 
        case happyOut52 happy_x_5 of { (HappyWrap52 happy_var_5) -> 
        happyIn30
                 (DefConst (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) happy_var_4 happy_var_5
        ) `HappyStk` happyRest}}}}

happyReduce_56 = happyReduce 8# 23# happyReduction_56
happyReduction_56 (happy_x_8 `HappyStk`
        happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        case happyOut54 happy_x_8 of { (HappyWrap54 happy_var_8) -> 
        happyIn31
                 (Defun (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_8 happy_var_7
        ) `HappyStk` happyRest}}}}}

happyReduce_57 = happyReduce 4# 24# happyReduction_57
happyReduction_57 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut51 happy_x_3 of { (HappyWrap51 happy_var_3) -> 
        case happyOut44 happy_x_4 of { (HappyWrap44 happy_var_4) -> 
        happyIn32
                 (DefSchema (getIdent happy_var_2) (reverse happy_var_4) happy_var_3
        ) `HappyStk` happyRest}}}

happyReduce_58 = happyReduce 7# 25# happyReduction_58
happyReduction_58 (happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut75 happy_x_5 of { (HappyWrap75 happy_var_5) -> 
        case happyOut52 happy_x_7 of { (HappyWrap52 happy_var_7) -> 
        happyIn33
                 (DefTable (getIdent happy_var_2) happy_var_5 happy_var_7
        ) `HappyStk` happyRest}}}

happyReduce_59 = happyReduce 9# 26# happyReduction_59
happyReduction_59 (happy_x_9 `HappyStk`
        happy_x_8 `HappyStk`
        happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        case happyOut39 happy_x_8 of { (HappyWrap39 happy_var_8) -> 
        case happyOut54 happy_x_9 of { (HappyWrap54 happy_var_9) -> 
        happyIn34
                 (DefCap (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_9 happy_var_7 happy_var_8
        ) `HappyStk` happyRest}}}}}}

happyReduce_60 = happyReduce 8# 27# happyReduction_60
happyReduction_60 (happy_x_8 `HappyStk`
        happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut42 happy_x_5 of { (HappyWrap42 happy_var_5) -> 
        case happyOut51 happy_x_7 of { (HappyWrap51 happy_var_7) -> 
        case happyOut36 happy_x_8 of { (HappyWrap36 happy_var_8) -> 
        happyIn35
                 (DefPact (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) (reverse happy_var_5) happy_var_8 happy_var_7
        ) `HappyStk` happyRest}}}}}

happyReduce_61 = happySpecReduce_1  28# happyReduction_61
happyReduction_61 happy_x_1
         =  case happyOut37 happy_x_1 of { (HappyWrap37 happy_var_1) -> 
        happyIn36
                 (NE.fromList (reverse happy_var_1)
        )}

happyReduce_62 = happySpecReduce_2  29# happyReduction_62
happyReduction_62 happy_x_2
        happy_x_1
         =  case happyOut37 happy_x_1 of { (HappyWrap37 happy_var_1) -> 
        case happyOut38 happy_x_2 of { (HappyWrap38 happy_var_2) -> 
        happyIn37
                 (happy_var_2:happy_var_1
        )}}

happyReduce_63 = happySpecReduce_1  29# happyReduction_63
happyReduction_63 happy_x_1
         =  case happyOut38 happy_x_1 of { (HappyWrap38 happy_var_1) -> 
        happyIn37
                 ([happy_var_1]
        )}

happyReduce_64 = happyReduce 5# 30# happyReduction_64
happyReduction_64 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        case happyOut49 happy_x_4 of { (HappyWrap49 happy_var_4) -> 
        happyIn38
                 (Step Nothing happy_var_3 happy_var_4
        ) `HappyStk` happyRest}}

happyReduce_65 = happyReduce 6# 30# happyReduction_65
happyReduction_65 (happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        case happyOut56 happy_x_4 of { (HappyWrap56 happy_var_4) -> 
        case happyOut49 happy_x_5 of { (HappyWrap49 happy_var_5) -> 
        happyIn38
                 (Step (Just happy_var_3) happy_var_4 happy_var_5
        ) `HappyStk` happyRest}}}

happyReduce_66 = happyReduce 6# 30# happyReduction_66
happyReduction_66 (happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        case happyOut56 happy_x_4 of { (HappyWrap56 happy_var_4) -> 
        case happyOut49 happy_x_5 of { (HappyWrap49 happy_var_5) -> 
        happyIn38
                 (StepWithRollback Nothing happy_var_3 happy_var_4 happy_var_5
        ) `HappyStk` happyRest}}}

happyReduce_67 = happyReduce 7# 30# happyReduction_67
happyReduction_67 (happy_x_7 `HappyStk`
        happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        case happyOut56 happy_x_4 of { (HappyWrap56 happy_var_4) -> 
        case happyOut56 happy_x_5 of { (HappyWrap56 happy_var_5) -> 
        case happyOut49 happy_x_6 of { (HappyWrap49 happy_var_6) -> 
        happyIn38
                 (StepWithRollback (Just happy_var_3) happy_var_4 happy_var_5 happy_var_6
        ) `HappyStk` happyRest}}}}

happyReduce_68 = happySpecReduce_1  31# happyReduction_68
happyReduction_68 happy_x_1
         =  case happyOut40 happy_x_1 of { (HappyWrap40 happy_var_1) -> 
        happyIn39
                 (Just happy_var_1
        )}

happyReduce_69 = happySpecReduce_1  31# happyReduction_69
happyReduction_69 happy_x_1
         =  case happyOut41 happy_x_1 of { (HappyWrap41 happy_var_1) -> 
        happyIn39
                 (Just happy_var_1
        )}

happyReduce_70 = happySpecReduce_0  31# happyReduction_70
happyReduction_70  =  happyIn39
                 (Nothing
        )

happyReduce_71 = happySpecReduce_1  32# happyReduction_71
happyReduction_71 happy_x_1
         =  happyIn40
                 (DefManaged Nothing
        )

happyReduce_72 = happySpecReduce_3  32# happyReduction_72
happyReduction_72 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut75 happy_x_3 of { (HappyWrap75 happy_var_3) -> 
        happyIn40
                 (DefManaged (Just (getIdent happy_var_2, happy_var_3))
        )}}

happyReduce_73 = happySpecReduce_1  33# happyReduction_73
happyReduction_73 happy_x_1
         =  happyIn41
                 (DefEvent
        )

happyReduce_74 = happySpecReduce_2  34# happyReduction_74
happyReduction_74 happy_x_2
        happy_x_1
         =  case happyOut42 happy_x_1 of { (HappyWrap42 happy_var_1) -> 
        case happyOut43 happy_x_2 of { (HappyWrap43 happy_var_2) -> 
        happyIn42
                 (happy_var_2:happy_var_1
        )}}

happyReduce_75 = happySpecReduce_0  34# happyReduction_75
happyReduction_75  =  happyIn42
                 ([]
        )

happyReduce_76 = happySpecReduce_3  35# happyReduction_76
happyReduction_76 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut45 happy_x_3 of { (HappyWrap45 happy_var_3) -> 
        happyIn43
                 (MArg (getIdent happy_var_1) (Just happy_var_3) (_ptInfo happy_var_1)
        )}}

happyReduce_77 = happySpecReduce_1  35# happyReduction_77
happyReduction_77 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn43
                 (MArg (getIdent happy_var_1) Nothing (_ptInfo happy_var_1)
        )}

happyReduce_78 = happyReduce 4# 36# happyReduction_78
happyReduction_78 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut44 happy_x_1 of { (HappyWrap44 happy_var_1) -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut45 happy_x_4 of { (HappyWrap45 happy_var_4) -> 
        happyIn44
                 ((Arg (getIdent happy_var_2) happy_var_4 (_ptInfo happy_var_2)):happy_var_1
        ) `HappyStk` happyRest}}}

happyReduce_79 = happySpecReduce_2  36# happyReduction_79
happyReduction_79 happy_x_2
        happy_x_1
         =  case happyOut44 happy_x_1 of { (HappyWrap44 happy_var_1) -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        happyIn44
                 ((Arg (getIdent happy_var_2) TyAny (_ptInfo happy_var_2)):happy_var_1
        )}}

happyReduce_80 = happySpecReduce_0  36# happyReduction_80
happyReduction_80  =  happyIn44
                 ([]
        )

happyReduce_81 = happySpecReduce_3  37# happyReduction_81
happyReduction_81 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut45 happy_x_2 of { (HappyWrap45 happy_var_2) -> 
        happyIn45
                 (TyList happy_var_2
        )}

happyReduce_82 = happyReduce 4# 37# happyReduction_82
happyReduction_82 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut46 happy_x_3 of { (HappyWrap46 happy_var_3) -> 
        happyIn45
                 (TyModRef (reverse happy_var_3)
        ) `HappyStk` happyRest}

happyReduce_83 = happyMonadReduce 4# 37# happyReduction_83
happyReduction_83 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest) tk
         = happyThen ((case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut76 happy_x_3 of { (HappyWrap76 happy_var_3) -> 
        ( objType (_ptInfo happy_var_1) (getIdent happy_var_1) happy_var_3)}})
        ) (\r -> happyReturn (happyIn45 r))

happyReduce_84 = happyMonadReduce 1# 37# happyReduction_84
happyReduction_84 (happy_x_1 `HappyStk`
        happyRest) tk
         = happyThen ((case happyOutTok happy_x_1 of { happy_var_1 -> 
        ( primType (_ptInfo happy_var_1) (getIdent happy_var_1))})
        ) (\r -> happyReturn (happyIn45 r))

happyReduce_85 = happySpecReduce_3  38# happyReduction_85
happyReduction_85 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut46 happy_x_1 of { (HappyWrap46 happy_var_1) -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        happyIn46
                 ((mkModName happy_var_3) : happy_var_1
        )}}

happyReduce_86 = happySpecReduce_1  38# happyReduction_86
happyReduction_86 happy_x_1
         =  case happyOut77 happy_x_1 of { (HappyWrap77 happy_var_1) -> 
        happyIn46
                 ([mkModName happy_var_1]
        )}

happyReduce_87 = happySpecReduce_2  39# happyReduction_87
happyReduction_87 happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_2 of { happy_var_2 -> 
        happyIn47
                 (getStr happy_var_2
        )}

happyReduce_88 = happySpecReduce_1  40# happyReduction_88
happyReduction_88 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn48
                 (getStr happy_var_1
        )}

happyReduce_89 = happySpecReduce_1  41# happyReduction_89
happyReduction_89 happy_x_1
         =  case happyOut50 happy_x_1 of { (HappyWrap50 happy_var_1) -> 
        happyIn49
                 (Just happy_var_1
        )}

happyReduce_90 = happySpecReduce_0  41# happyReduction_90
happyReduction_90  =  happyIn49
                 (Nothing
        )

happyReduce_91 = happyReduce 4# 42# happyReduction_91
happyReduction_91 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut84 happy_x_3 of { (HappyWrap84 happy_var_3) -> 
        happyIn50
                 (happy_var_3
        ) `HappyStk` happyRest}

happyReduce_92 = happySpecReduce_2  43# happyReduction_92
happyReduction_92 happy_x_2
        happy_x_1
         =  case happyOut47 happy_x_1 of { (HappyWrap47 happy_var_1) -> 
        case happyOut50 happy_x_2 of { (HappyWrap50 happy_var_2) -> 
        happyIn51
                 ([PactDoc PactDocAnn happy_var_1, PactModel happy_var_2]
        )}}

happyReduce_93 = happySpecReduce_2  43# happyReduction_93
happyReduction_93 happy_x_2
        happy_x_1
         =  case happyOut50 happy_x_1 of { (HappyWrap50 happy_var_1) -> 
        case happyOut47 happy_x_2 of { (HappyWrap47 happy_var_2) -> 
        happyIn51
                 ([PactModel happy_var_1, PactDoc PactDocAnn happy_var_2]
        )}}

happyReduce_94 = happySpecReduce_1  43# happyReduction_94
happyReduction_94 happy_x_1
         =  case happyOut47 happy_x_1 of { (HappyWrap47 happy_var_1) -> 
        happyIn51
                 ([PactDoc PactDocAnn happy_var_1]
        )}

happyReduce_95 = happySpecReduce_1  43# happyReduction_95
happyReduction_95 happy_x_1
         =  case happyOut50 happy_x_1 of { (HappyWrap50 happy_var_1) -> 
        happyIn51
                 ([PactModel happy_var_1]
        )}

happyReduce_96 = happySpecReduce_1  43# happyReduction_96
happyReduction_96 happy_x_1
         =  case happyOut48 happy_x_1 of { (HappyWrap48 happy_var_1) -> 
        happyIn51
                 ([PactDoc PactDocString happy_var_1]
        )}

happyReduce_97 = happySpecReduce_0  43# happyReduction_97
happyReduction_97  =  happyIn51
                 ([]
        )

happyReduce_98 = happySpecReduce_1  44# happyReduction_98
happyReduction_98 happy_x_1
         =  case happyOut47 happy_x_1 of { (HappyWrap47 happy_var_1) -> 
        happyIn52
                 (Just (happy_var_1, PactDocAnn)
        )}

happyReduce_99 = happySpecReduce_1  44# happyReduction_99
happyReduction_99 happy_x_1
         =  case happyOut48 happy_x_1 of { (HappyWrap48 happy_var_1) -> 
        happyIn52
                 (Just (happy_var_1, PactDocString)
        )}

happyReduce_100 = happySpecReduce_0  44# happyReduction_100
happyReduction_100  =  happyIn52
                 (Nothing
        )

happyReduce_101 = happySpecReduce_2  45# happyReduction_101
happyReduction_101 happy_x_2
        happy_x_1
         =  case happyOut45 happy_x_2 of { (HappyWrap45 happy_var_2) -> 
        happyIn53
                 (Just happy_var_2
        )}

happyReduce_102 = happySpecReduce_0  45# happyReduction_102
happyReduction_102  =  happyIn53
                 (Nothing
        )

happyReduce_103 = happySpecReduce_1  46# happyReduction_103
happyReduction_103 happy_x_1
         =  case happyOut55 happy_x_1 of { (HappyWrap55 happy_var_1) -> 
        happyIn54
                 (NE.fromList (reverse happy_var_1)
        )}

happyReduce_104 = happySpecReduce_2  47# happyReduction_104
happyReduction_104 happy_x_2
        happy_x_1
         =  case happyOut55 happy_x_1 of { (HappyWrap55 happy_var_1) -> 
        case happyOut56 happy_x_2 of { (HappyWrap56 happy_var_2) -> 
        happyIn55
                 (happy_var_2:happy_var_1
        )}}

happyReduce_105 = happySpecReduce_1  47# happyReduction_105
happyReduction_105 happy_x_1
         =  case happyOut56 happy_x_1 of { (HappyWrap56 happy_var_1) -> 
        happyIn55
                 ([happy_var_1]
        )}

happyReduce_106 = happySpecReduce_3  48# happyReduction_106
happyReduction_106 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut57 happy_x_2 of { (HappyWrap57 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn56
                 (happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}}

happyReduce_107 = happySpecReduce_1  48# happyReduction_107
happyReduction_107 happy_x_1
         =  case happyOut72 happy_x_1 of { (HappyWrap72 happy_var_1) -> 
        happyIn56
                 (happy_var_1
        )}

happyReduce_108 = happySpecReduce_1  49# happyReduction_108
happyReduction_108 happy_x_1
         =  case happyOut62 happy_x_1 of { (HappyWrap62 happy_var_1) -> 
        happyIn57
                 (happy_var_1
        )}

happyReduce_109 = happySpecReduce_1  49# happyReduction_109
happyReduction_109 happy_x_1
         =  case happyOut64 happy_x_1 of { (HappyWrap64 happy_var_1) -> 
        happyIn57
                 (happy_var_1
        )}

happyReduce_110 = happySpecReduce_1  49# happyReduction_110
happyReduction_110 happy_x_1
         =  case happyOut66 happy_x_1 of { (HappyWrap66 happy_var_1) -> 
        happyIn57
                 (happy_var_1
        )}

happyReduce_111 = happySpecReduce_3  50# happyReduction_111
happyReduction_111 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut59 happy_x_2 of { (HappyWrap59 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn58
                 (List happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}}

happyReduce_112 = happySpecReduce_2  51# happyReduction_112
happyReduction_112 happy_x_2
        happy_x_1
         =  case happyOut56 happy_x_1 of { (HappyWrap56 happy_var_1) -> 
        case happyOut60 happy_x_2 of { (HappyWrap60 happy_var_2) -> 
        happyIn59
                 (happy_var_1:(reverse happy_var_2)
        )}}

happyReduce_113 = happySpecReduce_0  51# happyReduction_113
happyReduction_113  =  happyIn59
                 ([]
        )

happyReduce_114 = happySpecReduce_2  52# happyReduction_114
happyReduction_114 happy_x_2
        happy_x_1
         =  case happyOut61 happy_x_2 of { (HappyWrap61 happy_var_2) -> 
        happyIn60
                 (happy_var_2
        )}

happyReduce_115 = happySpecReduce_1  52# happyReduction_115
happyReduction_115 happy_x_1
         =  case happyOut67 happy_x_1 of { (HappyWrap67 happy_var_1) -> 
        happyIn60
                 (happy_var_1
        )}

happyReduce_116 = happySpecReduce_3  53# happyReduction_116
happyReduction_116 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut61 happy_x_1 of { (HappyWrap61 happy_var_1) -> 
        case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        happyIn61
                 (happy_var_3:happy_var_1
        )}}

happyReduce_117 = happySpecReduce_1  53# happyReduction_117
happyReduction_117 happy_x_1
         =  case happyOut56 happy_x_1 of { (HappyWrap56 happy_var_1) -> 
        happyIn61
                 ([happy_var_1]
        )}

happyReduce_118 = happyReduce 5# 54# happyReduction_118
happyReduction_118 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut63 happy_x_3 of { (HappyWrap63 happy_var_3) -> 
        case happyOut54 happy_x_5 of { (HappyWrap54 happy_var_5) -> 
        happyIn62
                 (Lam (reverse happy_var_3) happy_var_5
        ) `HappyStk` happyRest}}

happyReduce_119 = happyReduce 4# 55# happyReduction_119
happyReduction_119 (happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut63 happy_x_1 of { (HappyWrap63 happy_var_1) -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut45 happy_x_4 of { (HappyWrap45 happy_var_4) -> 
        happyIn63
                 ((MArg (getIdent happy_var_2) (Just happy_var_4) (_ptInfo happy_var_2)):happy_var_1
        ) `HappyStk` happyRest}}}

happyReduce_120 = happySpecReduce_2  55# happyReduction_120
happyReduction_120 happy_x_2
        happy_x_1
         =  case happyOut63 happy_x_1 of { (HappyWrap63 happy_var_1) -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        happyIn63
                 ((MArg (getIdent happy_var_2) Nothing (_ptInfo happy_var_2)):happy_var_1
        )}}

happyReduce_121 = happySpecReduce_0  55# happyReduction_121
happyReduction_121  =  happyIn63
                 ([]
        )

happyReduce_122 = happyReduce 5# 56# happyReduction_122
happyReduction_122 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut65 happy_x_3 of { (HappyWrap65 happy_var_3) -> 
        case happyOut54 happy_x_5 of { (HappyWrap54 happy_var_5) -> 
        happyIn64
                 (Let LFLetNormal (NE.fromList (reverse happy_var_3)) happy_var_5
        ) `HappyStk` happyRest}}

happyReduce_123 = happyReduce 5# 56# happyReduction_123
happyReduction_123 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut65 happy_x_3 of { (HappyWrap65 happy_var_3) -> 
        case happyOut54 happy_x_5 of { (HappyWrap54 happy_var_5) -> 
        happyIn64
                 (Let LFLetStar (NE.fromList (reverse happy_var_3)) happy_var_5
        ) `HappyStk` happyRest}}

happyReduce_124 = happyReduce 6# 57# happyReduction_124
happyReduction_124 (happy_x_6 `HappyStk`
        happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOut65 happy_x_1 of { (HappyWrap65 happy_var_1) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        case happyOut53 happy_x_4 of { (HappyWrap53 happy_var_4) -> 
        case happyOut56 happy_x_5 of { (HappyWrap56 happy_var_5) -> 
        happyIn65
                 ((Binder (MArg (getIdent happy_var_3) happy_var_4 (_ptInfo happy_var_3)) happy_var_5):happy_var_1
        ) `HappyStk` happyRest}}}}

happyReduce_125 = happyReduce 5# 57# happyReduction_125
happyReduction_125 (happy_x_5 `HappyStk`
        happy_x_4 `HappyStk`
        happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest)
         = case happyOutTok happy_x_2 of { happy_var_2 -> 
        case happyOut53 happy_x_3 of { (HappyWrap53 happy_var_3) -> 
        case happyOut56 happy_x_4 of { (HappyWrap56 happy_var_4) -> 
        happyIn65
                 ([Binder (MArg (getIdent happy_var_2) happy_var_3 (_ptInfo happy_var_2)) happy_var_4]
        ) `HappyStk` happyRest}}}

happyReduce_126 = happySpecReduce_2  58# happyReduction_126
happyReduction_126 happy_x_2
        happy_x_1
         =  case happyOut56 happy_x_1 of { (HappyWrap56 happy_var_1) -> 
        case happyOut68 happy_x_2 of { (HappyWrap68 happy_var_2) -> 
        happyIn66
                 (\i -> App happy_var_1 (toAppExprList i (reverse happy_var_2)) i
        )}}

happyReduce_127 = happySpecReduce_2  59# happyReduction_127
happyReduction_127 happy_x_2
        happy_x_1
         =  case happyOut67 happy_x_1 of { (HappyWrap67 happy_var_1) -> 
        case happyOut56 happy_x_2 of { (HappyWrap56 happy_var_2) -> 
        happyIn67
                 (happy_var_2:happy_var_1
        )}}

happyReduce_128 = happySpecReduce_0  59# happyReduction_128
happyReduction_128  =  happyIn67
                 ([]
        )

happyReduce_129 = happySpecReduce_2  60# happyReduction_129
happyReduction_129 happy_x_2
        happy_x_1
         =  case happyOut68 happy_x_1 of { (HappyWrap68 happy_var_1) -> 
        case happyOut56 happy_x_2 of { (HappyWrap56 happy_var_2) -> 
        happyIn68
                 ((Left happy_var_2):happy_var_1
        )}}

happyReduce_130 = happySpecReduce_2  60# happyReduction_130
happyReduction_130 happy_x_2
        happy_x_1
         =  case happyOut68 happy_x_1 of { (HappyWrap68 happy_var_1) -> 
        case happyOut69 happy_x_2 of { (HappyWrap69 happy_var_2) -> 
        happyIn68
                 ((Right happy_var_2):happy_var_1
        )}}

happyReduce_131 = happySpecReduce_0  60# happyReduction_131
happyReduction_131  =  happyIn68
                 ([]
        )

happyReduce_132 = happySpecReduce_3  61# happyReduction_132
happyReduction_132 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut71 happy_x_2 of { (HappyWrap71 happy_var_2) -> 
        happyIn69
                 (happy_var_2
        )}

happyReduce_133 = happySpecReduce_3  62# happyReduction_133
happyReduction_133 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
        happyIn70
                 ((Field (getStr happy_var_1), happy_var_3)
        )}}

happyReduce_134 = happySpecReduce_3  62# happyReduction_134
happyReduction_134 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
        happyIn70
                 ((Field (getTick happy_var_1), happy_var_3)
        )}}

happyReduce_135 = happySpecReduce_3  63# happyReduction_135
happyReduction_135 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut71 happy_x_1 of { (HappyWrap71 happy_var_1) -> 
        case happyOut70 happy_x_3 of { (HappyWrap70 happy_var_3) -> 
        happyIn71
                 (happy_var_3 : happy_var_1
        )}}

happyReduce_136 = happySpecReduce_1  63# happyReduction_136
happyReduction_136 happy_x_1
         =  case happyOut70 happy_x_1 of { (HappyWrap70 happy_var_1) -> 
        happyIn71
                 ([happy_var_1]
        )}

happyReduce_137 = happySpecReduce_1  64# happyReduction_137
happyReduction_137 happy_x_1
         =  case happyOut74 happy_x_1 of { (HappyWrap74 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_138 = happySpecReduce_1  64# happyReduction_138
happyReduction_138 happy_x_1
         =  case happyOut78 happy_x_1 of { (HappyWrap78 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_139 = happySpecReduce_1  64# happyReduction_139
happyReduction_139 happy_x_1
         =  case happyOut79 happy_x_1 of { (HappyWrap79 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_140 = happySpecReduce_1  64# happyReduction_140
happyReduction_140 happy_x_1
         =  case happyOut58 happy_x_1 of { (HappyWrap58 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_141 = happySpecReduce_1  64# happyReduction_141
happyReduction_141 happy_x_1
         =  case happyOut73 happy_x_1 of { (HappyWrap73 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_142 = happySpecReduce_1  64# happyReduction_142
happyReduction_142 happy_x_1
         =  case happyOut80 happy_x_1 of { (HappyWrap80 happy_var_1) -> 
        happyIn72
                 (happy_var_1
        )}

happyReduce_143 = happySpecReduce_2  64# happyReduction_143
happyReduction_143 happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_2 of { happy_var_2 -> 
        happyIn72
                 (Constant LUnit (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_2))
        )}}

happyReduce_144 = happySpecReduce_1  65# happyReduction_144
happyReduction_144 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn73
                 (Constant (LBool True) (_ptInfo happy_var_1)
        )}

happyReduce_145 = happySpecReduce_1  65# happyReduction_145
happyReduction_145 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn73
                 (Constant (LBool False) (_ptInfo happy_var_1)
        )}

happyReduce_146 = happySpecReduce_3  66# happyReduction_146
happyReduction_146 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        happyIn74
                 (Var (QN (mkQualName (getIdent happy_var_1) happy_var_3)) (combineSpan (_ptInfo happy_var_1) (view _3 happy_var_3))
        )}}

happyReduce_147 = happySpecReduce_1  66# happyReduction_147
happyReduction_147 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn74
                 (Var (BN (mkBarename (getIdent happy_var_1))) (_ptInfo happy_var_1)
        )}

happyReduce_148 = happySpecReduce_3  66# happyReduction_148
happyReduction_148 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn74
                 (Var (DN (DynamicName (getIdent happy_var_1) (getIdent happy_var_3))) (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}

happyReduce_149 = happySpecReduce_3  67# happyReduction_149
happyReduction_149 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        happyIn75
                 (QN (mkQualName (getIdent happy_var_1) happy_var_3)
        )}}

happyReduce_150 = happySpecReduce_1  67# happyReduction_150
happyReduction_150 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn75
                 (BN (mkBarename (getIdent happy_var_1))
        )}

happyReduce_151 = happySpecReduce_3  67# happyReduction_151
happyReduction_151 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn75
                 (DN (DynamicName (getIdent happy_var_1) (getIdent happy_var_3))
        )}}

happyReduce_152 = happySpecReduce_3  68# happyReduction_152
happyReduction_152 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        happyIn76
                 (TQN (mkQualName (getIdent happy_var_1) happy_var_3)
        )}}

happyReduce_153 = happySpecReduce_1  68# happyReduction_153
happyReduction_153 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn76
                 (TBN (mkBarename (getIdent happy_var_1))
        )}

happyReduce_154 = happySpecReduce_3  69# happyReduction_154
happyReduction_154 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn77
                 ((getIdent happy_var_1, Just (getIdent happy_var_3), (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))
        )}}

happyReduce_155 = happySpecReduce_1  69# happyReduction_155
happyReduction_155 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn77
                 ((getIdent happy_var_1, Nothing, _ptInfo happy_var_1)
        )}

happyReduce_156 = happyMonadReduce 3# 70# happyReduction_156
happyReduction_156 (happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest) tk
         = happyThen ((case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        ( mkDecimal Constant (getNumber happy_var_1) (getNumber happy_var_3) (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3)))}})
        ) (\r -> happyReturn (happyIn78 r))

happyReduce_157 = happySpecReduce_1  70# happyReduction_157
happyReduction_157 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn78
                 (mkIntegerConstant Constant (getNumber happy_var_1) (_ptInfo happy_var_1)
        )}

happyReduce_158 = happySpecReduce_1  71# happyReduction_158
happyReduction_158 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn79
                 (Constant (LString (getStr happy_var_1)) (_ptInfo happy_var_1)
        )}

happyReduce_159 = happySpecReduce_1  71# happyReduction_159
happyReduction_159 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn79
                 (Constant (LString (getTick happy_var_1)) (_ptInfo happy_var_1)
        )}

happyReduce_160 = happySpecReduce_3  72# happyReduction_160
happyReduction_160 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut81 happy_x_2 of { (HappyWrap81 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn80
                 (Object happy_var_2 (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}}

happyReduce_161 = happySpecReduce_1  73# happyReduction_161
happyReduction_161 happy_x_1
         =  case happyOut83 happy_x_1 of { (HappyWrap83 happy_var_1) -> 
        happyIn81
                 (reverse happy_var_1
        )}

happyReduce_162 = happySpecReduce_3  74# happyReduction_162
happyReduction_162 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        happyIn82
                 ((Field (getStr happy_var_1), happy_var_3)
        )}}

happyReduce_163 = happySpecReduce_3  74# happyReduction_163
happyReduction_163 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut56 happy_x_3 of { (HappyWrap56 happy_var_3) -> 
        happyIn82
                 ((Field (getTick happy_var_1), happy_var_3)
        )}}

happyReduce_164 = happySpecReduce_3  75# happyReduction_164
happyReduction_164 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOut83 happy_x_1 of { (HappyWrap83 happy_var_1) -> 
        case happyOut82 happy_x_3 of { (HappyWrap82 happy_var_3) -> 
        happyIn83
                 (happy_var_3 : happy_var_1
        )}}

happyReduce_165 = happySpecReduce_1  75# happyReduction_165
happyReduction_165 happy_x_1
         =  case happyOut82 happy_x_1 of { (HappyWrap82 happy_var_1) -> 
        happyIn83
                 ([happy_var_1]
        )}

happyReduce_166 = happySpecReduce_0  75# happyReduction_166
happyReduction_166  =  happyIn83
                 ([]
        )

happyReduce_167 = happySpecReduce_1  76# happyReduction_167
happyReduction_167 happy_x_1
         =  case happyOut85 happy_x_1 of { (HappyWrap85 happy_var_1) -> 
        happyIn84
                 (reverse happy_var_1
        )}

happyReduce_168 = happySpecReduce_2  77# happyReduction_168
happyReduction_168 happy_x_2
        happy_x_1
         =  case happyOut85 happy_x_1 of { (HappyWrap85 happy_var_1) -> 
        case happyOut86 happy_x_2 of { (HappyWrap86 happy_var_2) -> 
        happyIn85
                 (happy_var_2:happy_var_1
        )}}

happyReduce_169 = happySpecReduce_0  77# happyReduction_169
happyReduction_169  =  happyIn85
                 ([]
        )

happyReduce_170 = happySpecReduce_1  78# happyReduction_170
happyReduction_170 happy_x_1
         =  case happyOut87 happy_x_1 of { (HappyWrap87 happy_var_1) -> 
        happyIn86
                 (happy_var_1
        )}

happyReduce_171 = happySpecReduce_3  78# happyReduction_171
happyReduction_171 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut85 happy_x_2 of { (HappyWrap85 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn86
                 (PropSequence (reverse happy_var_2) (combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}}

happyReduce_172 = happySpecReduce_3  78# happyReduction_172
happyReduction_172 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut85 happy_x_2 of { (HappyWrap85 happy_var_2) -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn86
                 (propExprList happy_var_1 (reverse happy_var_2) happy_var_3
        )}}}

happyReduce_173 = happySpecReduce_1  79# happyReduction_173
happyReduction_173 happy_x_1
         =  case happyOut93 happy_x_1 of { (HappyWrap93 happy_var_1) -> 
        happyIn87
                 (uncurry PropAtom happy_var_1
        )}

happyReduce_174 = happySpecReduce_1  79# happyReduction_174
happyReduction_174 happy_x_1
         =  case happyOut91 happy_x_1 of { (HappyWrap91 happy_var_1) -> 
        happyIn87
                 (happy_var_1
        )}

happyReduce_175 = happySpecReduce_1  79# happyReduction_175
happyReduction_175 happy_x_1
         =  case happyOut92 happy_x_1 of { (HappyWrap92 happy_var_1) -> 
        happyIn87
                 (happy_var_1
        )}

happyReduce_176 = happySpecReduce_1  79# happyReduction_176
happyReduction_176 happy_x_1
         =  case happyOut88 happy_x_1 of { (HappyWrap88 happy_var_1) -> 
        happyIn87
                 (happy_var_1
        )}

happyReduce_177 = happySpecReduce_1  79# happyReduction_177
happyReduction_177 happy_x_1
         =  case happyOut89 happy_x_1 of { (HappyWrap89 happy_var_1) -> 
        happyIn87
                 (happy_var_1
        )}

happyReduce_178 = happySpecReduce_1  79# happyReduction_178
happyReduction_178 happy_x_1
         =  case happyOut90 happy_x_1 of { (HappyWrap90 happy_var_1) -> 
        happyIn87
                 (happy_var_1
        )}

happyReduce_179 = happySpecReduce_1  80# happyReduction_179
happyReduction_179 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn88
                 (PropKeyword KwLet (_ptInfo happy_var_1)
        )}

happyReduce_180 = happySpecReduce_1  80# happyReduction_180
happyReduction_180 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn88
                 (PropKeyword KwLambda (_ptInfo happy_var_1)
        )}

happyReduce_181 = happySpecReduce_1  81# happyReduction_181
happyReduction_181 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn89
                 (PropDelim DelimLBrace (_ptInfo happy_var_1)
        )}

happyReduce_182 = happySpecReduce_1  81# happyReduction_182
happyReduction_182 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn89
                 (PropDelim DelimRBrace (_ptInfo happy_var_1)
        )}

happyReduce_183 = happySpecReduce_1  81# happyReduction_183
happyReduction_183 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn89
                 (PropDelim DelimColon (_ptInfo happy_var_1)
        )}

happyReduce_184 = happySpecReduce_1  81# happyReduction_184
happyReduction_184 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn89
                 (PropDelim DelimComma (_ptInfo happy_var_1)
        )}

happyReduce_185 = happySpecReduce_1  82# happyReduction_185
happyReduction_185 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn90
                 (PropConstant (LBool True) (_ptInfo happy_var_1)
        )}

happyReduce_186 = happySpecReduce_1  82# happyReduction_186
happyReduction_186 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn90
                 (PropConstant (LBool False) (_ptInfo happy_var_1)
        )}

happyReduce_187 = happyMonadReduce 3# 83# happyReduction_187
happyReduction_187 (happy_x_3 `HappyStk`
        happy_x_2 `HappyStk`
        happy_x_1 `HappyStk`
        happyRest) tk
         = happyThen ((case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        ( mkDecimal PropConstant (getNumber happy_var_1) (getNumber happy_var_3) (_ptInfo happy_var_1))}})
        ) (\r -> happyReturn (happyIn91 r))

happyReduce_188 = happySpecReduce_1  83# happyReduction_188
happyReduction_188 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn91
                 (mkIntegerConstant PropConstant (getNumber happy_var_1) (_ptInfo happy_var_1)
        )}

happyReduce_189 = happySpecReduce_1  84# happyReduction_189
happyReduction_189 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn92
                 (PropConstant (LString (getStr happy_var_1)) (_ptInfo happy_var_1)
        )}

happyReduce_190 = happySpecReduce_1  84# happyReduction_190
happyReduction_190 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn92
                 (PropConstant (LString (getTick happy_var_1)) (_ptInfo happy_var_1)
        )}

happyReduce_191 = happySpecReduce_3  85# happyReduction_191
happyReduction_191 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOut77 happy_x_3 of { (HappyWrap77 happy_var_3) -> 
        happyIn93
                 ((QN (mkQualName (getIdent happy_var_1) happy_var_3), _ptInfo happy_var_1)
        )}}

happyReduce_192 = happySpecReduce_1  85# happyReduction_192
happyReduction_192 happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        happyIn93
                 ((BN (mkBarename (getIdent happy_var_1)), _ptInfo happy_var_1)
        )}

happyReduce_193 = happySpecReduce_3  85# happyReduction_193
happyReduction_193 happy_x_3
        happy_x_2
        happy_x_1
         =  case happyOutTok happy_x_1 of { happy_var_1 -> 
        case happyOutTok happy_x_3 of { happy_var_3 -> 
        happyIn93
                 ((DN (DynamicName (getIdent happy_var_1) (getIdent happy_var_3)), combineSpan (_ptInfo happy_var_1) (_ptInfo happy_var_3))
        )}}

happyTerminalToTok term = case term of {
        PosToken TokenLet _ -> 2#;
        PosToken TokenLetStar _ -> 3#;
        PosToken TokenLambda _ -> 4#;
        PosToken TokenModule _ -> 5#;
        PosToken TokenInterface _ -> 6#;
        PosToken TokenImport _ -> 7#;
        PosToken TokenDefun _ -> 8#;
        PosToken TokenDefCap _ -> 9#;
        PosToken TokenDefConst _ -> 10#;
        PosToken TokenDefSchema _ -> 11#;
        PosToken TokenDefTable _ -> 12#;
        PosToken TokenDefPact _ -> 13#;
        PosToken TokenBless _ -> 14#;
        PosToken TokenImplements _ -> 15#;
        PosToken TokenTrue _ -> 16#;
        PosToken TokenFalse _ -> 17#;
        PosToken TokenDocAnn _ -> 18#;
        PosToken TokenModelAnn _ -> 19#;
        PosToken TokenEventAnn _ -> 20#;
        PosToken TokenManagedAnn _ -> 21#;
        PosToken TokenStep _ -> 22#;
        PosToken TokenStepWithRollback _ -> 23#;
        PosToken TokenOpenBrace _ -> 24#;
        PosToken TokenCloseBrace _ -> 25#;
        PosToken TokenOpenParens _ -> 26#;
        PosToken TokenCloseParens _ -> 27#;
        PosToken TokenOpenBracket _ -> 28#;
        PosToken TokenCloseBracket _ -> 29#;
        PosToken TokenComma _ -> 30#;
        PosToken TokenDynAcc _ -> 31#;
        PosToken TokenColon _ -> 32#;
        PosToken TokenBindAssign _ -> 33#;
        PosToken TokenDot _ -> 34#;
        PosToken (TokenIdent _) _ -> 35#;
        PosToken (TokenNumber _) _ -> 36#;
        PosToken (TokenString _) _ -> 37#;
        PosToken (TokenSingleTick _) _ -> 38#;
        _ -> -1#;
        }
{-# NOINLINE happyTerminalToTok #-}

happyLex kend  _kmore []       = kend notHappyAtAll []
happyLex _kend kmore  (tk:tks) = kmore (happyTerminalToTok tk) tk tks
{-# INLINE happyLex #-}

happyNewToken action sts stk = happyLex (\tk -> happyDoAction 39# notHappyAtAll action sts stk) (\i tk -> happyDoAction i tk action sts stk)

happyReport 39# tk explist resume tks = happyReport' tks explist resume
happyReport _ tk explist resume tks = happyReport' (tk:tks) explist (\tks -> resume (Happy_Prelude.tail tks))


happyThen :: () => (ParserT a) -> (a -> (ParserT b)) -> (ParserT b)
happyThen = (Happy_Prelude.>>=)
happyReturn :: () => a -> (ParserT a)
happyReturn = (Happy_Prelude.return)
happyThen1 m k tks = (Happy_Prelude.>>=) m (\a -> k a tks)
happyFmap1 f m tks = happyThen (m tks) (\a -> happyReturn (f a))
happyReturn1 :: () => a -> b -> (ParserT a)
happyReturn1 = \a tks -> (Happy_Prelude.return) a
happyReport' :: () => [(PosToken)] -> [Happy_Prelude.String] -> ([(PosToken)] -> (ParserT a)) -> (ParserT a)
happyReport' = (\tokens expected resume -> (parseError) (tokens, expected))

happyAbort :: () => [(PosToken)] -> (ParserT a)
happyAbort = Happy_Prelude.error "Called abort handler in non-resumptive parser"

parseExpr tks = happySomeParser where
 happySomeParser = happyThen (happyDoParse 0# tks) (\x -> happyReturn (let {(HappyWrap56 x') = happyOut56 x} in x'))

parseModule tks = happySomeParser where
 happySomeParser = happyThen (happyDoParse 1# tks) (\x -> happyReturn (let {(HappyWrap16 x') = happyOut16 x} in x'))

parseReplProgram tks = happySomeParser where
 happySomeParser = happyThen (happyDoParse 2# tks) (\x -> happyReturn (let {(HappyWrap10 x') = happyOut10 x} in x'))

parseProgram tks = happySomeParser where
 happySomeParser = happyThen (happyDoParse 3# tks) (\x -> happyReturn (let {(HappyWrap8 x') = happyOut8 x} in x'))

happySeq = happyDontSeq


combineSpans lexpr rexpr =
  let li = view termInfo lexpr
      ri = view termInfo rexpr
  in combineSpan li ri

getIdent (PosToken (TokenIdent x) _) = x
getNumber (PosToken (TokenNumber x) _) = x
getStr (PosToken (TokenString x) _ ) = x
getTick (PosToken (TokenSingleTick x) _) = T.drop 1 x
getIdentField = Field . getIdent

mkIntegerConstant ctor n i =
  let (n', f) = if T.head n == '-' then (T.drop 1 n, negate) else (n, id)
      strToNum = T.foldl' (\x d -> 10*x + toInteger (digitToInt d))
  in ctor (LInteger (f (strToNum 0 n'))) i

mkDecimal ctor num dec i = do
  let (num', f) = if T.head num == '-' then (T.drop 1 num, negate) else (num, id)
      strToNum = T.foldl' (\x d -> 10*x + toInteger (digitToInt d))
      prec = T.length dec
  when (prec > 255) $ throwParseError (PrecisionOverflowError prec) i
  let out = Decimal (fromIntegral prec) (f (strToNum (strToNum 0 num') dec))
  pure $ ctor (LDecimal out) i

mkQualName ns (mod, (Just ident), _) =
  let ns' = NamespaceName ns
  in QualifiedName ident (ModuleName mod (Just ns'))
mkQualName mod (ident, Nothing, _) =
  QualifiedName ident (ModuleName mod Nothing)

mkQualName' ns (mod, (Just ident)) =
  let ns' = NamespaceName ns
  in QualifiedName ident (ModuleName mod (Just ns'))
mkQualName' mod (ident, Nothing) = QualifiedName ident (ModuleName mod Nothing)


mkModName (ident, Nothing, _) = ModuleName ident Nothing
mkModName (ns, Just ident, _) = ModuleName ident (Just (NamespaceName ns))

propExprList tokLBracket li tokRBracket =
  let lbracket = PropDelim DelimLBracket (_ptInfo tokLBracket)
      rbracket = PropDelim DelimRBracket (_ptInfo tokRBracket)
      finfo = combineSpan (_ptInfo tokLBracket) (_ptInfo tokRBracket)
  in PropSequence ((lbracket:li)++[rbracket]) finfo

mkBarename tx = BareName tx
#define HAPPY_COERCE 1
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $

#if !defined(__GLASGOW_HASKELL__)
#  error This code isn't being built with GHC.
#endif

-- Get WORDS_BIGENDIAN (if defined)
#include "MachDeps.h"

-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Happy_Prelude.Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Happy_Prelude.Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Happy_Prelude.Bool)
#define PLUS(n,m) (n Happy_GHC_Exts.+# m)
#define MINUS(n,m) (n Happy_GHC_Exts.-# m)
#define TIMES(n,m) (n Happy_GHC_Exts.*# m)
#define NEGATE(n) (Happy_GHC_Exts.negateInt# (n))

type Happy_Int = Happy_GHC_Exts.Int#
data Happy_IntList = HappyCons Happy_Int Happy_IntList

#define INVALID_TOK -1#
#define ERROR_TOK 0#
#define CATCH_TOK 1#

#if defined(HAPPY_COERCE)
#  define GET_ERROR_TOKEN(x)  (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (happyInTok (x))
#else
#  define GET_ERROR_TOKEN(x)  (case x of { HappyErrorToken (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (HappyErrorToken (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (HappyTerminal (x))
#endif

#if defined(HAPPY_DEBUG)
#  define DEBUG_TRACE(s)    (happyTrace (s)) Happy_Prelude.$
happyTrace string expr = Happy_System_IO_Unsafe.unsafePerformIO Happy_Prelude.$ do
    Happy_System_IO.hPutStr Happy_System_IO.stderr string
    Happy_Prelude.return expr
#else
#  define DEBUG_TRACE(s)    {- nothing -}
#endif

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyDoParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept ERROR_TOK tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) =
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

happyDoAction i tk st =
  DEBUG_TRACE("state: " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++
              ",\ttoken: " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# i) Happy_Prelude.++
              ",\taction: ")
  case happyDecodeAction (happyNextAction i st) of
    HappyFail             -> DEBUG_TRACE("failing.\n")
                             happyFail i tk st
    HappyAccept           -> DEBUG_TRACE("accept.\n")
                             happyAccept i tk st
    HappyReduce rule      -> DEBUG_TRACE("reduce (rule " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# rule) Happy_Prelude.++ ")")
                             (happyReduceArr Happy_Data_Array.! (Happy_GHC_Exts.I# rule)) i tk st
    HappyShift  new_state -> DEBUG_TRACE("shift, enter state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# new_state) Happy_Prelude.++ "\n")
                             happyShift new_state i tk st

{-# INLINE happyNextAction #-}
happyNextAction i st = case happyIndexActionTable i st of
  Happy_Prelude.Just (Happy_GHC_Exts.I# act) -> act
  Happy_Prelude.Nothing                      -> happyIndexOffAddr happyDefActions st

{-# INLINE happyIndexActionTable #-}
happyIndexActionTable i st
  | GTE(i, 0#), GTE(off, 0#), EQ(happyIndexOffAddr happyCheck off, i)
  -- i >= 0:   Guard against INVALID_TOK (do the default action, which ultimately errors)
  -- off >= 0: Otherwise it's a default action
  -- equality check: Ensure that the entry in the compressed array is owned by st
  = Happy_Prelude.Just (Happy_GHC_Exts.I# (happyIndexOffAddr happyTable off))
  | Happy_Prelude.otherwise
  = Happy_Prelude.Nothing
  where
    off = PLUS(happyIndexOffAddr happyActOffsets st, i)

data HappyAction
  = HappyFail
  | HappyAccept
  | HappyReduce Happy_Int -- rule number
  | HappyShift Happy_Int  -- new state
  deriving Happy_Prelude.Show

{-# INLINE happyDecodeAction #-}
happyDecodeAction :: Happy_Int -> HappyAction
happyDecodeAction  0#                        = HappyFail
happyDecodeAction -1#                        = HappyAccept
happyDecodeAction action | LT(action, 0#)    = HappyReduce NEGATE(PLUS(action, 1#))
                         | Happy_Prelude.otherwise = HappyShift MINUS(action, 1#)

{-# INLINE happyIndexGotoTable #-}
happyIndexGotoTable nt st = happyIndexOffAddr happyTable off
  where
    off = PLUS(happyIndexOffAddr happyGotoOffsets st, nt)

{-# INLINE happyIndexOffAddr #-}
happyIndexOffAddr :: HappyAddr -> Happy_Int -> Happy_Int
happyIndexOffAddr (HappyA# arr) off =
#if __GLASGOW_HASKELL__ >= 901
  Happy_GHC_Exts.int32ToInt# -- qualified import because it doesn't exist on older GHC's
#endif
#ifdef WORDS_BIGENDIAN
  -- The CI of `alex` tests this code path
  (Happy_GHC_Exts.word32ToInt32# (Happy_GHC_Exts.wordToWord32# (Happy_GHC_Exts.byteSwap32# (Happy_GHC_Exts.word32ToWord# (Happy_GHC_Exts.int32ToWord32#
#endif
  (Happy_GHC_Exts.indexInt32OffAddr# arr off)
#ifdef WORDS_BIGENDIAN
  )))))
#endif

happyIndexRuleArr :: Happy_Int -> (# Happy_Int, Happy_Int #)
happyIndexRuleArr r = (# nt, len #)
  where
    !(Happy_GHC_Exts.I# n_starts) = happy_n_starts
    offs = TIMES(MINUS(r,n_starts),2#)
    nt = happyIndexOffAddr happyRuleArr offs
    len = happyIndexOffAddr happyRuleArr PLUS(offs,1#)

data HappyAddr = HappyA# Happy_GHC_Exts.Addr#

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state ERROR_TOK tk st sts stk@(x `HappyStk` _) =
     -- See "Error Fixup" below
     let i = GET_ERROR_TOKEN(x) in
     DEBUG_TRACE("shifting the error token")
     happyDoAction i tk new_state (HappyCons st sts) stk

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons st sts) (MK_TOKEN(tk) `HappyStk` stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 nt fn j tk st sts stk
     = happySeq fn (happyGoto nt j tk st (HappyCons st sts) (fn `HappyStk` stk))

happySpecReduce_1 nt fn j tk old_st sts@(HappyCons st _) (v1 `HappyStk` stk')
     = let r = fn v1 in
       happyTcHack old_st (happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk')))

happySpecReduce_2 nt fn j tk old_st
  (HappyCons _ sts@(HappyCons st _))
  (v1 `HappyStk` v2 `HappyStk` stk')
     = let r = fn v1 v2 in
       happyTcHack old_st (happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk')))

happySpecReduce_3 nt fn j tk old_st
  (HappyCons _ (HappyCons _ sts@(HappyCons st _)))
  (v1 `HappyStk` v2 `HappyStk` v3 `HappyStk` stk')
     = let r = fn v1 v2 v3 in
       happyTcHack old_st (happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk')))

happyReduce k nt fn j tk st sts stk
     = case happyDrop MINUS(k,(1# :: Happy_Int)) sts of
         sts1@(HappyCons st1 _) ->
                let r = fn stk in -- it doesn't hurt to always seq here...
                st `happyTcHack` happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk in
          j `happyTcHack` happyThen1 (fn stk tk)
                                     (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk
              off = happyIndexOffAddr happyGotoOffsets st1
              off_i = PLUS(off, nt)
              new_state = happyIndexOffAddr happyTable off_i
          in
            j `happyTcHack` happyThen1 (fn stk tk)
                                       (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l               = l
happyDrop n  (HappyCons _ t) = happyDrop MINUS(n,(1# :: Happy_Int)) t

happyDropStk 0# l                 = l
happyDropStk n  (x `HappyStk` xs) = happyDropStk MINUS(n,(1#::Happy_Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

happyGoto nt j tk st =
   DEBUG_TRACE(", goto state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# new_state) Happy_Prelude.++ "\n")
   happyDoAction j tk new_state
  where new_state = happyIndexGotoTable nt st

{- Note [Error recovery]
~~~~~~~~~~~~~~~~~~~~~~~~
When there is no applicable action for the current lookahead token `tk`,
happy enters error recovery mode. Depending on whether the grammar file
declares the two action form `%error { abort } { report }` for
    Resumptive Error Handling,
it works in one (not resumptive) or two phases (resumptive):

 1. Fixup mode:
    Try to see if there is an action for the error token ERROR_TOK. If there
    is, do *not* emit an error and pretend instead that an `error` token was
    inserted.
    When there is no ERROR_TOK action, report an error.

    In non-resumptive error handling, calling the single error handler
    (e.g. `happyError`) will throw an exception and abort the parser.
    However, in resumptive error handling we enter *error resumption mode*.

 2. Error resumption mode:
    After reporting the error (with `report`), happy will attempt to find
    a good state stack to resume parsing in.
    For each candidate stack, it discards input until one of the candidates
    resumes (i.e. shifts the current input).
    If no candidate resumes before the end of input, resumption failed and
    calls the `abort` function, to much the same effect as in non-resumptive
    error handling.

    Candidate stacks are declared by the grammar author using the special
    `catch` terminal and called "catch frames".
    This mechanism is described in detail in Note [happyResume].

The `catch` resumption mechanism (2) is what usually is associated with
`error` in `bison` or `menhir`. Since `error` is used for the Fixup mechanism
(1) above, we call the corresponding token `catch`.
Furthermore, in constrast to `bison`, our implementation of `catch`
non-deterministically considers multiple catch frames on the stack for
resumption (See Note [Multiple catch frames]).

Note [happyResume]
~~~~~~~~~~~~~~~~~~
`happyResume` implements the resumption mechanism from Note [Error recovery].
It is best understood by example. Consider

Exp :: { String }
Exp : '1'                { "1" }
    | catch              { "catch" }
    | Exp '+' Exp %shift { $1 Happy_Prelude.++ " + " Happy_Prelude.++ $3 } -- %shift: associate 1 + 1 + 1 to the right
    | '(' Exp ')'        { "(" Happy_Prelude.++ $2 Happy_Prelude.++ ")" }

The idea of the use of `catch` here is that upon encountering a parse error
during expression parsing, we can gracefully degrade using the `catch` rule,
still producing a partial syntax tree and keep on parsing to find further
syntax errors.

Let's trace the parser state for input 11+1, which will error out after shifting 1.
After shifting, we have the following item stack (growing downwards and omitting
transitive closure items):

  State 0: %start_parseExp -> . Exp
  State 5: Exp -> '1' .

(Stack as a list of state numbers: [5,0].)
As Note [Error recovery] describes, we will first try Fixup mode.
That fails because no production can shift the `error` token.
Next we try Error resumption mode. This works as follows:

  1. Pop off the item stack until we find an item that can shift the `catch`
     token. (Implemented in `pop_items`.)
       * State 5 cannot shift catch. Pop.
       * State 0 can shift catch, which would transition into
          State 4: Exp -> catch .
     So record the *stack* `[4,0]` after doing the shift transition.
     We call this a *catch frame*, where the top is a *catch state*,
     corresponding to an item in which we just shifted a `catch` token.
     There can be multiple such catch stacks, see Note [Multiple catch frames].

  2. Discard tokens from the input until the lookahead can be shifted in one
     of the catch stacks. (Implemented in `discard_input_until_exp` and
     `some_catch_state_shifts`.)
       * We cannot shift the current lookahead '1' in state 4, so we discard
       * We *can* shift the next lookahead '+' in state 4, but only after
         reducing, which pops State 4 and goes to State 3:
           State 3: %start_parseExp -> Exp .
                    Exp -> Exp . '+' Exp
         Here we can shift '+'.
     As you can see, to implement this machinery we need to simulate
     the operation of the LALR automaton, especially reduction
     (`happySimulateReduce`).

Note [Multiple catch frames]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For fewer spurious error messages, it can be beneficial to trace multiple catch
items. Consider

Exp : '1'
    | catch
    | Exp '+' Exp %shift
    | '(' Exp ')'

Let's trace the parser state for input (;+1, which will error out after shifting (.
After shifting, we have the following item stack (growing downwards):

  State 0: %start_parseExp -> . Exp
  State 6: Exp -> '(' . Exp ')'

Upon error, we want to find items in the stack which can shift a catch token.
Note that both State 0 and State 6 can shift a catch token, transitioning into
  State 4: Exp -> catch .
Hence we record the catch frames `[4,6,0]` and `[4,0]` for possible resumption.

Which catch frame do we pick for resumption?
Note that resuming catch frame `[4,0]` will parse as "catch+1", whereas
resuming the innermost frame `[4,6,0]` corresponds to parsing "(catch+1".
The latter would keep discarding input until the closing ')' is found.
So we will discard + and 1, leading to a spurious syntax error at the end of
input, aborting the parse and never producing a partial syntax tree. Bad!

It is far preferable to resume with catch frame `[4,0]`, where we can resume
successfully on input +, so that is what we do.

In general, we pick the catch frame for resumption that discards the least
amount of input for a successful shift, preferring the topmost such catch frame.
-}

-- happyFail :: Happy_Int -> Token -> Happy_Int -> _
-- This function triggers Note [Error recovery].
-- If the current token is ERROR_TOK, phase (1) has failed and we might try
-- phase (2).
happyFail ERROR_TOK = happyFixupFailed
happyFail i         = happyTryFixup i

-- Enter Error Fixup (see Note [Error recovery]):
-- generate an error token, save the old token and carry on.
-- When a `happyShift` accepts the error token, we will pop off the error token
-- to resume parsing with the current lookahead `i`.
happyTryFixup i tk action sts stk =
  DEBUG_TRACE("entering `error` fixup.\n")
  happyDoAction ERROR_TOK tk action sts (MK_ERROR_TOKEN(i) `HappyStk` stk)
  -- NB: `happyShift` will simply pop the error token and carry on with
  --     `tk`. Hence we don't change `tk` in the call here

-- See Note [Error recovery], phase (2).
-- Enter resumption mode after reporting the error by calling `happyResume`.
happyFixupFailed tk st sts (x `HappyStk` stk) =
  let i = GET_ERROR_TOKEN(x) in
  DEBUG_TRACE("`error` fixup failed.\n")
  let resume   = happyResume i tk st sts stk
      expected = happyExpectedTokens st sts in
  happyReport i tk expected resume

-- happyResume :: Happy_Int -> Token -> Happy_Int -> _
-- See Note [happyResume]
happyResume i tk st sts stk = pop_items [] st sts stk
  where
    !(Happy_GHC_Exts.I# n_starts) = happy_n_starts   -- this is to test whether we have a start token
    !(Happy_GHC_Exts.I# eof_i) = happy_n_terms Happy_Prelude.- 1   -- this is the token number of the EOF token
    happy_list_to_list :: Happy_IntList -> [Happy_Prelude.Int]
    happy_list_to_list (HappyCons st sts)
      | LT(st, n_starts)
      = [(Happy_GHC_Exts.I# st)]
      | Happy_Prelude.otherwise
      = (Happy_GHC_Exts.I# st) : happy_list_to_list sts

    -- See (1) of Note [happyResume]
    pop_items catch_frames st sts stk
      | LT(st, n_starts)
      = DEBUG_TRACE("reached start state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ ", ")
        if Happy_Prelude.null catch_frames_new
          then DEBUG_TRACE("no resumption.\n")
               happyAbort
          else DEBUG_TRACE("now discard input, trying to anchor in states " Happy_Prelude.++ Happy_Prelude.show (Happy_Prelude.map (happy_list_to_list . Happy_Prelude.fst) (Happy_Prelude.reverse catch_frames_new)) Happy_Prelude.++ ".\n")
               discard_input_until_exp i tk (Happy_Prelude.reverse catch_frames_new)
      | (HappyCons st1 sts1) <- sts, _ `HappyStk` stk1 <- stk
      = pop_items catch_frames_new st1 sts1 stk1
      where
        !catch_frames_new
          | HappyShift new_state <- happyDecodeAction (happyNextAction CATCH_TOK st)
          , DEBUG_TRACE("can shift catch token in state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ ", into state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# new_state) Happy_Prelude.++ "\n")
            Happy_Prelude.null (Happy_Prelude.filter (\(HappyCons _ (HappyCons h _),_) -> EQ(st,h)) catch_frames)
          = (HappyCons new_state (HappyCons st sts), MK_ERROR_TOKEN(i) `HappyStk` stk):catch_frames -- MK_ERROR_TOKEN(i) is just some dummy that should not be accessed by user code
          | Happy_Prelude.otherwise
          = DEBUG_TRACE("already shifted or can't shift catch in " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ "\n")
            catch_frames

    -- See (2) of Note [happyResume]
    discard_input_until_exp i tk catch_frames
      | Happy_Prelude.Just (HappyCons st (HappyCons catch_st sts), catch_frame) <- some_catch_state_shifts i catch_frames
      = DEBUG_TRACE("found expected token in state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ " after shifting from " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# catch_st) Happy_Prelude.++ ": " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# i) Happy_Prelude.++ "\n")
        happyDoAction i tk st (HappyCons catch_st sts) catch_frame
      | EQ(i,eof_i) -- is i EOF?
      = DEBUG_TRACE("reached EOF, cannot resume. abort parse :(\n")
        happyAbort
      | Happy_Prelude.otherwise
      = DEBUG_TRACE("discard token " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# i) Happy_Prelude.++ "\n")
        happyLex (\eof_tk -> discard_input_until_exp eof_i eof_tk catch_frames) -- eof
                 (\i tk   -> discard_input_until_exp i tk catch_frames)         -- not eof

    some_catch_state_shifts _ [] = DEBUG_TRACE("no catch state could shift.\n") Happy_Prelude.Nothing
    some_catch_state_shifts i catch_frames@(((HappyCons st sts),_):_) = try_head i st sts catch_frames
      where
        try_head i st sts catch_frames = -- PRECONDITION: head catch_frames = (HappyCons st sts)
          DEBUG_TRACE("trying token " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# i) Happy_Prelude.++ " in state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ ": ")
          case happyDecodeAction (happyNextAction i st) of
            HappyFail     -> DEBUG_TRACE("fail.\n")   some_catch_state_shifts i (Happy_Prelude.tail catch_frames)
            HappyAccept   -> DEBUG_TRACE("accept.\n") Happy_Prelude.Just (Happy_Prelude.head catch_frames)
            HappyShift _  -> DEBUG_TRACE("shift.\n")  Happy_Prelude.Just (Happy_Prelude.head catch_frames)
            HappyReduce r -> case happySimulateReduce r st sts of
              (HappyCons st1 sts1) -> try_head i st1 sts1 catch_frames

happySimulateReduce r st sts =
  DEBUG_TRACE("simulate reduction of rule " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# r) Happy_Prelude.++ ", ")
  let (# nt, len #) = happyIndexRuleArr r in
  DEBUG_TRACE("nt " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# nt) Happy_Prelude.++ ", len: " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# len) Happy_Prelude.++ ", new_st ")
  let !(sts1@(HappyCons st1 _)) = happyDrop len (HappyCons st sts)
      new_st = happyIndexGotoTable nt st1 in
  DEBUG_TRACE(Happy_Prelude.show (Happy_GHC_Exts.I# new_st) Happy_Prelude.++ ".\n")
  (HappyCons new_st sts1)

happyTokenToString :: Happy_Prelude.Int -> Happy_Prelude.String
happyTokenToString i = happyTokenStrings Happy_Prelude.!! (i Happy_Prelude.- 2) -- 2: errorTok, catchTok

happyExpectedTokens :: Happy_Int -> Happy_IntList -> [Happy_Prelude.String]
-- Upon a parse error, we want to suggest tokens that are expected in that
-- situation. This function computes such tokens.
-- It works by examining the top of the state stack.
-- For every token number that does a shift transition, record that token number.
-- For every token number that does a reduce transition, simulate that reduction
-- on the state state stack and repeat.
-- The recorded token numbers are then formatted with 'happyTokenToString' and
-- returned.
happyExpectedTokens st sts =
  DEBUG_TRACE("constructing expected tokens.\n")
  Happy_Prelude.map happyTokenToString (search_shifts st sts [])
  where
    search_shifts st sts shifts = Happy_Prelude.foldr (add_action st sts) shifts (distinct_actions st)
    add_action st sts (Happy_GHC_Exts.I# i, Happy_GHC_Exts.I# act) shifts =
      DEBUG_TRACE("found action in state " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# st) Happy_Prelude.++ ", input " Happy_Prelude.++ Happy_Prelude.show (Happy_GHC_Exts.I# i) Happy_Prelude.++ ", " Happy_Prelude.++ Happy_Prelude.show (happyDecodeAction act) Happy_Prelude.++ "\n")
      case happyDecodeAction act of
        HappyFail     -> shifts
        HappyAccept   -> shifts -- This would always be %eof or error... Not helpful
        HappyShift _  -> Happy_Prelude.insert (Happy_GHC_Exts.I# i) shifts
        HappyReduce r -> case happySimulateReduce r st sts of
          (HappyCons st1 sts1) -> search_shifts st1 sts1 shifts
    distinct_actions st
      -- The (token number, action) pairs of all actions in the given state
      = ((-1), (Happy_GHC_Exts.I# (happyIndexOffAddr happyDefActions st)))
      : [ (i, act) | i <- [begin_i..happy_n_terms], act <- get_act row_off i ]
      where
        row_off = happyIndexOffAddr happyActOffsets st
        begin_i = 2 -- +2: errorTok,catchTok
    get_act off (Happy_GHC_Exts.I# i) -- happyIndexActionTable with cached row offset
      | let off_i = PLUS(off,i)
      , GTE(off_i,0#)
      , EQ(happyIndexOffAddr happyCheck off_i,i)
      = [(Happy_GHC_Exts.I# (happyIndexOffAddr happyTable off_i))]
      | Happy_Prelude.otherwise
      = []

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Happy_Prelude.error "Internal Happy parser panic. This is not supposed to happen! Please open a bug report at https://github.com/haskell/happy/issues.\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions

happyTcHack :: Happy_Int -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}

-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Happy_GHC_Exts.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
