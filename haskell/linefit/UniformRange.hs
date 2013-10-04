-- Miguel Ramos, 2013.

module UniformRange (uniformRange, uniformHalfOpenRange, uniformOpenRange, realLineRange) where

uniformRange :: (Integral a, RealFloat b) => (a, a) -> (b, b) -> a -> b
uniformRange domain range i =
    let wdomain = (snd domain) - (fst domain)
        wrange = (snd range) - (fst range)
        ratio = wrange / (fromIntegral wdomain)
        k = i - (fst domain)
    in (fst range) + (fromIntegral k) * ratio

uniformHalfOpenRange :: (Integral a, RealFloat b) => (a, a) -> (b, b) -> a -> b
uniformHalfOpenRange domain range i =
    let wdomain = (snd domain) - (fst domain) + 1
        wrange = ((snd range) - (fst range)) / 2
        ratio = wrange / (fromIntegral wdomain)
        k = i - (fst domain)
    in (fst range) + (fromIntegral k) * ratio

uniformOpenRange :: (Integral a, RealFloat b) => (a, a) -> (b, b) -> a -> b
uniformOpenRange domain range i =
    let wdomain = (snd domain) - (fst domain) + 2
        wrange = (snd range) - (fst range)
        ratio = wrange / (fromIntegral wdomain)
        k = i - (fst domain) + 1
    in (fst range) + (fromIntegral k) * ratio

realLineRange :: (Integral a, RealFloat b) => (a, a) -> a -> b
realLineRange domain i =
    let x = uniformOpenRange domain (-1,1) i
    in if x > 1 then 1/x - 1 else if x < 0 then 1/x + 1 else 1/x

