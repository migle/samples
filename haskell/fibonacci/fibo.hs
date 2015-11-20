-- Miguel Ramos, 2013-2015.

module Main (main) where

import qualified FiboNaive as N (fib, fib', fibs, fibs')
import qualified FiboTail as T (fib, fib', fibs, fibs')
import qualified FiboList as L (fib, fib', fibs, fibs')
import qualified FiboSTG as S (fib, fibs)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of

    [ "naive", arg ] | n <- read arg ->
      putStrLn $ show $ N.fib 0 1 n
    [ "naive", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ N.fibs 0 1
    [ "naive+", arg ] | n <- read arg ->
      putStrLn $ show $ N.fib' 0 1 n
    [ "naive+", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ N.fibs' 0 1

    [ "tail", arg ] | n <- read arg ->
      putStrLn $ show $ T.fib 0 1 n
    [ "tail", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ T.fibs 0 1
    [ "tail+", arg ] | n <- read arg ->
      putStrLn $ show $ T.fib' 0 1 n
    [ "tail+", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ T.fibs' 0 1

    [ "list", arg ] | n <- read arg ->
      putStrLn $ show $ L.fib 0 1 n
    [ "list", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ L.fibs 0 1
    [ "list+", arg ] | n <- read arg ->
      putStrLn $ show $ L.fib' 0 1 n
    [ "list+", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ L.fibs' 0 1

    [ "stg", arg ] | n <- read arg ->
      putStrLn $ show $ S.fib 0 1 n
    [ "stg", arg1, arg2 ] | i <- read arg1, f <- read arg2 ->
      putStrLn $ show $ take f $ drop i $ S.fibs 0 1
