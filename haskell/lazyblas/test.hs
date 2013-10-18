-- Miguel Ramos, 2013.

module Main (main) where

import Level0
--import Level1
--import Level2

b0 = FVector 3 (\ i -> if (i == 0) then 1 else 0)
b1 = FVector 3 (\ i -> if (i == 1) then 1 else 0)
b2 = FVector 3 (\ i -> if (i == 2) then 1 else 0)

i3 = FMatrix 3 3 (\ i j -> if (i == j) then 1 else 0)
a = FMatrix 3 3 (\ i j -> 3*i + j)

main = do
    putStrLn $ show $ b0
    putStrLn $ show $ b1
    putStrLn $ show $ b2
    putStrLn $ show $ row 0 i3
    putStrLn $ show $ row 1 i3
    putStrLn $ show $ row 2 i3
    putStrLn $ show $ col 0 i3
    putStrLn $ show $ col 1 i3
    putStrLn $ show $ col 2 i3
    putStrLn $ show $ row 0 a
    putStrLn $ show $ row 1 a
    putStrLn $ show $ row 2 a
    putStrLn $ show $ row 0 (trans a)
    putStrLn $ show $ row 1 (trans a)
    putStrLn $ show $ row 2 (trans a)
    putStrLn $ show $ row 0 (minor 1 1 a)
    putStrLn $ show $ row 1 (minor 1 1 a)
