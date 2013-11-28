-- Miguel Ramos, 2013.
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}
{-# LANGUAGE FlexibleInstances, OverlappingInstances, UndecidableInstances #-}

module Level0 where

-- The integer type we use for indices.
type Index = Int

-- Types v and s form a CoordinateSpace when (v s) is a type for n-tuples of elements each, called a
-- coordinate, of type s, the scalar field. The vector type constructor v has kind * -> k where k is
-- the kind of the scalar type s.
-- For a CoordinateSpace, operations dim and (!), which return the dimension of the vector space and
-- the i'th coordinate, must be defined.
class CoordinateSpace v s | v -> s where
    infixl 9 !
    (!) :: v s -> Index -> s
    dim :: v s -> Index

{-
-- Given a CoordinateSpace v s, if type s is equality comparable, then type (v s) is also equality
-- comparable. Two vectors of type (v s) are equal if all coordinates are equal.
instance (CoordinateSpace v s, Eq s) => Eq (v s) where
    u == v | m == n    = equalFrom 0
           | otherwise = error "CoordinateSpace.(==): different dimension"
        where m = dim u
              n = dim v
              equalFrom i | i < n     = (u!i == v!i) && equalFrom (succ i)
                          | otherwise = True

-- Given a CoordinateSpace v s, if type s is an instance of Show, then type (v s) is also an
-- instance of Show. Default method is to display all coordinates.
instance (CoordinateSpace v s, Show s) => Show (v s) where
    show u | n >= 1    = '(' : showFrom 0
           | otherwise = "()"
        where n = dim u
              showFrom i = show (u!i) ++ showNext (succ i)
              showNext i | i < n     = ' ' : showFrom i
                         | otherwise = ")"
-}

-- There is a VectorSpace involving types v and s, if both (v s), the vector type and s, the scalar
-- type, are instances of Num and scalar multiplication is defined over (v s) and s.
class (Num s, Num (v s)) => VectorSpace v s | v -> s where
    scal :: s -> v s -> v s
    axpy :: s -> v s -> v s -> v s

-- VectorSpace v s is additionally an InnerProductSpace if an inner product is defined over (v s),
-- if s is an instance of Floating (with sqrt defined) and an associated norm is defined.
class (VectorSpace v s, Floating s) => InnerProductSpace v s | v -> s where
    dot :: v s -> v s -> s
    norm :: v s -> s
    norm u = sqrt (dot u u)

-- Type (t s) is a Matrix over s
class Matrix t s | t -> s where
    rows :: t s -> Index
    cols :: t s -> Index
    entry :: t s -> Index -> Index -> s
    row :: CoordinateSpace v s => t s -> Index -> v s
    col :: CoordinateSpace v s => t s -> Index -> v s
    --transpose :: t s -> x

-- Given a Matrix t s, if type s is equality comparable, then type (t s) is also equality
-- comparable. Two matrices of type (t s) are equal iff all entries are equal.
instance (Matrix t s, Eq s) => Eq (t s) where
    a == b | m == m' && n == n' = equalFrom 0 0
           | otherwise          = error "Matrix.(==): different dimension"
        where m = rows a
              n = cols a
              m' = rows b
              n' = cols b
              equalFrom i j | j < n     = (entry a i j == entry b i j) && equalFrom i (succ j)
                            | i < m     = equalFrom (succ i) 0
                            | otherwise = True

-- Given a Matrix t s, if type s is an instance of Show, then type (t s) is also an instance of
-- Show. Default method is to display all entries in row-major order.
instance (Matrix t s, Show s) => Show (t s) where
    show a | m >= 1 && n >= 1 = '[' : nextCol 0 0
           | otherwise        = "[]"
        where m = rows a
              n = cols a
              showEntry i j = show (entry a i j) ++ nextCol i (succ j)
              nextCol i j | j < n     = ' ' : showEntry i j
                          | otherwise = ' ' : nextRow (succ i) j
              nextRow i j | i < m     = ';' : nextCol i 0
                          | otherwise = "]"

-- One natural concept used to represent a Vector in a functional language is a function. A Vector
-- may be a function which maps a bounded range of the natural numbers to a number field.
data FVector s = FVector Index (Index -> s)

instance CoordinateSpace FVector s where
    dim (FVector n _) = n
    (FVector n f) ! i | i >= 0 && i < n = f i
                      | otherwise       = error "FVector.(!): out of bounds"

instance Num s => Num (FVector s) where
    (FVector m f) + (FVector n g) | m == n    = FVector m (\ i -> f i + g i)
                                  | otherwise = error "FVector.(+): different dimension"
    (FVector m f) - (FVector n g) | m == n    = FVector m (\ i -> f i - g i)
                                  | otherwise = error "FVector.(-): different dimension"
    (FVector m f) * (FVector n g) | m == n    = FVector m (\ i -> f i * g i)
                                  | otherwise = error "FVector.(*): different dimension"
    negate (FVector m f) = FVector m (\ i -> negate $ f i)
    abs (FVector m f) = FVector m (\ i -> abs $ f i)
    signum (FVector m f) = FVector m (\ i -> signum $ f i)
    fromInteger n = FVector 1 (\ i -> fromInteger n)

instance Num s => VectorSpace FVector s where
    scal a (FVector m f) = FVector m (\ i -> a * f i)
    axpy a (FVector m f) (FVector n g) | m == n    = FVector m (\ i -> a * f i + g i)
                                       | otherwise = error "FVector.axpy: different dimension"

-- Similarly, a Matrix may be a function of two natural arguments to a number field.
data FMatrix s = FMatrix Index Index (Index -> Index -> s)

instance Matrix FMatrix s where
    rows (FMatrix m _ _) = m
    cols (FMatrix _ n _) = n
    row (FMatrix m n f) i | i >= 0 && i < m = FVector n (f i)
                          | otherwise       = error "FMatrix.row: out of bounds"
    col (FMatrix m n f) j | j >= 0 && j < n = FVector m (\ i -> f i j)
                          | otherwise       = error "FMatrix.col: out of bounds"
    entry (FMatrix m n f) i j | i >= 0 && i < m && j >= 0 && j < n = f i j
                              | otherwise                          = error "FMatrix.entry: out of bounds"
    --minor i j (FMatrix m n f) | i >= 0 && j >= 0 && i < m && j < n = FMatrix (pred m) (pred n) g
    --                          | otherwise                          = error "FMatrix.minor: out of bounds"
    --    where g i' j' = f (if (i' < i) then i' else (succ i')) (if (j' < j) then j' else (succ j'))
    --transpose (FMatrix m n f) = FMatrix n m g where g i j = f j i

-- Another, sometimes more practical way to represent a Vector is as a list of numbers.
--newtype LVector n k = LVector [k]

-- Matrices can also be represented as a list of numbers, with the elements laid out in what is
-- called row-major or column-major order.
--newtype LRowMajor r k = LRowMajor [k]
--newtype LColumnMajor r k = LColumnMajor [k]

