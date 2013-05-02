# Miguel Ramos, 2013.
DEPS = AckRecursive.hs AckCPS.hs AckPhi.hs AckList.hs \
       PhiRecursive.hs PhiList.hs PhiComposition.hs
SOURCES = ack.hs phi.hs $(DEPS)
TARGETS = ack phi

include ../haskell.mk

ack.o : ack.hs $(DEPS:%.hs=%.hi)
ack : ack.o $(DEPS:%.hs=%.o)
phi.o : phi.hs $(DEPS:%.hs=%.hi)
phi : phi.o $(DEPS:%.hs=%.o)
