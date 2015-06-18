-- Miguel Ramos, 2013-2015.

module FiboList (fib, fibs, fib', fibs') where

positive a b = let xs = positive a b
               in a : b : zipWith (+) xs (tail xs)
negative a b = let xs = negative a b
               in b : a : zipWith (-) xs (tail xs)

fibs = positive
fib a b n = if n >= 0 then
               positive a b !! n
            else
               negative a b !! (1 - n)

positive' a b = a `seq` b `seq` a : b : do
  let xs = positive' a b
  n <- zipWith (+) xs (tail xs)
  return $! n
  
negative' a b = a `seq` b `seq` b : a : do
  let xs = negative' a b
  n <- zipWith (-) xs (tail xs)
  return $! n

fibs' = positive'
fib' a b n = if n >= 0 then
                nth' (positive' a b) n
             else
                nth' (negative' a b) (1 - n)

nth' (x:_)  0 = x
nth' (x:xs) n = x `seq` nth' xs (n - 1)
