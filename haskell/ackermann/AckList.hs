-- Miguel Ramos, 2013.

module AckList (ack) where

ackermann = iterate ack [1..] where
   ack a = s where
           s = a!!1 : f (tail a) (zipWith (-) s (1:s))
   f a (b:bs) = (head aa) : f aa bs where
           aa = drop b a

ack x y = ackermann !! x !! y
