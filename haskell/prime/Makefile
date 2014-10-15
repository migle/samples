# Miguel Ramos, 2014.
SOURCES = prime.hs sieve.hs sieve-array.hs sieve-lazy.hs
TARGETS = prime sieve sieve-array sieve-lazy
HC_OPTS = -O2 -feager-blackholing
HL_OPTS = -rtsopts -threaded

all : prime sieve

prime : prime.hs
sieve : sieve.hs
sieve-array : sieve-array.hs
sieve-lazy : sieve-lazy.hs

include ../haskell.mk
