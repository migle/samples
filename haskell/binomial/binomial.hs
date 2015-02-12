-- Miguel Ramos, 2015.

module Main (main) where

import System.Environment (getArgs)

pascal n 0 = 1
pascal 0 k = 0
pascal n k = let m = n - 1
                 j = k - 1
             in pascal m j + pascal m k

fact 0 = 1
fact n = n * fact (n - 1)

factorial n k = fact n `div` (fact k * fact (n - k))

binomial n 0 = 1
binomial 0 k = 0
binomial n k = binomial (n - 1) (k - 1) * n `div` k

main = do
  args <- getArgs
  case args of
    [ "pascal", arg1, arg2 ] | n <- read arg1, k <- read arg2 ->
      putStrLn $ show $ pascal n k
    [ "factorial", arg1, arg2 ] | n <- read arg1, k <- read arg2 ->
      putStrLn $ show $ factorial n k
    [ "binomial", arg1, arg2 ] | n <- read arg1, k <- read arg2 ->
      putStrLn $ show $ binomial n k
