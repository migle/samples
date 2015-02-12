-- Miguel Ramos, 2015.

-- We use two language extensions mostly so that we can write Haskell code which is a pretty direct
-- translation from lower-level STG code.
-- BangPatters allows us to force function parameters to be strict.
-- MagicHash is required so we can use the '#' character, as in GHC.Prim.Int#.
{-# LANGUAGE BangPatterns, MagicHash #-}

module Factorial (factorial) where

import GHC.Exts -- From this we use I# which is the data constructor to box and unbox Ints.
import GHC.Prim -- From this we use the primitive type GHC.Prim.Int# and its operators.

factorial :: Int# -> Int#
factorial 0# = 1#
factorial n = n *# factorial (n -# 1#)
