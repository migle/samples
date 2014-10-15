-- Miguel Ramos, 2014.

import System.Environment (getArgs)

primes = sieve [ 2 .. ]
sieve (p:xs) = p : sieve [ x | x <- xs, x `mod` p /= 0 ]

main = do
  args <- getArgs
  case args of
    [ "nth", arg1 ]
        | n <- read arg1 -> print $ primes !! n
    [ "take", arg1 ]
        | n <- read arg1 -> print $ take n primes
    [ "take", arg1, arg2 ]
        | d <- read arg1, n <- read arg2 -> print $ take n $ drop d primes
    [ "upto", arg1 ]
        | n <- read arg1 -> print $ sieve [ 2 .. n ]
