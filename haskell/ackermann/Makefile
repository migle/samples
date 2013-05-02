# Miguel Ramos, 2013.
DEPS = AckNaive.hs AckGExp.hs GExpDefinition.hs GExpComposition.hs GExpList.hs
SOURCES = ack.hs gexp.hs $(DEPS)
TARGETS = ack gexp

include ../haskell.mk

ack.o : ack.hs $(DEPS:%.hs=%.hi)
ack : ack.o $(DEPS:%.hs=%.o)
gexp.o : gexp.hs $(DEPS:%.hs=%.hi)
gexp : gexp.o $(DEPS:%.hs=%.o)
