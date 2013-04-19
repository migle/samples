-- Miguel Ramos, 2013.

module Main (main) where

import qualified FiboNaive as N (fib)
import qualified FiboTail as T (fib)
import qualified FiboList as L (fib, fibs)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "naive", arg ] | n <- read arg ->
      putStrLn $ show $ N.fib n
    [ "tail", arg ] | n <- read arg ->
      putStrLn $ show $ T.fib n
    [ "list", arg ] | n <- read arg ->
      putStrLn $ show $ L.fib n
