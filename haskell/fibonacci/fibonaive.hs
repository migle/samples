-- Miguel Ramos, 2013.

module Main( main ) where

import System.Environment ( getArgs )

main = do
    args <- getArgs
    putStrLn $ show $ fib $ read $ head args

fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs = [ fib n | n <- [0..] ]
