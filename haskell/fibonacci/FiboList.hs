-- Miguel Ramos, 2013.

module FiboList (fib, fibs) where

fib n = fibs !! n

fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]
