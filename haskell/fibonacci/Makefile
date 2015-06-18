# Miguel Ramos, 2013-2015.
SOURCES = fibo.hs FiboNaive.hs FiboTail.hs FiboList.hs FiboST.hs
TARGETS = fibo

fibo : fibo.o FiboNaive.o FiboTail.o FiboList.o FiboST.o

fibo.o : fibo.hs FiboNaive.hi FiboTail.hi FiboList.hi FiboST.hi

include ../haskell.mk
