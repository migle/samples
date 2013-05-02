-- Miguel Ramos, 2013.

module GExpComposition (gexp) where

c f 0 = id
c f n | odd n = f . (c f (pred n))
c f n | even n = let g = c f (quot n 2) in g . g

gexp :: Integer -> Integer -> Integer -> Integer
gexp 0 n a = a + n
gexp 1 n a = a * n
gexp 2 n a = a ^ n
gexp m 0 a = 1
gexp m n a = let g = \ x -> gexp (pred m) x a
             in c g (pred n) a
