-- Miguel Ramos, 2013-2015.

module FiboTail (fib, fibs, fib', fibs') where

positive a _ 0 = a
positive _ b 1 = b
positive a b n = positive b (a + b) (n - 1)

negative a _ 0 = a
negative _ b 1 = b
negative a b n = negative (b - a) a (n + 1)

fib a b n = if n >= 0 then
               positive a b n
            else
               negative a b n

fibs a b = [ positive a b n | n <- [0..] ]

positive' a b 0 = seq b a
positive' a b 1 = seq a b
positive' a b n = positive' b (a + b) (n - 1)

negative' a b 0 = seq b a
negative' a b 1 = seq a b
negative' a b n = negative' (b - a) a (n + 1)

fib' a b n = if n >= 0 then
                positive' a b n
             else
                negative' a b n

fibs' a b = [ positive' a b n | n <- [0..] ]
