-- Miguel Ramos, 2013.

module Main (main) where
{-# LANGUAGE OverlappingInstances #-}

import Level0
--import Level1
--import Level2

u0 = FVector 3 (\ i -> if (i == 0) then 1 else 0)
u1 = FVector 3 (\ i -> if (i == 1) then 1 else 0)
u2 = FVector 3 (\ i -> if (i == 2) then 1 else 0)

i3 = FMatrix 3 3 (\ i j -> if (i == j) then 1 else 0)
a = FMatrix 3 3 (\ i j -> 3*i + j)
b = FMatrix 3 3 (\ i j -> i + 3*j)

main = do
    putStrLn $ show $ u0
    putStrLn $ show $ u1
    putStrLn $ show $ u2
    --putStrLn $ show $ row 0 i3
    --putStrLn $ show $ row 1 i3
    --putStrLn $ show $ row 2 i3
    --putStrLn $ show $ col 0 i3
    --putStrLn $ show $ col 1 i3
    --putStrLn $ show $ col 2 i3
    --putStrLn $ show $ row 0 a
    --putStrLn $ show $ row 1 a
    --putStrLn $ show $ row 2 a
    --putStrLn $ show $ row 0 (transpose a)
    --putStrLn $ show $ row 1 (transpose a)
    --putStrLn $ show $ row 2 (transpose a)
    --putStrLn $ show $ row 0 (minor 1 1 a)
    --putStrLn $ show $ row 1 (minor 1 1 a)
