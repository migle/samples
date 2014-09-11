-- Miguel Ramos, 2013-2014.

module FiboST (fib) where

import Control.Monad
import Control.Monad.ST
import Data.STRef

forward (a,b) = let c = a + b in c `seq` (b,c)
backward (a,b) = let c = b - a in c `seq` (c,a)

fib n = fst $ runST $
  do
    cursor <- newSTRef (0,1)
    if n > 0 then
      advance n cursor
    else
      retreat n cursor
  where
    advance 0 p = readSTRef p 
    advance n p = do
      p' <- readSTRef p
      writeSTRef p $! forward p'
      advance (n - 1) p
    retreat 0 p = readSTRef p
    retreat n p = do
      p' <- readSTRef p
      writeSTRef p $! backward p'
      retreat (n + 1) p 

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
