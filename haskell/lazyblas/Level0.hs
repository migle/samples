-- Miguel Ramos, 2013.
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, FlexibleInstances, UndecidableInstances #-}

module Level0 where

-- Types v and s form a CoordinateSpace when (v s) is a type for n-tuples of elements each, called a
-- coordinate, of type s, the scalar field. The vector type constructor v has kind k -> * where k is
-- the kind of the scalar type s.
-- For a CoordinateSpace, operations dim and (!), which return the dimension of the vector space and
-- the n'th coordinate, must be defined.
class CoordinateSpace v s | v -> s where
    dim :: v s -> Int
    (!) :: v s -> Int -> s

-- Given a CoordinateSpace v s, if type s is equality comparable, then type (v s) is also equality
-- comparable. Two vectors of type (v s) are equal if all coordinates are equal.
instance (CoordinateSpace v s, Eq s) => Eq (v s) where
    u == v | m == n    = allEqual u v 0
           | otherwise = error "CoordinateSpace.(==): different dimension"
        where m = dim u
              n = dim v
              allEqual u v i | i < n     = (u!i == v!i) && allEqual u v (succ i)
                             | otherwise = True

-- Given a CoordinateSpace v s, if type s is an instance of Show, then type (v s) is also an
-- instance of Show. Default method is to display all coordinates.
instance (CoordinateSpace v s, Show s) => Show (v s) where
    show u = "(" ++ (showInit u 0)
        where n = dim u
              step u i = show (u!i) ++ showLoop u (succ i)
              showInit u i | i < n     = step u i
                           | otherwise = ")"
              showLoop u i | i < n     = ' ' : step u i
                           | otherwise = ")"

class Matrix t v s | t -> v, v -> s where
    size :: t s -> Int
    rows :: t s -> Int
    cols :: t s -> Int
    row :: Int -> t s -> v s
    col :: Int -> t s -> v s
    entry :: Int -> Int -> t s -> s
    minor :: Int -> Int -> t s -> t s
    trans :: t s -> t s

-- One natural concept used to represent a Vector in a functional language is a function. A Vector
-- may be a function which maps a bounded range of the natural numbers to a number field.
data FVector s = FVector Int (Int -> s)

instance CoordinateSpace FVector s where
    dim (FVector n _) = n
    (FVector n f) ! i | i >= 0 && i < n = f i
                      | otherwise       = error "FVector.(!): out of bounds"

-- Similarly, a Matrix may be a function of two natural arguments to a number field.
data FMatrix s = FMatrix Int Int (Int -> Int -> s)

instance Matrix FMatrix FVector s where
    size (FMatrix m n _) = m * n
    rows (FMatrix m _ _) = m
    cols (FMatrix _ n _) = n
    row i (FMatrix m n f) | i >= 0 && i < m = FVector n (f i)
                          | otherwise       = error "FMatrix.row: out of bounds"
    col j (FMatrix m n f) | j >= 0 && j < n = FVector m (\ i -> f i j)
                          | otherwise       = error "FMatrix.col: out of bounds"
    entry i j (FMatrix m n f) | i >= 0 && j >= 0 && i < m && j < n = f i j
                              | otherwise                          = error "FMatrix.entry: out of bounds"
    minor i j (FMatrix m n f) | i >= 0 && j >= 0 && i < m && j < n = FMatrix (pred m) (pred n) g
                              | otherwise                          = error "FMatrix.minor: out of bounds"
        where g i' j' = f (if (i' < i) then i' else (succ i')) (if (j' < j) then j' else (succ j'))
    trans (FMatrix m n f) = FMatrix n m g
        where g j i = f i j

-- Another, sometimes more practical way to represent a Vector is as a list of numbers.
--newtype LVector n k = LVector [k]

-- Matrices can also be represented as a list of numbers, with the elements laid out in what is
-- called row-major or column-major order.
--newtype LRowMajor r k = LRowMajor [k]
--newtype LColumnMajor r k = LColumnMajor [k]

