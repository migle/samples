# Miguel Ramos, 2013.
SOURCES = fibo.hs FiboNaive.hs FiboList.hs FiboTail.hs
TARGETS = fibo

fibo : fibo.o FiboNaive.o FiboList.o FiboTail.o

fibo.o : fibo.hs FiboNaive.hi FiboList.hi FiboTail.hi

include ../haskell.mk
