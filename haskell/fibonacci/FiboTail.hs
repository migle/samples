-- Miguel Ramos, 2013-2014.

module FiboTail (fib) where

advance 0 a b = a
advance n a b = advance (n - 1) b $! (a + b)

retreat 0 b a = a
retreat n b a = retreat (n + 1) a $! (b - a)

fib n = if n > 0 then
            advance n 0 1
        else
            retreat n 1 0
