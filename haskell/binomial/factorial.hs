-- Miguel Ramos, 2015.
{-# LANGUAGE BangPatterns, MagicHash #-}

module Main (main) where

import GHC.Exts -- From this we use I# which is the data constructor to box and unbox Ints.
import GHC.Prim -- From this we use the primitive type GHC.Prim.Int# and its operators.

import System.Environment (getArgs)

{-# NOINLINE factorial #-}
factorial 0 = 1
factorial n = n * factorial (n - 1)

{-# NOINLINE wrapper #-}
wrapper :: Int -> Int
wrapper (I# n) = I# (worker n)

{-# NOINLINE worker #-}
worker :: Int# -> Int#
worker =
  \ n ->
    case n of
      0# -> 1#
      _  ->
        case n -# 1# of
          m ->
            case worker m of
              a -> n *# a

main = do
  args <- getArgs
  case args of
    [ "fact", arg ]     | n <- read arg -> print $ factorial n
    [ "wrapper", arg ]  | n <- read arg -> print $ wrapper n
