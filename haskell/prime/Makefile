# Miguel Ramos, 2014.
SOURCES = approx.hs prime.hs sieve.hs sieve-array.hs sieve-bird.hs sieve-lazy.hs
TARGETS = approx prime sieve sieve-array sieve-bird sieve-lazy
HC_OPTS = -O2 -feager-blackholing
HL_OPTS = -rtsopts -threaded

all : approx prime sieve sieve-bird sieve-lazy

approx : approx.hs
prime : prime.hs
sieve : sieve.hs
sieve-array : sieve-array.hs
sieve-bird : sieve-bird.hs
sieve-lazy : sieve-lazy.hs

include ../haskell.mk
