-- Miguel Ramos, 2013.

module Main( main ) where

import System.Environment ( getArgs )

main = do
    args <- getArgs
    putStrLn $ show $ fib $ read $ head args

fib n = fibs !! n

fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]
