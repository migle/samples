-- Miguel Ramos, 2013.

module Main (main) where

import qualified PhiRecursive as R (phi, phiFast)
import qualified PhiList as L (phi, phiFast)
import qualified PhiComposition as C (phi, phiFast)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "rec", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ R.phi m n p
    [ "rec+", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ R.phiFast m n p
    [ "list", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ L.phi m n p
    [ "list+", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ L.phiFast m n p
    [ "comp", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ C.phi m n p
    [ "comp+", arg1, arg2, arg3 ] | m <- read arg1, n <- read arg2, p <- read arg3 ->
      putStrLn $ show $ C.phiFast m n p
