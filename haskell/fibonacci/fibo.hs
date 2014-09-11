-- Miguel Ramos, 2013.

module Main (main) where

import qualified FiboNaive as N (fib)
import qualified FiboTail as T (fib)
import qualified FiboList as L (fib, fibs)
import qualified FiboPair as P (fib)

import System.Environment (getArgs)

fibs fib = [ fib n | n <- [0..] ]

main = do
  args <- getArgs
  case args of
    [ "naive", arg ] | n <- read arg ->
      putStrLn $ show $ N.fib n
    [ "naive", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ fibs N.fib
    [ "tail", arg ] | n <- read arg ->
      putStrLn $ show $ T.fib n
    [ "tail", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ fibs T.fib
    [ "list", arg ] | n <- read arg ->
      putStrLn $ show $ L.fib n
    [ "list", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ L.fibs
    [ "pair", arg ] | n <- read arg ->
      putStrLn $ show $ P.fib n
    [ "pair", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ fibs P.fib
