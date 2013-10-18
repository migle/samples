-- Miguel Ramos, 2013.
{-# LANGUAGE DataKinds #-}

module Main (main) where

import Level0

zero = (FVector (\ _ -> 0))::(FVector 3 Int)
ones = (FVector (\ _ -> 1))::(FVector 3 Int)
u0 = (FVector (\ i -> if (i == 0) then 1 else 0))::(FVector 3 Int)
u1 = (FVector (\ i -> if (i == 1) then 1 else 0))::(FVector 3 Int)
u2 = (FVector (\ i -> if (i == 2) then 1 else 0))::(FVector 3 Int)

x = (FVector (\ i -> if (i < 3) then 1 else 0))::(FVector 3 Int)

main = do
    putStrLn $ show $ zero
    putStrLn $ show $ ones
    putStrLn $ show $ u0
    putStrLn $ show $ u1
    putStrLn $ show $ u2
    putStrLn $ show $ x
    putStrLn $ show $ x == zero
    putStrLn $ show $ x == ones
    putStrLn $ show $ x == u0
    putStrLn $ show $ x == u1
    putStrLn $ show $ x == u2
