-- Miguel Ramos, 2013.

module AckNaive (ack) where

ack :: Integer -> Integer -> Integer
ack 0 y = y + 1
ack x 0 = ack (x - 1) 1
ack x y = ack (x - 1) (ack x (y - 1))
