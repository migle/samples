-- Miguel Ramos, 2014.

import System.Environment (getArgs)

from n = let r = let n1 = n `seq` (succ n)
                 in from n1
         in n : r

prog = let z = 0
       in from z

len []     = 0
len (x:xs) = 1 + len xs

main = do
  putStrLn $ show $ take 20 prog
