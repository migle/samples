-- Miguel Ramos, 2014.

import System.Environment (getArgs)

primes = 2 : 3 : 5 : 7 : [ n | n <- [11..], isPrime n ]

divisible n (p:ps) = let (q,r) = quotRem n p
                     in if r == 0 then
                           True
                        else
                           if q < p then
                              False
                           else
                              divisible n ps

isPrime n | n <= 1    = False
          | otherwise = not (divisible n primes)

main = do
  args <- getArgs
  case args of
    [ "is", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ isPrime n
    [ "nth", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ primes !! n
    [ "take", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ take n primes
    [ "take", arg1, arg2 ]
        | d <- read arg1, n <- read arg2 -> putStrLn $ show $ take n $ drop d primes
