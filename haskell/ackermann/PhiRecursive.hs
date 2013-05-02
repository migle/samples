-- Miguel Ramos, 2013.

module PhiRecursive (phi, phiFast) where

phi :: Integer -> Integer -> Integer -> Integer
phi m n 0 = m + n
phi m 0 1 = 0
phi m 0 p = 1
phi m n p = let n' = phi m (pred n) p
            in phi m n' (pred p)

phiFast :: Integer -> Integer -> Integer -> Integer
phiFast m n 0 = m + n
phiFast m n 1 = m * n
phiFast m n 2 = m ^ n
phiFast m 0 p = 1
phiFast m n p = let n' = phiFast m (pred n) p
                in phiFast m n' (pred p)
