-- Miguel Ramos, 2013.

module Main (main) where

import LineFit
import UniformRange

import System.Environment (getArgs)
import System.Random

linePoints :: Int -> StdGen -> Float -> Float -> Float -> Float -> [ Vector2 Float ]
linePoints 0 g a b c e = []
linePoints n g a b c e =
    let range = genRange g
        tg = next g
        rg = next (snd tg)
        fg = next (snd rg)
        t = realLineRange range (fst tg)
        x = if b > a then t else (c - b*y)/a
        y = if b > a then (c - a*x)/b else t
        r = uniformHalfOpenRange range (0, e) (fst rg)
        f = uniformHalfOpenRange range (0, 8*2*pi) (fst fg)
        ex = r * (sin f)
        ey = r * (cos f)
    in (Vector2 (x+ex) (y+ey)) : linePoints (pred n) (snd fg) a b c e

main = do
  args <- getArgs
  case args of
    [ "test" ] -> putStrLn $ show $ lineFit lineFitTestData
    [ argN, argA, argB, argC, argE ]
        | n <- (read argN),
          a <- (read argA),
          b <- (read argB),
          c <- (read argC),
          r <- (read argE) ->
      let points = linePoints n (mkStdGen 0) a b c r
      in do
           putStrLn $ show $ points
           putStrLn $ show $ lineFit points
