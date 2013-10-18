-- Miguel Ramos, 2013.

module Level2 where

rowMajor (m,n) (i,j) = i*n + j
columnMajor (m,n) (i,j) = i + j*m

rowMajor' (m,n) k = divMod k n
columnMajor' (m,n) k = swap $ divMod k m where swap (a,b) = (b,a)

