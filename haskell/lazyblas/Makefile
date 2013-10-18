# Miguel Ramos, 2013.
SOURCES = test.hs Level0.hs Level1.hs Level2.hs
TARGETS = test

test : test.o Level0.o #Level1.o Level2.o

test.o : test.hs Level0.hi #Level1.hi Level2.hi

include ../haskell.mk
