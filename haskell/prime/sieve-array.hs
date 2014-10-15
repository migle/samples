-- Miguel Ramos, 2014.

import Data.Array.Unboxed
import System.Environment (getArgs)

union a [] = a
union [] b = b

multiples n = do
    k <- [1..]
    return $! n * k

number i = 2 * i + 1
position n = (n - 1) `div` 2

array (3,n) [ (i,True) | i <- [3,5..n] ] :: UArray Int Bool

  let m = position n
      r = 
  do
    sieve <- newArray (1,m) True
    i <- [1..
      isPrime <- readArray sieve i
      when isPrime $ do
        ...

sieve p a

primes n = 
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

sieve 2 = []
sieve n = let sqr_primes = sieve (ceiling (sqrt (fromInteger n)))
              sieves = [ [2*p, 3*p .. n] | p <- sqr_primes ]
              flat_sieves = concat sieves
              result = [ i | i <- [0..n], i `notElem` flat_sieves ]
          in drop 2 result

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
    [ "sieve", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ sieve n
