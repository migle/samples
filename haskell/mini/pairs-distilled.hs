-- Miguel Ramos, 2014.

module Pairs (pairs, nPairs, sumPairs) where

pairs :: Int -> [(Int, Int)]
pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

nPairs = length . pairs

sumPairs = sum . map (\ (a, b) -> a + b) . pairs
