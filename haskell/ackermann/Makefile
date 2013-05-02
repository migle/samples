# Miguel Ramos, 2013.
SOURCES = Ack.hs AckNaive.hs
TARGETS = ack

ack : Ack.o AckNaive.o
	$(LINK.hs) $^ $(PACKAGES) -o $@

Ack.o : Ack.hs AckNaive.hi

include ../haskell.mk
