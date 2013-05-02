-- Miguel Ramos, 2013.

module GExpList (gexp) where

import Data.List

gexp :: Integer -> Integer -> Integer -> Integer
gexp 0 n a = a + n
gexp 1 n a = a * n
gexp 2 n a = a ^ n
gexp m 0 a = 1
gexp m n a = let g' = gexp (pred m)
             in foldl1' g' $! (genericReplicate n a)
