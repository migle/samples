-- Miguel Ramos, 2014.

import System.Environment (getArgs)

pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

nPairs = length . pairs
sumPairs = sum . map (\ (a, b) -> a + b) . pairs

main = do
  args <- getArgs
  case args of
    [ "n", arg ]
        | n <- read arg -> print $ nPairs n
    [ "sum", arg ]
        | n <- read arg -> print $ sumPairs n
