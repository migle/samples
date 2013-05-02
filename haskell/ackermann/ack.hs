-- Miguel Ramos, 2013.

module Main (main) where

import qualified AckRecursive as R (ack, ackFast)
import qualified AckCPS as C (ack, ackFast)
import qualified AckPhi as P (ack)
import qualified AckList as L (ack, ackFast)
import qualified AckHigher as H (ack, ackFast)

import qualified PhiRecursive as PR (phi, phiFast)
import qualified PhiList as PL (phi, phiFast)
import qualified PhiComposition as PC (phi, phiFast)

import System.Environment (getArgs)

main = do
  args <- getArgs
  case args of
    [ "rec", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ R.ack x y
    [ "rec+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ R.ackFast x y

    [ "cps", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ C.ack x y
    [ "cps+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ C.ackFast x y

    [ "phi-rec", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PR.phi x y
    [ "phi-rec+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PR.phiFast x y
    [ "phi-list", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PL.phi x y
    [ "phi-list+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PL.phiFast x y
    [ "phi-comp", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PC.phi x y
    [ "phi-comp+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ P.ack PC.phiFast x y

    [ "list", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ L.ack x y
    [ "list+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ L.ackFast x y

    [ "higher", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ H.ack x y
    [ "higher+", arg1, arg2 ] | x <- read arg1, y <- read arg2 ->
      putStrLn $ show $ H.ackFast x y

