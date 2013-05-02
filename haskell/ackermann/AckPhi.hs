-- Miguel Ramos, 2013.

module AckPhi (ack) where

ack :: (Integer -> Integer -> Integer -> Integer ) -> Integer -> Integer -> Integer
ack phi 0 y = y + 1
ack phi x y = (phi (x - 1) (y + 3) 2) - 3
