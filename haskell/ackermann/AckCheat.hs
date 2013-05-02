-- Miguel Ramos, 2013.

module AckCheat (ack) where

ack :: Integer -> Integer -> Integer
ack 0 y = succ y
ack 1 y = y + 2
ack 2 y = 2 * y + 3
ack 3 y = 2 ^ (y + 3) - 3
ack x 0 = ack (pred x) 1
ack x y = ack (pred x) (ack x (pred y))
