-- Miguel Ramos, 2013.

module AckNaive (ack) where

ack :: Integer -> Integer -> Integer
ack 0 y = succ y
ack x 0 = ack (pred x) 1
ack x y = ack (pred x) (ack x (pred y))
