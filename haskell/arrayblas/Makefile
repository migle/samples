# Miguel Ramos, 2015.
SOURCES = test.hs Level0.hs Level1.hs
TARGETS = test
PACKAGES = array

test : test.o Level0.o Level1.o

test.o : test.hs Level0.hi Level1.hi

include ../haskell.mk
