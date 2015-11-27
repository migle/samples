-- Miguel Ramos, 2015.
{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module Level1 where

import Data.Array.IArray
import Level0

--azipWith :: (IArray a e, IArray a f, IArray a g, Ix i) => (e -> f -> g) -> a i e -> a i f -> a i g
azipWith z a b =
  case bounds a of
    (l,u) ->
      case bounds b == (l,u) of
        True ->
          let as = elems a
              bs = elems b
          in listArray (l,u) (zipWith z as bs)

instance (Num s, Ix i, IArray a s) => Num (a i s) where
  (+) = azipWith (+)
  (-) = azipWith (-)
  (*) = azipWith (*) -- kinda weird, but ok
  negate = amap negate
  abs = amap abs
  signum = amap signum
  fromInteger _ = error "Can't make up an Array from an Integer."

instance (Num s, Ix i, IArray a s) => VectorSpace (a i) s where
  scal a = amap (* a)
  axpy a = azipWith ((+) . (*) a)

instance (Num s, Ix i, IArray a s) => InnerProductSpace (a i) s where
  dot v w = let vs = elems v
                ws = elems w
                ps = zipWith (*) vs ws
            in sum ps

instance (Num s, Ix i, IArray a s) => NormedVectorSpace (a i) s where
  norm = sum . map (^2) . elems

asum :: (Num s, Ix i, IArray a s) => a i s -> s
asum = sum . map abs . elems

nrm1 :: (Num s, Ix i, IArray a s) => a i s -> s
nrm1 = asum

nrm2 :: NormedVectorSpace (a i) s => a i s -> s
nrm2 = norm

amax :: (Num s, Ord s, Ix i, IArray a s) => a i s -> s
amax = maximum . map abs . elems

nrmInf :: (Num s, Ord s, Ix i, IArray a s) => a i s -> s
nrmInf = amax
