-- Miguel Ramos, 2013.

module Level1 where

import Data.Array.IArray
import Level0

azipWith z a b =
  case bounds a of
    (l,u) ->
      case bounds w == (l,u) of
        True ->
          let is = [ 0 .. rangeSize (l,u) - 1 ]
              as = elems a
              bs = elems b
          in unsafeArray (l,u) (zipWith3 (\ i a b -> (i, z a b))  is as bs)

instance Num s => Num (IArray a s) where
  (+) = azipWith (+)
  (-) = azipWith (-)
  (*) = azipWith (*) -- kinda weird, but ok
  negate = amap negate
  abs = amap abs
  signum = amap signum
  fromInteger i = array (1,1) [ (1, fromInteger i) ] -- very weird

instance VectorSpace (IArray a s) s where
  scal a = amap (* a)
  axpy a = azipWith ((+) . (*) a)

instance InnerProductSpace (IArray a s) s where
  dot v w = let vs = elems v
                ws = elems w
            in sum . zipWith (*) vs ws

asum = sum . map abs . elems
nrm1 = asum

nrm2 = norm

amax = maximum . map abs . elems
nrmInf xs = amax xs
