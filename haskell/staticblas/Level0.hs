-- Miguel Ramos, 2013.
{-# LANGUAGE DataKinds, KindSignatures, FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, UndecidableInstances #-}

module Level0 where

import GHC.TypeLits

-- Types v and s form a CoordinateSpace when (v n s) is a type for n-tuples of elements each, called
-- a coordinate, of type -- s, the scalar field. In this case, the vector type constructor v has
-- kind Nat -> * -> k, where k is the kind of the scalar type s.
-- For a CoordinateSpace, operations dim, coord and operator (!) are available for obtaining the
-- dimension of the vector space and the n'th coordinate of a vector.
class CoordinateSpace v s | v -> s where
    dim :: SingI n => v (n::Nat) s -> Int
    dim u = fromIntegral (withSing (toValue u))
        where toValue :: v (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    coord :: Int -> v n s -> s
    (!) :: SingI n => v n s -> Int -> s
    (!) u i | i >= 0 && i < n = coord i u
            | otherwise       = error "(!): out of bounds"
        where n = dim u

-- Given a CoordinateSpace v s, if type s is equality comparable, then type (v n s) is also equality
-- comparable. Two vectors of type (v n s) are equal if all coordinates are equal.
instance (CoordinateSpace v s, Eq s, SingI n) => Eq (v n s) where
    u == v = allEqual u v 0
        where n = dim u
              allEqual u v i | i < n     = (coord i u == coord i v) && allEqual u v (succ i)
                             | otherwise = True

-- Given a CoordinateSpace v s, if type s is an instance of Show, then type (v n s) is also an
-- instance of Show. Default method is to display all coordinates.
instance (CoordinateSpace v s, Show s, SingI n) => Show (v n s) where
    show u = "(" ++ (showInit u 0)
        where n = dim u
              step u i = show (coord i u) ++ showLoop u (succ i)
              showInit u i | i < n     = step u i
                           | otherwise = ")"
              showLoop u i | i < n     = ' ' : step u i
                           | otherwise = ")"

class Matrix t s | t -> s where
    rows :: (SingI m, SingI n) => t (m::Nat) (n::Nat) s -> Int
    rows a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing m -> Integer
              toValue _ m = fromSing m
    columns :: (SingI m, SingI n) => t (m::Nat) (n::Nat) s -> Int
    columns a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    --row :: (SingI m, SingI n, CoordinateSpace v s) => t m n s -> Int -> v n s
    --column :: (SingI m, SingI n, CoordinateSpace v s) => t m n s -> Int -> v m s
    --entry :: (SingI m, SingI n) => t m n s -> Int -> Int -> s
    --entry a i j = (SingI m, SingI n) => t m n s -> Int -> Int -> s

-- Types v and s form a LinearSpace if both s and (v s) are instances of Num and scalar
-- multiplication is defined over s and (v s).
class (Num s, Num (v s)) => LinearSpace v s | v -> s where
    scal :: s -> v s -> v s
    axpy :: s -> v s -> v s -> v s

-- Types v and s form a VectorSpace if an inner product if they define a LinearSpace and if an inner
-- product is defined over (v s) with an associated norm.
class LinearSpace v s => VectorSpace v s where
    dot :: v s -> v s -> s
    norm :: v s -> s

-- One natural concept used to represent a Vector in a functional language is a function. A Vector
-- may be a function which maps a bounded range of the natural numbers to a number field.
newtype FVector (n::Nat) s = FVector (Int -> s)

instance CoordinateSpace FVector s where
    coord i (FVector f) = f i

--newtype FVector n f = FVector (Int -> f)

-- Similarly, a Matrix may be a function of two natural arguments to a number field.
newtype FMatrix r k = FMatrix (Int -> Int -> k)

-- Another, sometimes more practical way to represent a Vector is as a list of numbers.
newtype LVector n k = LVector [k]

-- Matrices can also be represented as a list of numbers, with the elements laid out in what is
-- called row-major or column-major order.
newtype LRowMajor r k = LRowMajor [k]
newtype LColumnMajor r k = LColumnMajor [k]

{-
data GVector n field repr where
    FV :: Int -> (Int -> field) -> GVector Int field (Int -> field)
    LV :: [field] -> GVector Int field [field]

instance Vector FVector where
    (!) (FVector f) i = f i
    vconst x = FVector (\ i -> x)
        | i >= 0 && i < n = 
            

class MatricialProduct lhs rhs res | lhs rhs -> res where


class Vector where

instance 
class (
class Dim i where

class Vector i k where
    (!) :: v -> i -> k

instance Vector (FVector) where
    (!) (FVector f) i = f i
    vconst x = FVector (\ i -> x)

v :: Num a => Int -> a
v i = [1,2,3,4,5,6] 

data Num a => Vector a = Vector 
newtype (Integral i, Num k) => FVector = FVector (i -> k)
newtype (Integral i, Integral j, Num k) => FMatrix = FMatrix (i -> j -> k)

class (Enum i, Num k) => Vector i k 
class Vector
data Vector n a =
class (Eq a, Show a) => AddGroup a where
    plus, minus :: a -> a -> a
    neg         :: a -> a
    scale       :: (Num k) => k -> a -> a
    minus x y = plus x (neg y)

class (AddGroup a m n, Integral m, Integral n) => Matrix a m n where
    transpose   :: a m n -> a n m
    prod        :: a m n -> a n p -> a m p
    toNum       :: Num k => a 1 1 -> k

class Matrix a n 1 => Vector a n where
    dot                     :: Num k => a n -> a n -> k
    norm1, norm2, normInf   :: Num k => a n -> k
    dot u v = toNum (prod (transpose u) v)
-}


