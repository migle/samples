-- Miguel Ramos, 2013.

module PhiComposition (phi, phiFast) where

c :: (Integer -> Integer) -> Integer -> (Integer -> Integer) -> (Integer -> Integer)
c f 0 k = k
c f n k | odd n = c f (pred n) (f . k)
c f n k | even n = c (f . f) (quot n 2) k

g :: Integer -> Integer -> Integer -> Integer
g 0 m n = m + n
g 1 m 0 = 0
g p m 0 = 1
g p m n = let f = g (pred p) m
          in c f (pred n) id m

phi :: Integer -> Integer -> Integer -> Integer
phi m n p = g p m n

h :: Integer -> Integer -> Integer -> Integer
h 0 m n = m + n
h 1 m n = m * n
h 2 m n = m ^ n
h p m 0 = 1
h p m n = let f = h (pred p) m
          in c f (pred n) id m

phiFast :: Integer -> Integer -> Integer -> Integer
phiFast m n p = h p m n
