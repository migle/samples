-- Miguel Ramos, 2013.

module GExpSComposition (gexp) where

c f 0 k = k
c f n k | odd n = c f (pred n) (f . k)
c f n k | even n = c (f . f) (quot n 2) k

g :: Integer -> Integer -> Integer -> Integer
g 0 a n = a + n
g 1 a n = a * n
g 2 a n = a ^ n
g m a 0 = 1
g m a n = let g = gexp (pred m) a
          in c g (pred n) id a

gexp :: Integer -> Integer -> Integer -> Integer
gexp m n a = g m a n
