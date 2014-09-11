-- Miguel Ramos, 2014.

module FiboPair (fib) where

forward (a,b) = let c = a + b in c `seq` (b,c)
backward (a,b) = let c = b - a in c `seq` (c,a)

advance 0 p = p
advance n p = advance (n - 1) $! forward p

retreat 0 p = p
retreat n p = retreat (n + 1) $! backward p

fib n = fst $ if n > 0 then advance n (0,1) else retreat n (0,1)
