-- Miguel Ramos, 2014.
-- From O'Neil, "The Genuine Sieve of Eratosthenes", page 11.

import System.Environment (getArgs)

primes = 2 : ([3..] `minus` composites)
  where
    composites = union [ multiples p | p <- primes ]

multiples n = map (n*) [n..]

(x:xs) `minus` (y:ys) | x < y  = x : (xs `minus` (y:ys))
                      | x == y = xs `minus` ys
                      | x > y  = (x:xs) `minus` ys

union = foldr merge []
  where
    merge (x:xs) ys = x : merge' xs ys
    merge' (x:xs) (y:ys) | x < y  = x : merge' xs (y:ys)
                         | x == y = x : merge' xs ys
                         | x > y  = y : merge' (x:xs) ys

main = do
  args <- getArgs
  case args of
    [ "nth", arg1 ]
        | n <- read arg1 -> print $ primes !! n
    [ "take", arg1 ]
        | n <- read arg1 -> print $ take n primes
    [ "take", arg1, arg2 ]
        | d <- read arg1, n <- read arg2 -> print $ take n $ drop d primes
