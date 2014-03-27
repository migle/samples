-- Miguel Ramos, 2013-2014.

module FiboList (fib, fibs) where

fib n = nth fibs n
        where nth (x:_)  0 = x
              nth (x:xs) n = x `seq` nth xs (n - 1)

-- fib n = fibs !! n

fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]
