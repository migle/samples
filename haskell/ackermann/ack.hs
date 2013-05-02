-- Miguel Ramos, 2013.

module Main (main) where

import qualified AckNaive as N (ack)
import qualified AckCheat as C (ack)
import qualified AckGExp as G (ack)

import qualified GExpDefinition as GD (gexp)
import qualified GExpComposition as GC (gexp)
import qualified GExpList as GL (gexp)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "naive", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ N.ack x y
    [ "cheat", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ C.ack x y
    [ "exp", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ G.ack GD.gexp x y
    [ "exp-composition", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ G.ack GC.gexp x y
    [ "exp-list", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ G.ack GL.gexp x y
