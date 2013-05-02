-- Miguel Ramos, 2013.

module AckExp (ack) where

g :: Integer -> Integer -> Integer -> Integer
g 0 x y = y + x
g 1 x y = y * x
g 2 x y = y ^ x
g z 0 y = 1
g z x y = g (z - 1) (g z (x - 1) y) y

ack :: Integer -> Integer -> Integer
ack 0 y = y + 1
ack x y = (g (x - 1) (y + 3) 2) - 3
