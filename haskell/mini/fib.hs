-- Miguel Ramos, 2015.
{-# LANGUAGE BangPatterns, MagicHash #-}

module Main (main) where

import Prelude hiding (tail)

import GHC.Exts -- From this we use I# which is the data constructor to box and unbox Ints.
import GHC.Prim -- From this we use the primitive type GHC.Prim.Int# and its operators.

import System.Environment (getArgs)

{-# NOINLINE naive #-}
naive :: Int -> Int
naive 0 = 0
naive 1 = 1
naive n = let i = n - 1
              j = n - 2
          in naive i + naive j

{-# NOINLINE stgNaive #-}
stgNaive :: Int -> Int
stgNaive =
  \ n ->
    case n of
      I# i ->
        case stgNaive' i of
          a -> let box :: Int
                   box = I# a
               in box

stgNaive' :: Int# -> Int#
stgNaive' =
  \ n ->
    case n of
      0# -> 0#
      1# -> 1#
      _  -> 
        case n -# 1# of
          i ->
            case stgNaive' i of
              a ->
                case n -# 2# of
                  j ->
                    case stgNaive' j of
                      b -> a +# b

{-# NOINLINE tail #-}
tail :: Int -> Int
tail = tail' 0 1
  where tail' a b 0 = b `seq` a
        tail' a b n = tail' b (a + b) (n - 1)

{-# NOINLINE stgTail #-}
stgTail :: Int -> Int
stgTail =
  \ n ->
    case n of
      I# i ->
        case stgTail' 0# 1# i of
          a -> let box :: Int
                   box = I# a
               in box

stgTail' :: Int# -> Int# -> Int# -> Int#
stgTail' =
  \ a b n ->
    case n of
      0# -> a
      _  ->
        case n -# 1# of
          p ->
            case a +# b of
              c -> stgTail' b c p

main = do
  args <- getArgs
  case args of
    [ "naive", arg ]    | n <- read arg -> print $ naive n
    [ "stgNaive", arg ] | n <- read arg -> print $ stgNaive n
    [ "tail", arg ]     | n <- read arg -> print $ tail n
    [ "stgTail", arg ]  | n <- read arg -> print $ stgTail n
