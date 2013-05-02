-- Miguel Ramos, 2013.

module AckRecursive (ack, ackFast) where

ack :: Integer -> Integer -> Integer
ack 0 y = succ y
ack x 0 = ack (pred x) 1
ack x y = ack (pred x) (ack x (pred y))

ackFast :: Integer -> Integer -> Integer
ackFast 0 y = succ y
ackFast 1 y = y + 2
ackFast 2 y = 2 * y + 3
ackFast 3 y = 2 ^ (y + 3) - 3
ackFast x 0 = ackFast (pred x) 1
ackFast x y = ackFast (pred x) (ackFast x (pred y))
