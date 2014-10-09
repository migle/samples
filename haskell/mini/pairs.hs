-- Miguel Ramos, 2014.

import System.Environment (getArgs)

pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

add (a, b) = a + b

nPairs n = length $ pairs n
sumPairs n = sum $ map add (pairs n)

main = do
  args <- getArgs
  case args of
    [ "n", arg ]
        | n <- read arg -> print $ nPairs n
    [ "sum", arg ]
        | n <- read arg -> print $ sumPairs n
