-- Miguel Ramos, 2014.

module Kleene () where

import qualified Prelude as P

infixl 7  ·
infixl 6  +

class (Eq a, Show a) => KleeneAlgebra a where
    (+), choice, (·), sequence :: a -> a -> a
    (*), iteration :: a -> a
    a + b = choice a b
    a · b = sequence a b
    (*) a = iteration a

rpath delta 0 i j = delta i j
rpath delta k i j = let p = pred k
                        a = rpath delta p i p
                        b = rpath delta p p p
                        c = rpath delta p p j
                    in (a · b · c) + (rpath delta p i j)

path delta n i j | i < n && j < n = rpath delta n i k
                 | otherwise      = error "path: Too many"

