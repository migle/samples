-- Miguel Ramos, 2013-2014.

module FiboST (fib) where

import Control.Monad
import Control.Monad.ST
import Data.STRef

forward (a,b) = (b,a+b)
backward (a,b) = (b-a,a)
moveST n p | n > 0     = do
                            modifySTRef p $! forward
                            moveST (n - 1) p
           | n < 0     = do
                            modifySTRef p $! backward
                            moveST (n + 1) p
           | otherwise = readSTRef p

fib = fib3

fib1 n = fst $ runST $
  do
    cursor <- newSTRef (0,1)
    moveST n cursor

fib2 n = fst $ runST $
  do
    cursor <- newSTRef (0,1)
    forM_ [n,(n-1)..1] $ \_ -> modifySTRef cursor forward
    forM_ [n,(n+1)..(-1)] $ \_ -> modifySTRef cursor backward
    readSTRef cursor

fib3 n = runST $
            do
                a <- newSTRef 0
                b <- newSTRef 1
                fibST n a b
         where fibST 0 a _ = readSTRef a
               fibST n a b = do
                    a' <- readSTRef a
                    b' <- readSTRef b
                    writeSTRef a b'
                    writeSTRef b $! a'+b'
                    fibST (n - 1) a b
