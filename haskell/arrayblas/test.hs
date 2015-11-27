-- Miguel Ramos, 2015.

module Main (main) where

import Data.Array.IArray
import Data.Array.Unboxed
import Level0
import Level1

type Vector = UArray Int Double

zero :: Int -> Vector
zero n = array (1,n) [ (i,0) | i <- [1..n] ]

ones :: Int -> Vector
ones n = array (1,n) [ (i,1) | i <- [1..n] ]

e :: Int -> Int -> Vector
e k n = array (1,n) [ (i, if i == k then 1 else 0) | i <- [1..n] ]

canon :: Int -> Vector
canon n = array (1,n) [ (i, fromIntegral i) | i <- [1..n] ]

{-# NOINLINE u #-}
u = let a = canon 64
        b = ones 64
    in a + b

main = do
  print u
