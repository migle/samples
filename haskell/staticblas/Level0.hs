-- Miguel Ramos, 2013.
{-# LANGUAGE DataKinds, KindSignatures, FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, UndecidableInstances #-}

module Level0 where

import GHC.TypeLits

-- There is a CoordinateSpace involving types v, n and s when (v n s) is a type for n-tuples of
-- elements each, called a coordinate, of type s, the scalar field, with n being a natural number
-- type. In this case, the vector type constructor v has kind Nat -> * -> k, where k is the kind of
-- the scalar type s.
-- For a CoordinateSpace, operations dim, operator (!) and coordinate are available for obtaining
-- the dimension of the vector space and the i'th coordinate of a vector.
class SingI n => CoordinateSpace v n s | v -> n s where
    infixl 9 !
    (!) :: v n s -> Int -> s
    dim :: v (n::Nat) s -> Int
    dim u = fromIntegral (withSing (toValue u))
        where toValue :: v (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    coordinate :: v n s -> Int -> s
    coordinate u i | i >= 0 && i < n = u!i
                   | otherwise       = error "coordinate: out of bounds"
        where n = dim u

-- Given a CoordinateSpace v n s, if type s is equality comparable, then type (v n s) is also
-- equality comparable. Two vectors of type (v n s) are equal if all coordinates are equal.
instance (CoordinateSpace v n s, Eq s) => Eq (v n s) where
    u == v = allEqual 0
        where n = dim u
              allEqual i | i < n     = (u!i == v!i) && allEqual (succ i)
                         | otherwise = True

-- Given a CoordinateSpace v n s, if type s is an instance of Show, then type (v n s) is also an
-- instance of Show. Default method is to display all coordinates.
instance (CoordinateSpace v n s, Show s) => Show (v n s) where
    show u = '(' : showInit 0
        where n = dim u
              step i = show (u!i) ++ showLoop (succ i)
              showInit i | i < n     = step i
                         | otherwise = ")"
              showLoop i | i < n     = ' ' : step i
                         | otherwise = ")"

-- There is a VectorSpace involving types v and s, if both (v s), the vector type and s, the scalar
-- type, are instances of Num and scalar multiplication is defined over (v s) and s.
class (Num s, Num (v s)) => VectorSpace v s | v -> s where
    scal :: s -> v s -> v s
    axpy :: s -> v s -> v s -> v s

-- VectorSpace v s is additionally an InnerProductSpace if an inner product is defined over (v s),
-- if s is an instance of Floating (with sqrt defined) and an associated norm is defined.
class (VectorSpace v s, Floating s) => InnerProductSpace v s where
    dot :: v s -> v s -> s
    norm :: v s -> s
    norm u = sqrt (dot u u)

-- The concept of a Matrix involves four types, t, m, n and s. m and n are natural number types
-- specifying the number of rows and columns of the matrix. s is the scalar type and (t m n s) is
-- the matrix type. The matrix type constructor t has kind Nat -> Nat -> * -> k where k is the kind
-- of the scalar type s.
class (SingI m, SingI n) => Matrix t m n s | t -> m n s where
    rows :: t (m::Nat) (n::Nat) s -> Int
    rows a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing m -> Integer
              toValue _ m = fromSing m
    columns :: t (m::Nat) (n::Nat) s -> Int
    columns a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    infixl 9 !!!
    (!!!) :: t m n s -> (Int, Int) -> s
    entry :: t m n s -> Int -> Int -> s
    entry a i j | i >= 0 && i < m && j >= 0 && j < n = a!!!(i,j)
                | otherwise                          = error "entry: out of bounds"
        where m = rows a
              n = columns a
    transpose :: t m n s -> t n m s
    --row :: t m n s -> Int -> t 1 n s
    --column :: t m n s -> Int -> t m 1 s
    --rowVector :: CoordinateSpace v n s => t m n s -> Int -> v n s
    --columnVector :: CoordinateSpace v m s => t m n s -> Int -> v m s

-- Given a Matrix t m n s, if type s is equality comparable, then type (t m n s) is also equality
-- comparable. Two matrices of type (t m n s) are equal if all entries are equal.
instance (Matrix t m n s, Eq s) => Eq (t m n s) where
    a == b = allEqual 0 0
        where m = rows a
              n = columns a
              allEqual i j | i < m && j < n = (a!!!(i,j) == b!!!(i,j)) && allEqual i (succ j)
                           | i < m          = allEqual (succ i) 0
                           | otherwise      = True

-- Given a Matrix t m n s, if type s is an instance of Show, then type (t m n s) is also an instance
-- of Show. Default method is to display all entries in row-major order.
instance (Matrix t m n s, Show s) => Show (t m n s) where
    show a | m >= 1 && n >= 1 = '[' : showCol 0 0
           | otherwise        = "[]"
        where m = rows a
              n = columns a
              step i j = show (a!!!(i,j)) ++ showCol i (succ j)
              showRow i j | i < m     = ';' : showCol i 0
                          | otherwise = "]"
              showCol i j | j < n     = ' ' : step i j
                          | otherwise = ' ' : showRow (succ i) 0

instance (Matrix t 1 n s) => CoordinateSpace (t 1) n s where
    a ! j = a !!! (1,j)

-- Any CoordinateSpace vector can be seen as a one column Matrix.
--instance (CoordinateSpace v n s) => Matrix

-- One natural concept used to represent a Vector in a functional language is a function. A Vector
-- may be a function which maps a bounded range of the natural numbers to a number field.
newtype FVector (n::Nat) s = FVector (Int -> s)

instance SingI n => CoordinateSpace FVector n s where
    (FVector f) ! i = f i

-- Similarly, a Matrix may be a function of two natural arguments to a number field.
newtype FMatrix (m::Nat) (n::Nat) s = FMatrix (Int -> Int -> s)

instance (SingI m, SingI n, Num s) => Matrix FMatrix m n s where
    (FMatrix f) !!! (i,j) = f i j
    transpose (FMatrix f) = FMatrix g
        where g i j = f j i

