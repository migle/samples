-- Miguel Ramos, 2013.

module FiboNaive (fib) where

fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)