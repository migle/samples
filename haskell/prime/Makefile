# Miguel Ramos, 2014.
SOURCES = prime.hs
TARGETS = prime
HC_OPTS = -O2 -feager-blackholing
HL_OPTS = -rtsopts -threaded

prime : prime.o
prime.o : prime.hs

include ../haskell.mk
