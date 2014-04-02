# Miguel Ramos, 2014.
CXXFLAGS ?= -std=c++11 -O3 -ffast-math
race : race.cpp

test :
	touch race.cpp
	make "CXXFLAGS=-std=c++11 -O0"  race
	./race 8192 1000
	./race 1048576 10
	touch race.cpp
	make "CXXFLAGS=-std=c++11 -O1"  race
	./race 8192 1000
	./race 1048576 10
	touch race.cpp
	make "CXXFLAGS=-std=c++11 -O2"  race
	./race 8192 1000
	./race 1048576 100
	./race 16777216 10
	touch race.cpp
	make "CXXFLAGS=-std=c++11 -O3 -ffast-math -fassociative-math"  race
	./race 8192 1000
	./race 1048576 100
	./race 16777216 10
	./race 800000000 1
