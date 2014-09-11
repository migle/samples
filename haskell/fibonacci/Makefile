# Miguel Ramos, 2013-2014.
SOURCES = fibo.hs FiboNaive.hs FiboTail.hs FiboList.hs FiboPair.hs FiboST.hs
TARGETS = fibo

fibo : fibo.o FiboNaive.o FiboTail.o FiboList.o FiboPair.o FiboST.o

fibo.o : fibo.hs FiboNaive.hi FiboTail.hi FiboList.hi FiboPair.hi FiboST.hi

include ../haskell.mk
