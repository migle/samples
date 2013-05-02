-- Miguel Ramos, 2013.

module AckPhi (ack) where

ack :: (Integer -> Integer -> Integer -> Integer ) -> Integer -> Integer -> Integer
ack phi 0 n = n + 1
ack phi m n = (phi 2 (n + 3) (m - 1)) - 3
