-- Miguel Ramos, 2013-2014.

module FiboList (fib, fibs) where

fib n = fibs !! n

-- fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs)]

fibs = 0 : 1 : zipAdd fibs (tail fibs)
       where zipAdd (a:as) (b:bs) = let c = a + b
                                    in seq c $ c : zipAdd as bs
             zipAdd _ _           = []
