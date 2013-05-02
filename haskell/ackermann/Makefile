# Miguel Ramos, 2013.
SOURCES = Ack.hs AckNaive.hs AckExp.hs
TARGETS = ack

ack : Ack.o AckNaive.o AckExp.o
	$(LINK.hs) $^ $(PACKAGES) -o $@

Ack.o : Ack.hs AckNaive.hi AckExp.hi

include ../haskell.mk
