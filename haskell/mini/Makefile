# Miguel Ramos, 2014.
SOURCES = pairs.hs pairs-distilled.hs tak.hs
TARGETS = pairs tak
HC_OPTS = -O2 -feager-blackholing
HL_OPTS = -rtsopts -threaded

all : $(TARGETS)
stg : $(SOURCES:%.hs=%.dump-stg)
prep : $(SOURCES:%.hs=%.dump-prep)

include ../haskell.mk
