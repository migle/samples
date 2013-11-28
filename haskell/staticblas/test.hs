-- Miguel Ramos, 2013.
{-# LANGUAGE DataKinds #-}
--{-# LANGUAGE DataKinds, OverlappingInstances #-}

module Main (main) where

import Level0

zero = (FVector (\ _ -> 0))::(FVector 3 Int)
ones = (FVector (\ _ -> 1))::(FVector 3 Int)
u0 = (FVector (\ i -> if (i == 0) then 1 else 0))::(FVector 3 Int)
u1 = (FVector (\ i -> if (i == 1) then 1 else 0))::(FVector 3 Int)
u2 = (FVector (\ i -> if (i == 2) then 1 else 0))::(FVector 3 Int)

x = (FVector (\ i -> if (i < 3) then 1 else 0))::(FVector 3 Int)

id3 = (FMatrix (\ i j -> if (i == j) then 1 else 0))::(FMatrix 3 3 Int)

a = (FMatrix (\ i j -> 3*i + j))::(FMatrix 3 3 Int)
b = (FMatrix (\ i j -> i + 3*j))::(FMatrix 3 3 Int)

c = (FMatrix (\ i j -> if (i == j) then 1 else 0))::(FMatrix 3 2 Int)

main = do
--    putStrLn $ (show zero) ++ " of size " ++ (show $ dim zero)
--    putStrLn $ show ones
--    putStrLn $ show u0
--    putStrLn $ show u1
--    putStrLn $ show u2
--    putStrLn $ show x
--    putStrLn $ show $ x == zero
--    putStrLn $ show $ x == ones
--    putStrLn $ show $ x == u0
--    putStrLn $ show $ x == u1
--    putStrLn $ show $ x == u2

    putStrLn $ show id3
    putStrLn $ show a
    putStrLn $ show b
    putStrLn $ show c
    putStrLn $ show $ a == b
    putStrLn $ show $ a == a
