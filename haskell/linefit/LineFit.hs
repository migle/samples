-- Miguel Ramos, 2013.
--
-- Optimal total least-squares line fit for two-dimensional data.
--
-- This is a total least-squares line fit, as opposed to the usual least-squares approach which
-- is intended as a linear approximation of a _function_.
-- The usual approach measures error vertically (the error in the approximation of the function) and
-- fails miserably as the required fit approaches the vertical.
--
-- For finding the best line fit for two-dimensional data this one is the right approach, which
-- minimizes the error measured as the square of the smallest distance to the line.

module LineFit (lineFit, lineFitTestData, Vector2(Vector2)) where

import Prelude hiding (map, zipWith)

-- Vector2 a is a 2-vector over the numeric type a.
data Vector2 a = Vector2 a a
                 deriving (Eq, Show)

-- Vector indexing.
(!) :: Vector2 a -> Int -> a
(!) (Vector2 u0 u1) 0 = u0
(!) (Vector2 u0 u1) 1 = u1

-- Elementwise operations.
map :: (a -> b) -> Vector2 a -> Vector2 b
map f (Vector2 u0 u1) = Vector2 (f u0) (f u1)

zipWith :: (a -> b -> c) -> Vector2 a -> Vector2 b -> Vector2 c
zipWith f (Vector2 u0 u1) (Vector2 v0 v1) = Vector2 (f u0 v0) (f u1 v1)

reduce :: (a -> a -> b) -> Vector2 a -> b
reduce f (Vector2 u0 u1) = f u0 u1

-- Vector operator precedence.
infixl 7 ., .*, ./
infixl 6 .+, .-

-- Vector operators.
(.+) u v = zipWith (+) u v
(.-) u v = zipWith (-) u v
(.*) k u = map (* k) u
(./) u k = map (/ k) u
(.) u v = reduce (+) $ zipWith (*) u v

-- lineFit takes a list of 2-vectors over numeric type k, computes the equation of the line which
-- has the least sum of the squares of the smallest distance to each point, in the form
-- A x + B y = C.
--
-- The equation of the line thus computed is returned as a tuple (A, B, C). All computations are
-- performed within the numeric type k.
lineFit :: RealFloat a => [ Vector2 a ] -> Maybe (a, a, a)
lineFit vs =
    let m = mean vs
        z = accumulate vs m
        a' = (fst z)
        b' = (snd z)
    in if (a' == 0) && (b' == 0)
       then Nothing
       else let a = 2*b'
                b = -(a' + sqrt(a'^2 + 4*b'^2))
                c = a*m!0 + b*m!1
            in Just (a, b, c)

mean :: RealFloat a => [ Vector2 a ] -> Vector2 a
mean vs = tmean vs (Vector2 0 0) 0
    where tmean [] a n = a ./ (fromIntegral n)
          tmean (v:vs) a n = tmean vs (a .+ v) (succ n)

accumulate :: RealFloat a => [ Vector2 a ] -> Vector2 a -> (a, a)
accumulate vs m = tacc vs m (0, 0)
    where tacc [] m z = z
          tacc (v:vs) m z = let t = v .- m
                                a = t!0^2 - t!1^2
                                b = t!0*t!1
                            in tacc vs m ((fst z) + a, (snd z) + b)

lineFitTestData :: [ Vector2 Float ]
lineFitTestData =
    [
        Vector2 0.237 (-1.000),
        Vector2 0.191 (-0.833),
        Vector2 0.056 (-0.667),
        Vector2 0.000 (-0.500),
        Vector2 0.179 (-0.333),
        Vector2 0.127 (-0.167),
        Vector2 0.089   0.000,
        Vector2 0.136   0.167,
        Vector2 0.202   0.333,
        Vector2 0.085   0.500,
        Vector2 0.208   0.667,
        Vector2 0.156   0.833,
        Vector2 0.038   1.000
    ]
