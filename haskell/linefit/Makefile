# Miguel Ramos, 2013.
SOURCES = fit.hs LineFit.hs UniformRange.hs
TARGETS = fit
PACKAGES = random

fit : fit.o LineFit.o UniformRange.o

fit.o : fit.hs LineFit.hi UniformRange.hi

include ../haskell.mk
