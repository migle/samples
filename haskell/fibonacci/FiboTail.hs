-- Miguel Ramos, 2013.

module FiboTail (fib) where

fib n = gfib n 0 1
	where
		gfib 0 a b = a
		gfib n a b = gfib (n - 1) b (a + b)
