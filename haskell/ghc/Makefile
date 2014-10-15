# Miguel Ramos, 2014.
TARGETS = fibonacci parse
PACKAGES = ghc-7.8.3 ghc-paths

all : $(TARGETS)

fibonacci : fibonacci.o
fibonacci.o : fibonacci.hs

parse : parse.o
parse.o : parse.hs

include ../haskell.mk
