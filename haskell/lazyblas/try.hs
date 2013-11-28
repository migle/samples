
every n xs | n <= 1 = xs
every _ []          = []
every n (x:xs)      = x : skip n xs
    where skip 1 xs     = every n xs
          skip _ []     = []
          skip n (x:xs) = skip (n-1) xs

major i n a = take n $ drop ((i-1)*n) a
minor j n a = every n $ drop (j-1) a

m = 4
n = 2
p = 3

dot [] ys = 0
dot xs [] = 0
dot (x:xs) (y:ys) = x*y + dot xs ys

a :: [Int]
a = [ i*n + j | i <- [1..m], j <- [1..n] ]
b :: [Int]
b = [ if i == j then 1 else 0 | j <- [1..p], i <- [1..n] ]

row a i = major i n a
col b j = major j n b

matMul a b = [ dot (row a i) (col b j) | i <- [1..m], j <- [1..p] ]

--matMulRCR a b = forRow m
--    where forRow 0 = []
--          forRow i = let rc = forCol
--                     ian forRow (i-1) 
            
--          forCol 0 rs = []
--          forCol j rs = 
--          forEntry 0 _ _           = 0
--          forEntry k (a:rs) (b:cs) = a*b + forEntry (k-1) rs cs
