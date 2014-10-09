# Miguel Ramos, 2014.
SOURCES = prime.hs sieve.hs
TARGETS = prime sieve
HC_OPTS = -O2 -feager-blackholing
HL_OPTS = -rtsopts -threaded

all : prime sieve
prime : prime.o
prime.o : prime.hs
sieve : sieve.o
sieve.o : sieve.hs

include ../haskell.mk
