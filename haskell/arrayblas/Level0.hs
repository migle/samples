-- Miguel Ramos, 2015.

module Level0 where

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
