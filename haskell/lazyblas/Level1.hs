-- Miguel Ramos, 2013.

module Level1 where

every n xs
    | n == 1 = xs
    | n == 0 = repeat (head xs)
    | n < 0 = error "ListBlas.Level1.stride: negative stride"
    | otherwise = let stride = splitAt n xs
                  in head (fst stride) : every n (snd stride)

addV xs [] = xs
addV [] ys = ys
addV (x:xs) (y:ys) = x + y : addV xs ys

negV xs = map negate xs

subV xs [] = xs
subV [] ys = negV ys
subV (x:xs) (y:ys) = x - y : subV xs ys

scal a [] = []
scal a (x:xs) = a * x : scal a xs

-- axpy makes no sense in a lazy world.
axpy a xs [] = scal a xs
axpy a [] ys = ys
axpy a (x:xs) (y:ys) = a*x + y : axpy a xs ys

dot [] ys = 0
dot xs [] = 0
dot (x:xs) (y:ys) = x*y + dot xs ys

asum xs = sum $ map abs xs
nrm1 xs = asum xs

nrm2 xs = sqrt $ sum $ map (\ x -> x*x) xs

amax xs = maximum $ map abs xs
nrmInf xs = amax xs

genV n f = take n $ map f $ iterate succ 1
canonV n = genV n id

