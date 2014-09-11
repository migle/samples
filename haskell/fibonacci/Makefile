# Miguel Ramos, 2013-2014.
SOURCES = fibo.hs FiboNaive.hs FiboTail.hs FiboList.hs FiboPair.hs
TARGETS = fibo

fibo : fibo.o FiboNaive.o FiboTail.o FiboList.o FiboPair.o

fibo.o : fibo.hs FiboNaive.hi FiboTail.hi FiboList.hi FiboPair.hi

include ../haskell.mk
