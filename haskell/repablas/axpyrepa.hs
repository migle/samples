-- Miguel Ramos, 2013.

import Data.Array.Repa
import Data.Array.Repa.Algorithms.Randomish

import System.Environment (getArgs)
import Prelude hiding(map, zipWith)

main = do
    n <- getArgs >>= (return . read . head)
    let sh = (Z :. n)
        a = 10
        x = randomishDoubleArray sh (-1) 1 0
        y = randomishDoubleArray sh a (-a) 0
	z = daxpy a x y
	z' = computeS z :: Array U DIM1 Double
	t = test z' 0 1e-8
	ok = foldAllS (&&) True t
    putStrLn $ show $ ok

daxpy a x y = zipWith (+) (map (* a) x) y

test x a e = let stest s = s - a < e
             in map stest x
