# Miguel Ramos, 2014-2015.
SOURCES = pairs.hs
TARGETS = pairs

#HC_OPTS =

all : $(TARGETS)
stg : $(SOURCES:%.hs=%.dump-stg)
prep : $(SOURCES:%.hs=%.dump-prep)

include ../haskell.mk
