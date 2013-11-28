
every n xs | n <= 1 = xs
every _ []          = []
every n (x:xs)      = x : skip n xs
    where skip 1 xs     = every n xs
          skip _ []     = []
          skip n (x:xs) = skip (n-1) xs
