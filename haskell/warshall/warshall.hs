-- Miguel Ramos, 2014.

module Main (main) where

distance w i j 0 = w i j
distance w i j k = let p = k - 1
                   in min (distance w i j p)
                          (distance w i p p + distance w p j p)

path w i j 0 = (j, w i j)
path w i j k = let p             = k - 1
                   dir@(_, dirW) = path w i j p
                   (indN, indW1) = path w i p p
                   (_,    indW2) = path w p j p
                   indW          = indW1 + indW2
               in if indW < dirW then (indN, indW) else dir

vertices = [0..3]

edge 0 1 = (-2)
edge 1 2 = 2
edge 2 3 = (-1)
edge 3 0 = 4
edge 3 1 = 3
edge _ _ = (read "Infinity")::Float

main = let n = length vertices
       in do
         print [ ( i, j, distance edge i j n ) | i <- vertices, j <- vertices ]
         print [ ( i, j, path edge i j n ) | i <- vertices, j <- vertices ]
