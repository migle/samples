-- Miguel Ramos, 2013.

module Main (main) where

import qualified GExpDefinition as D (gexp)
import qualified GExpComposition as C (gexp)
import qualified GExpList as L (gexp)
import qualified GExpSComposition as S (gexp)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "correct", arg1, arg2, arg3 ] | z <- read arg1, x <- read arg2, y <- read arg3 ->
      putStrLn $ show $ D.gexp z x y
    [ "composition", arg1, arg2, arg3 ] | z <- read arg1, x <- read arg2, y <- read arg3 ->
      putStrLn $ show $ C.gexp z x y
    [ "list", arg1, arg2, arg3 ] | z <- read arg1, x <- read arg2, y <- read arg3 ->
      putStrLn $ show $ L.gexp z x y
    [ "swapped", arg1, arg2, arg3 ] | z <- read arg1, x <- read arg2, y <- read arg3 ->
      putStrLn $ show $ S.gexp z x y
