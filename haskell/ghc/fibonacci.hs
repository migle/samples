-- Miguel Ramos, 2014.

import System.Environment (getArgs)

fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

main = do
  args <- getArgs
  case args of
    [ number ] | n <- read number ->
        putStrLn $ show $ fib n
    otherwise ->
        putStrLn "Use fibonacci <number>"
