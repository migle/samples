-- Miguel Ramos, 2013.

module Main( main ) where

import System.Environment ( getArgs )

main = do
    args <- getArgs
    putStrLn $ show $ fib $ read $ head args

fib n = gfib n 0 1
	where
		gfib 0 a b = a
		gfib n a b = gfib (n - 1) b (a + b)

fibs = [ fib n | n <- [0..] ]
