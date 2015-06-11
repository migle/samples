# Miguel Ramos, 2014.
SOURCES = fib.hs pairs.hs tak.hs
TARGETS = fib pairs tak

#HC_OPTS =

all : $(TARGETS)
stg : $(SOURCES:%.hs=%.dump-stg)
prep : $(SOURCES:%.hs=%.dump-prep)

include ../haskell.mk
