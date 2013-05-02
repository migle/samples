-- Miguel Ramos, 2013.

module AckCPS (ack, ackFast) where

ack :: Integer -> Integer -> Integer
ack x y = cpsAck id x y
          where
	    cpsAck k 0 y = k (succ y)
	    cpsAck k x 0 = cpsAck k (pred x) 1
	    cpsAck k x y = cpsAck (cpsAck k (pred x)) x (pred y)

ackFast :: Integer -> Integer -> Integer
ackFast x y = cpsAck id x y
              where
	        cpsAck k 0 y = k (succ y)
	        cpsAck k 1 y = k (y + 2)
	        cpsAck k 2 y = k (2 * y + 3)
	        cpsAck k 3 y = k (2 ^ (y + 3) - 3)
	        cpsAck k x 0 = cpsAck k (pred x) 1
	        cpsAck k x y = cpsAck (cpsAck k (pred x)) x (pred y)
