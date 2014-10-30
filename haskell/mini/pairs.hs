-- Miguel Ramos, 2014.

-- We use two language extensions mostly so that we can write Haskell code which is a pretty direct
-- translation from lower-level STG code.
-- BangPatters allows us to force function parameters to be strict.
-- MagicHash is required so we can use the '#' character, as in GHC.Prim.Int#.
{-# LANGUAGE BangPatterns, MagicHash #-}

import GHC.Exts -- From this we use I# which is the data constructor to box and unbox Ints.
import GHC.Prim -- From this we use the primitive type GHC.Prim.Int# and its operators.

import System.Environment (getArgs)

-- The type declarations below have the sole purpose of strengthening the type of expressions to
-- Int so that the compiler output is more readable.

-- Compute the pairs of Ints from 1 up to n.
pairs :: Int -> [(Int, Int)]
pairs n = [ (i, j) | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

-- Compute the sums of pairs of Ints from 1 up to n.
sums :: Int -> [Int]
sums n = [ i + j | i <- [ 1 .. n ], j <- [ (i + 1) .. n ] ]

-- Compute the sum of a list of pairs of Ints (notice currying).
sumSum :: [(Int, Int)] -> Int
sumSum = sum . map (\ (a, b) -> a + b)

-- Compute the sum of a list of Ints.
mySum :: [Int] -> Int
mySum xs = acc 0 xs
  where acc !z []     = z
        acc !z (x:xs) = acc (z + x) xs

-- These are the variations of the program used by the main function.
-- All are NOINLINE so that we can read the compiler output for each of them separately.
-- Notice that all of these functions are curried.

{-# NOINLINE base #-}
base = pairs
{-# NOINLINE baseN #-}
baseN = length . pairs
{-# NOINLINE baseSum #-}
baseSum = sumSum . pairs
{-# NOINLINE baseSumSums #-}
baseSumSums = sum . sums
{-# NOINLINE baseMySumSums #-}
baseMySumSums = mySum . sums

{-# NOINLINE stg #-}
stg = stgPairs
{-# NOINLINE stgN #-}
stgN = length . stgPairs
{-# NOINLINE stgSum #-}
stgSum = sumSum . stgPairs
{-# NOINLINE stgSumSums #-}
stgSumSums = sum . stgSums
{-# NOINLINE stgMySumSums #-}
stgMySumSums = mySum . stgSums

{-# NOINLINE re #-}
re = rePairs
{-# NOINLINE reN #-}
reN = length . rePairs
{-# NOINLINE reSum #-}
reSum = sumSum . rePairs
{-# NOINLINE reSumSums #-}
reSumSums = sum . reSums
{-# NOINLINE reMySumSums #-}
reMySumSums = mySum . reSums


-- This is the main function.
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
        | n <- read arg -> print $ baseSumSums n
    [ "mysums", arg ]
        | n <- read arg -> print $ baseMySumSums n
    [ "stg-pr", arg ]
        | n <- read arg -> print $ stg n
    [ "stg-n", arg ]
        | n <- read arg -> print $ stgN n
    [ "stg-sum", arg ]
        | n <- read arg -> print $ stgSum n
    [ "stg-sums", arg ]
        | n <- read arg -> print $ stgSumSums n
    [ "stg-mysums", arg ]
        | n <- read arg -> print $ stgMySumSums n
    [ "re-pr", arg ]
        | n <- read arg -> print $ re n
    [ "re-n", arg ]
        | n <- read arg -> print $ reN n
    [ "re-sum", arg ]
        | n <- read arg -> print $ reSum n
    [ "re-sums", arg ]
        | n <- read arg -> print $ reSumSums n
    [ "re-mysums", arg ]
        | n <- read arg -> print $ reMySumSums n


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

-- We can simplify the STG for presentation, mostly eliminating boxing/unboxing complexity.
rePairs :: Int -> [(Int, Int)]
rePairs n = case 1 > n of
              True -> []
              False ->
                let f !i = case i + 1 of
                             jFirst@_ ->
                               let fTail = case i == n of
                                             True -> []
                                             False -> case i + 1 of
                                                        iSucc@_ -> f iSucc
                               in case jFirst > n of
                                    True -> fTail
                                    False ->
                                      let g !j = let gTail = case j == n of
                                                               True -> fTail
                                                               False -> case j + 1 of
                                                                          jSucc@_ -> g jSucc
                                                 in let pair = (i, j)
                                                    in pair : gTail
                                      in g jFirst
                in f 1

-- And this is how sums looks when compiled to STG, it is almost the same as pairs.
stgSums :: Int -> [Int]
stgSums n = case n of
              I# i -> stgSums' i

stgSums' :: Int# -> [Int]
stgSums' n =
  case 1# ># n of
    nlt1@_ ->
      case (tagToEnum# nlt1)::Bool of
        True -> []
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
                                                  ipj@_ -> let box :: Int
                                                               box = I# ipj
                                                           in box : gTail
                                   in g jFirst
          in f 1#

-- Again, this is the STG simplified eliminating boxing/unboxing stuff.
reSums :: Int -> [Int]
reSums n = case 1 > n of
             True -> []
             False ->
               let f !i = case i + 1 of
                            jFirst@_ ->
                              let fTail = case i == n of
                                            True -> []
                                            False -> case i + 1 of
                                                       iSucc@_ -> f iSucc
                              in case jFirst > n of
                                   True -> fTail
                                   False ->
                                     let g !j = let gTail = case j == n of
                                                              True -> fTail
                                                              False -> case j + 1 of
                                                                         jSucc@_ -> g jSucc
                                                in case i + j of
                                                     ipj@_ -> ipj : gTail
                                     in g jFirst
               in f 1

