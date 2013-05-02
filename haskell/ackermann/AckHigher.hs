-- Miguel Ramos, 2013.

module AckHigher (ack, ackFast) where

import Data.List

iter :: (Integer -> Integer) -> Integer -> Integer
iter f 0 = f 1
iter f n = f (iter f (pred n))

ack :: Integer -> Integer -> Integer
ack 0 = succ
ack m = iter (ack (pred m))
--ack m = genericIndex $ iterate (ack (pred m)) 1

ackFast :: Integer -> Integer -> Integer
ackFast 0 = succ
ackFast 1 = (+) 2
ackFast 2 = \ y -> 2 * y + 3
ackFast 3 = \ y -> 2 ^ (y + 3) - 3
ackFast m = iter (ackFast (pred m))
--ackFast m = genericIndex $ iterate (ackFast (pred m)) 1
