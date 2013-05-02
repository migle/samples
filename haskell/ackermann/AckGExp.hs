-- Miguel Ramos, 2013.

module AckGExp (ack) where

ack :: (Integer -> Integer -> Integer -> Integer ) -> Integer -> Integer -> Integer
ack g 0 y = y + 1
ack g x y = (g (x - 1) (y + 3) 2) - 3
