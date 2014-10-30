-- Miguel Ramos, 2014.
{-# LANGUAGE BangPatterns, MagicHash #-}

import GHC.Exts
import GHC.Prim
import System.Environment (getArgs)

pairs :: Int -> [(Int, Int)]
pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

nPairs = length . pairs
sumSum = sum . map (\ (a, b) -> a + b)
sumPairs = sumSum . pairs

main = do
  args <- getArgs
  case args of
    [ "pr", arg ]
        | n <- read arg -> print $ pairs n
    [ "n", arg ]
        | n <- read arg -> print $ nPairs n
    [ "sum", arg ]
        | n <- read arg -> print $ sumPairs n
    [ "stg-pr", arg ]
        | n <- read arg -> print $ stgPairs n
    [ "stg-n", arg ]
        | n <- read arg -> print $ (length . stgPairs) n
    [ "stg-sum", arg ]
        | n <- read arg -> print $ (sumSum . stgPairs) n
    [ "re-pr", arg ]
        | n <- read arg -> print $ rePairs n
    [ "re-n", arg ]
        | n <- read arg -> print $ (length . rePairs) n
    [ "re-sum", arg ]
        | n <- read arg -> print $ (sumSum . rePairs) n


-- When compiled to STG, pairs turns into something like this:
stgPairs :: Int -> [(Int, Int)]
stgPairs n = case n of
               I# i -> stgPairs' i

stgPairs' :: Int# -> [(Int, Int)]
stgPairs' n =
  case 1# ># n of
    ngt1@_ ->
      case (tagToEnum# ngt1)::Bool of
        True -> []
        False ->
          let f :: Int# -> [(Int, Int)]
              f i = case i +# 1# of
                      jFirst@_ ->
                        let fTail :: [(Int, Int)]
                            fTail = case i ==# n of
                                      ieqn@_ ->
                                        case (tagToEnum# ieqn)::Bool of
                                          True -> []
                                          False -> case i +# 1# of
                                                     iSucc@_ -> f iSucc
                        in case jFirst ># n of
                             jgtn@_ ->
                               case (tagToEnum# jgtn)::Bool of
                                 True -> fTail
                                 False ->
                                   let iBox :: Int
                                       iBox = I# i
                                   in let g :: Int# -> [(Int, Int)]
                                          g j = let gTail :: [(Int, Int)]
                                                    gTail = case j ==# n of
                                                              jeqn@_ ->
                                                                case (tagToEnum# jeqn)::Bool of
                                                                  True -> fTail
                                                                  False -> case j +# 1# of
                                                                             jSucc@_ -> g jSucc
                                                in let jBox :: Int
                                                       jBox = I# j
                                                   in let pair :: (Int, Int)
                                                          pair = (iBox, jBox)
                                                      in pair : gTail
                                      in g jFirst
         in f 1#

-- Simplification:
rePairs :: Int -> [(Int, Int)]
rePairs n = case n < 1 of
              True -> []
              False -> let f i = case i + 1 of
                                   jFirst@_ -> let fTail = case i == n of
                                                             True -> []
                                                             False -> f (i + 1)
                                               in case jFirst > n of
                                                    True -> fTail
                                                    False -> let g j = let gTail = case j == n of
                                                                                     True -> fTail
                                                                                     False -> g (j + 1)
                                                                       in (i, j) : gTail
                                                             in g jFirst

-- Prettification:
prPairs :: Int -> [(Int, Int)]
prPairs n | n < 1     = []
          | otherwise = let f i | jFirst > n = fTail
                                | otherwise  = let g j = (i, j) : gTail
                                                     where gTail | j == n    = fTail
                                                                 | otherwise = g (j + 1)
                                               in g jFirst
                              where jFirst = i + 1
                                    fTail | i == n    = []
                                          | otherwise = f (i + 1)
                        in f 1
