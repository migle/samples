-- Miguel Ramos, 2014.
{-# LANGUAGE BangPatterns, MagicHash #-}

import GHC.Exts
import GHC.Prim
import System.Environment (getArgs)

pairs :: Int -> [(Int, Int)]
pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

nPairs = length . pairs
sumMap = sum . map (\ (a, b) -> a + b)
sumPairs = sumMap . pairs

main = do
  args <- getArgs
  case args of
    [ "n", arg ]
        | n <- read arg -> print $ nPairs n
    [ "sum", arg ]
        | n <- read arg -> print $ sumPairs n
    [ "stg-n", arg ]
        | n <- read arg -> print $ (length . stgPairs) n
    [ "stg-sum", arg ]
        | n <- read arg -> print $ (sumMap . stgPairs) n


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
                                       g :: Int# -> [(Int, Int)]
                                       g j = let gTail :: [(Int, Int)]
                                                 gTail = case j ==# n of
                                                           jeqn@_ ->
                                                             case (tagToEnum# jeqn)::Bool of
                                                               True -> fTail
                                                               False -> case j +# 1# of
                                                                          jSucc@_ -> g jSucc
                                                 jBox :: Int
                                                 jBox = I# j
                                                 pair :: (Int, Int)
                                                 pair = (iBox, jBox)
                                             in pair : gTail
                                   in g jFirst
         in f 1#
