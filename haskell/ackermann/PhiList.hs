-- Miguel Ramos, 2013.

module PhiList (phi, phiFast) where

import Data.List

g :: Integer -> Integer -> Integer -> Integer
g 0 m n = m + n
g 1 m 0 = 0
g p m 0 = 1
g p m n = foldr1 (g (pred p)) (genericReplicate n m)

phi :: Integer -> Integer -> Integer -> Integer
phi m n p = g p m n

h :: Integer -> Integer -> Integer -> Integer
h 0 m n = m + n
h 1 m n = m * n
h 2 m n = m ^ n
h p m 0 = 1
h p m n = foldr1 (h (pred p)) (genericReplicate n m)

phiFast :: Integer -> Integer -> Integer -> Integer
phiFast m n p = h p m n
