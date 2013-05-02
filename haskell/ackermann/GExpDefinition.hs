-- Miguel Ramos, 2013.

module GExpDefinition (gexp) where

gexp :: Integer -> Integer -> Integer -> Integer
gexp 0 x y = y + x
gexp 1 x y = y * x
gexp 2 x y = y ^ x
gexp z 0 y = 1
gexp z x y = let x' = gexp z (pred x) y
             in gexp (pred z) x' y
