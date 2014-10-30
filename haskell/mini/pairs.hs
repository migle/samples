-- Miguel Ramos, 2014.
{-# LANGUAGE BangPatterns, MagicHash #-}

import GHC.Exts
import GHC.Prim
import System.Environment (getArgs)

pairs :: Int -> [(Int, Int)]
pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

sums :: Int -> [Int]
sums n = [ i + j | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

sumSum = sum . map (\ (a, b) -> a + b)

{-# NOINLINE base #-}
base = pairs
{-# NOINLINE baseN #-}
baseN = length . pairs
{-# NOINLINE baseSum #-}
baseSum = sumSum . pairs
{-# NOINLINE baseSums #-}
baseSums = sum . sums

{-# NOINLINE stg #-}
stg = stgPairs
{-# NOINLINE stgN #-}
stgN = length . stgPairs
{-# NOINLINE stgSum #-}
stgSum = sumSum . stgPairs
{-# NOINLINE stgSums #-}

{-# NOINLINE re #-}
re = rePairs
{-# NOINLINE reN #-}
reN = length . rePairs
{-# NOINLINE reSum #-}
reSum = sumSum . rePairs
{-# NOINLINE reSums #-}

main = do
  args <- getArgs
  case args of
    [ "pr", arg ]
        | n <- read arg -> print $ base n
    [ "n", arg ]
        | n <- read arg -> print $ baseN n
    [ "sum", arg ]
        | n <- read arg -> print $ baseSum n
    [ "sums", arg ]
        | n <- read arg -> print $ baseSums n
    [ "stg-pr", arg ]
        | n <- read arg -> print $ stg n
    [ "stg-n", arg ]
        | n <- read arg -> print $ stgN n
    [ "stg-sum", arg ]
        | n <- read arg -> print $ stgSum n
    [ "stg-sums", arg ]
        | n <- read arg -> print $ stgSums n
    [ "re-pr", arg ]
        | n <- read arg -> print $ re n
    [ "re-n", arg ]
        | n <- read arg -> print $ reN n
    [ "re-sum", arg ]
        | n <- read arg -> print $ reSum n
    [ "re-sums", arg ]
        | n <- read arg -> print $ reSums n


-- This is how pairs looks when compiled to STG.
stgPairs :: Int -> [(Int, Int)]
stgPairs n = case n of
               I# i -> stgPairs' i

stgPairs' :: Int# -> [(Int, Int)]
stgPairs' n =
  case 1# ># n of
    nlt1@_ ->
      case (tagToEnum# nlt1)::Bool of
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

-- We can simplify the STG for presentation, mostly eliminating boxed/unboxed complexity.
rePairs :: Int -> [(Int, Int)]
rePairs n = case 1 > n of
              True -> []
              False -> let f i = case i + 1 of
                                   jFirst@_ ->
                                     let fTail = case i == n of
                                                   True -> []
                                                   False -> case i + 1 of
                                                              iSucc@_ -> f iSucc
                                     in case jFirst > n of
                                          True -> fTail
                                          False -> let g j = let gTail = case j == n of
                                                                           True -> fTail
                                                                           False -> case j + 1 of
                                                                                      jSucc@_ -> g jSucc
                                                             in let pair = (i, j)
                                                                in pair : gTail
                                                   in g jFirst
                       in f 1

-- Same thing using patterns and "where", instead of "case" or "if-then-else", which looks nicer.
prPairs :: Int -> [(Int, Int)]
prPairs n | 1 > n     = []
          | otherwise = let f i | jFirst > n = fTail
                                | otherwise  = let g j = (i, j) : gTail
                                                     where gTail | j == n    = fTail
                                                                 | otherwise = g (j + 1)
                                               in g jFirst
                              where jFirst = i + 1
                                    fTail | i == n    = []
                                          | otherwise = f (i + 1)
                        in f 1

-- This is how sums looks when compiled to STG.
sumZero :: Int
sumZero = sum []

stgSums :: Int -> Int
stgSums x = case x of
              I# n ->
                case 1# ># n of
                  nlt1@_ ->
                    case (tagToEnum# nlt1)::Bool of
                      True -> sumZero
                      False ->
                        let f :: Int# -> [Int]
                            f i = case i +# 1# of
                                    jFirst@_ ->
                                      let fTail :: [Int]
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
                                                 let g :: Int# -> [Int]
                                                     g j = let gTail :: [Int]
                                                               gTail = case j ==# n of
                                                                         jeqn@_ ->
                                                                           case (tagToEnum# jeqn)::Bool of
                                                                             True -> fTail
                                                                             False -> case j +# 1# of
                                                                                        jSucc@_ -> g jSucc
                                                           in case i +# j of
                                                                ipj@_ ->
                                                                  let box :: Int
                                                                      box = I# ipj
                                                                  in box : gTail
                                                 in g jFirst
                        in case f 1# of
                             list@_ -> sum list

-- Again, this is the STG simplified eliminating boxed/unboxed stuff.
reSums :: Int -> Int
reSums n = case 1 > n of
             True -> sumZero
             False -> let f i = case i + 1 of
                                  jFirst@_ ->
                                    let fTail = case i == n of
                                                  True -> []
                                                  False -> case i + 1 of
                                                             iSucc@_ -> f iSucc
                                    in case jFirst > n of
                                         True -> fTail
                                         False -> let g j = let gTail = case j == n of
                                                                          True -> fTail
                                                                          False -> case j + 1 of
                                                                                     jSucc@_ -> g jSucc
                                                            in case i + j of
                                                                 ipj@_ -> ipj : gTail
                                                  in g jFirst
                      in case f 1 of
                           list@_ -> sum list

