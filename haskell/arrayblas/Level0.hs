-- Miguel Ramos, 2015.
{-# LANGUAGE MultiParamTypeClasses #-}

module Level0 where

-- There is a VectorSpace involving types v of kind * -> * and s of kind * if:
--      \li s, the scalar field, is an instance of Num;
--      \li (v s), the vector over field s, is an instance of Num,
--      \li scal and axpy operations (scalar multiplication) is defined over
--      (v s) and s).
class (Num s, Num (v s)) => VectorSpace v s where
    scal :: s -> v s -> v s
    axpy :: s -> v s -> v s -> v s

-- VectorSpace v s is additionally a NormedVectorSpace if:
--      \li norm is defined over (v s).
class VectorSpace v s => NormedVectorSpace v s where
    norm :: v s -> s

-- VectorSpace v s is additionally an InnerProductSpace if:
--      \li dot, an inner product, is defined over (v s).
class VectorSpace v s => InnerProductSpace v s where
    dot :: v s -> v s -> s
