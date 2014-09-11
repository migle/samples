-- Miguel Ramos, 2014.

module FiboPair (fib) where

forward (a,b) = let c = a + b in c `seq` (b,c)
backward (a,b) = let c = b - a in c `seq` (c,a)
move n p | n > 0     = move (n - 1) $ forward p
         | n < 0     = move (n + 1) $ backward p
         | otherwise = p

fib n = fst $ move n (0,1)
