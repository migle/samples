-- Miguel Ramos, 2013-2014.
{-# LANGUAGE ParallelListComp #-}

module FiboList (fib, fibs) where

fib n = fibs !! n

-- fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs) ]
-- fibs = 0 : 1 : [ a + b | a <- fibs | b <- tail fibs ]
-- fibs = 0 : 1 : do
--     (a, b) <- zip fibs (tail fibs)
--     return $! a + b
-- fibs = 0 : 1 : [ n | n <- zipWith (+) fibs (tail fibs) ]
-- fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
fibs = 0 : 1 : do
    n <- zipWith (+) fibs (tail fibs)
    return $! n

-- fibs = 0 : 1 : zipAdd fibs (tail fibs)
--     where zipAdd (a:as) (b:bs) = let c = a + b
--                                  in c `seq` c : zipAdd as bs
--           zipAdd _ _           = []
