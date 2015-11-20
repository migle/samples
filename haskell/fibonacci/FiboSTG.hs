-- Miguel Ramos, 2015.
{-# LANGUAGE BangPatterns, MagicHash #-}

module FiboSTG (fib, fibs) where

import GHC.Exts -- From this we use I# which is the data constructor to box and unbox Ints.
import GHC.Prim -- From this we use the primitive type GHC.Prim.Int# and its operators.

{-# NOINLINE positive' #-}
positive' :: Int# -> Int# -> Int# -> Int#
positive' =
  \ a b n ->
    case n of
      0# -> a
      1# -> b
      _  ->
        case n -# 1# of
          i ->
            case positive' a b i of
              x ->
                case n -# 2# of
                  j ->
                    case positive' a b j of
                      y -> x +# y

{-# NOINLINE negative' #-}
negative' :: Int# -> Int# -> Int# -> Int#
negative' =
  \ a b n ->
    case n of
      0# -> a
      1# -> b
      _  ->
        case n +# 2# of
          i ->
            case negative' a b i of
              x ->
                case n +# 1# of
                  j ->
                    case negative' a b j of
                      y -> x -# y

positive :: Int -> Int -> Int -> Int
positive =
  \ a b n ->
    case a of
      I# a' ->
        case b of
          I# b' ->
            case n of
              I# n' ->
                case positive' a' b' n' of
                  m -> let box :: Int
                           box = I# m
                       in box

negative :: Int -> Int -> Int -> Int
negative =
  \ a b n ->
    case a of
      I# a' ->
        case b of
          I# b' ->
            case n of
              I# n' ->
                case negative' a' b' n' of
                  m -> let box :: Int
                           box = I# m
                       in box

fib a b n | n >= 0    = positive a b n
          | otherwise = negative a b n

fibs a b = [ positive a b n | n <- [0..] ]
