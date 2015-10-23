-- Miguel Ramos, 2015.

module Main (main) where

import System.Environment (getArgs)

{-# NOINLINE f #-}
f :: Int -> Int
f 0 = 1
f n = let m = n - 2
      in n * f m

main = do
  args <- getArgs
  case args of
    [ "f", arg ]  | n <- read arg -> print $ f n
