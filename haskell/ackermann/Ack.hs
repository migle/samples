-- Miguel Ramos, 2013.

module Main (main) where

import qualified AckNaive as N (ack)
import qualified AckExp as E (ack)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "naive", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ N.ack x y
    [ "exp", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ E.ack x y
