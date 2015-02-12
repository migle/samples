# Miguel Ramos, 2015.
SOURCES = binomial.hs factorial.hs stripped.hs
TARGETS = binomial factorial

all : binomial factorial

binomial : binomial.o
binomial.o : binomial.hs

factorial : factorial.o
factorial.o : factorial.hs

stripped.o : stripped.hs

include ../haskell.mk
