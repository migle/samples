# Miguel Ramos, 2014-2015.
SOURCES = fact.hs fib.hs pairs.hs pseudo.hs tak.hs
TARGETS = fact fib pairs pseudo tak

#HC_OPTS =

all : $(TARGETS)
stg : $(SOURCES:%.hs=%.dump-stg)
prep : $(SOURCES:%.hs=%.dump-prep)

include ../haskell.mk
