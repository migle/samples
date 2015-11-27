-- Miguel Ramos, 2015.
{-# LANGUAGE MultiParamTypeClasses #-}

module Level0 where

-- There is a VectorSpace involving types v and s, v being the vector type and
-- s the scalar field over which v is defined, if both (v s) and s are
-- instances of Num and scalar multiplication is defined over v and s.
class (Num s, Num (v s)) => VectorSpace v s where
    scal :: s -> v s -> v s
    axpy :: s -> v s -> v s -> v s

-- VectorSpace v s is additionally a NormedVectorSpace if a norm is defined
-- over (v s).
class VectorSpace v s => NormedVectorSpace v s where
    norm :: v s -> s

-- VectorSpace v s is additionally an InnerProductSpace if an inner product is
-- defined over (v s).
class VectorSpace v s => InnerProductSpace v s where
    dot :: v s -> v s -> s
