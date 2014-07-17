-- Miguel Ramos, 2014.

import System.Environment (getArgs)

payment :: Integer -> Float -> Integer -> Integer
payment p i n = (floor (i * (fromInteger p * (1 + i)^n) / ((1 + i)^n - 1)))::Integer

principal :: Integer -> Float -> Integer -> Integer -> Integer
principal p i n j | j >= 1 && j <= n = let x = payment p i n
                                       in floor ((fromInteger x - i * fromInteger p) * (1 + i)^(j - 1))
interest :: Integer -> Float -> Integer -> Integer -> Integer
interest p i n j | j >= 1 && j <= n = let x = payment p i n
                                      in x - principal p i n j

accumulatedPrincipal :: Integer -> Float -> Integer -> Integer -> Integer
accumulatedPrincipal p i n j = sum [ principal p i n k | k <- [1 .. j] ]
accumulatedInterest :: Integer -> Float -> Integer -> Integer -> Integer
accumulatedInterest p i n j = sum [ interest p i n k | k <- [1 .. j] ]

balance :: Integer -> Float -> Integer -> Integer -> Integer
balance p i n j = p - accumulatedPrincipal p i n j

totalPrincipal :: Integer -> Float -> Integer -> Integer
totalPrincipal p i n = accumulatedPrincipal p i n n
totalInterest :: Integer -> Float -> Integer -> Integer
totalInterest p i n = accumulatedInterest p i n n

table p i n = let partP j = principal p i n j
                  partI j = interest p i n j
                  accP j = accumulatedPrincipal p i n j
                  accI j = accumulatedInterest p i n j
                  bal j = balance p i n j
              in [ ( j, (partP j), (partI j), (accP j), (accI j), (bal j) ) | j <- [1 .. n] ]

toMonthly :: Float -> Float
toMonthly i = (1 + i)**(1 / 12) - 1

main = do
  args <- getArgs
  case args of
    [ "payment", arg1, arg2, arg3 ]
        | p <- read arg1, i <- read arg2, n <- read arg3 ->
      putStrLn $ show $ payment p (toMonthly (i/100)) n
    [ "principal", arg1, arg2, arg3 ]
        | p <- read arg1, i <- read arg2, n <- read arg3 ->
      putStrLn $ show $ totalPrincipal p (toMonthly (i/100)) n
    [ "interest", arg1, arg2, arg3 ]
        | p <- read arg1, i <- read arg2, n <- read arg3 ->
      putStrLn $ show $ totalInterest p (toMonthly (i/100)) n
    [ "table", arg1, arg2, arg3 ]
        | p <- read arg1, i <- read arg2, n <- read arg3 ->
      putStrLn $ show $ table p (toMonthly (i/100)) n
