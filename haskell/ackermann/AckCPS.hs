-- Miguel Ramos, 2013.

module AckCPS (ack) where

ack x y = cpsAck id x y
          where
	    cpsAck k 0 y = k (succ y)
	    cpsAck k x 0 = cpsAck k (pred x) 1
	    cpsAck k x y = cpsAck (cpsAck k (pred x)) x (pred y)
