-- Miguel Ramos, 2013.
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
{-# LANGUAGE DataKinds, KindSignatures #-}
--{-# LANGUAGE FlexibleInstances, OverlappingInstances, UndecidableInstances #-}

module Level0 where

import GHC.TypeLits

-- The integer type we use for indices.
type Index = Int

-- There is a CoordinateSpace involving types v, n and s when (v n s) is a type for n-tuples of
-- elements each, called a coordinate, of type s, the scalar field, with n being a natural number
-- type. In this case, the vector type constructor v has kind Nat -> * -> k, where k is the kind of
-- the scalar type s.
class SingI n => CoordinateSpace v n s | v -> n s where
    -- Minimal complete definition: coordinate or (!)
    -- Coordinate i of a vector
    infixl 9 !
    (!), coordinate :: v n s -> Index -> s
    u!i = coordinate u i
    coordinate u i = u!i
    -- Number of coordinates of a vector
    dim :: v (n::Nat) s -> Index
    dim u = fromIntegral (withSing (toValue u))
        where toValue :: v (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    -- Validated coordinate index
    validCoordinate :: v (n::Nat) s -> Index -> Index
    validCoordinate u i | i >= 0 && i < n = i
                        | otherwise       = error "Level0.CoordinateSpace: invalid coordinate"
        where n = dim u
    -- Lexicographical signum
    lexicographicalSignum :: Real s => v (n::Nat) s -> Int
    lexicographicalSignum u = 
        where n = dim u
              compareFrom i | i < n     = if u!i == 0 then compareFrom (succ i) else signum u!i
                            | otherwise = 0
    -- Lexicographical compare
    lexicographicalCompare :: Ord s => v (n::Nat) s -> v (n::Nat) s -> Bool
    lexicographicalCompare u v = compareFrom 0
        where n = dim u
              compareFrom i | i < n     = let c = compare u!i v!i
                                          in if c == EQ then compareFrom (succ i) else c
                            | otherwise = EQ
    --

-- Given a CoordinateSpace v n s, if type s is an instance of Show, then type (v n s) is also an
-- instance of Show. Default method is to display all coordinates.
instance (CoordinateSpace v n s, Show s) => Show (v n s) where
    show u | n >= 1    = '(' : showFrom 0
           | otherwise = "()"
        where n = dim u
              showFrom i = show (u!i) ++ showNext (succ i)
              showNext i | i < n     = ' ' : showFrom i
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
    -- Entry i j of a matrix
    entry :: t m n s -> Index -> Index -> s
    -- Number of rows and columns of a matrix
    rows, cols :: t (m::Nat) (n::Nat) s -> Index
    rows a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing m -> Integer
              toValue _ m = fromSing m
    cols a = fromIntegral (withSing (toValue a))
        where toValue :: t (m::Nat) (n::Nat) s -> Sing n -> Integer
              toValue _ n = fromSing n
    -- Validated row and column index
    validRow, validCol :: t (m::Nat) (n::Nat) s -> Index -> Index
    validRow a i | i >= 0 && i < m = i
                 | otherwise       = error "Level0.Matrix: invalid row"
        where m = rows a
    validCol a j | j >= 0 && j < n = j
                 | otherwise       = error "Level0.Matrix: invalid column"
        where n = cols a
    -- The transpose
    trans :: t m n s -> t n m s
    --row :: t m n s -> Index -> t 1 n s
    --column :: t m n s -> Index -> t m 1 s
    --rowVector :: CoordinateSpace v n s => t m n s -> Index -> v n s
    --columnVector :: CoordinateSpace v m s => t m n s -> Index -> v m s

-- Given a Matrix t m n s, if type s is equality comparable, then type (t m n s) is also equality
-- comparable. Two matrices of type (t m n s) are equal if all entries are equal.
instance (Matrix t m n s, Eq s) => Eq (t m n s) where
    a == b = equalFrom 0 0
        where m = rows a
              n = cols a
              equalFrom i j | j < n     = (entry a i j == entry b i j) && equalFrom i (succ j)
                            | i < m     = equalFrom (succ i) 0
                            | otherwise = True

-- Given a Matrix t m n s, if type s is an instance of Show, then type (t m n s) is also an instance
-- of Show. Default method is to display all entries in row-major order.
instance (Matrix t m n s, Show s) => Show (t m n s) where
    show a | m >= 1 && n >= 1 = '[' : showCol 0 0
           | otherwise        = "[]"
        where m = rows a
              n = cols a
              step i j = show (entry a i j) ++ showCol i (succ j)
              showRow i j | i < m     = ';' : showCol i 0
                          | otherwise = "]"
              showCol i j | j < n     = ' ' : step i j
                          | otherwise = ' ' : showRow (succ i) 0

-- One natural concept used to represent a Vector in a functional language is a function. A Vector
-- may be a function which maps a bounded range of the natural numbers to a number field.
newtype FVector (n::Nat) s = FVector (Index -> s)

instance SingI n => CoordinateSpace FVector n s where
    coordinate (FVector f) i = f i

-- Similarly, a Matrix may be a function of two natural arguments to a number field.
newtype FMatrix (m::Nat) (n::Nat) s = FMatrix (Index -> Index -> s)

instance (SingI m, SingI n, Num s) => Matrix FMatrix m n s where
    entry (FMatrix f) i j = f i j
    trans (FMatrix f) = FMatrix g where g i j = f j i

