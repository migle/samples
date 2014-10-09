-- Miguel Ramos, 2014.

import System.Environment (getArgs)

sieve 2 = []
sieve n = let sqr_primes = sieve (ceiling (sqrt (fromInteger n)))
              sieves = [ [2*p, 3*p .. n] | p <- sqr_primes ]
              flat_sieves = concat sieves
              result = [ i | i <- [0..n], i `notElem` flat_sieves ]
          in drop 2 result

isPrime n | n <= 1    = False
          | otherwise = n `elem` sieve n

main = do
  args <- getArgs
  case args of
    [ "is", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ isPrime n
    [ "upto", arg1 ]
        | n <- read arg1 -> putStrLn $ show $ sieve n
