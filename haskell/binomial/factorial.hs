-- Miguel Ramos, 2015.

module Main (main) where

import System.Environment (getArgs)

factorial 0 = 1
factorial n = n * factorial (n - 1)

main = do
  args <- getArgs
  case args of
    [ arg1 ] | n <- read arg1 ->
      putStrLn $ show $ factorial n
