# Miguel Ramos, 2013.

% : %.hs
	ghc -O2 $<

% : %.lhs
	ghc -O2 $<

all : $(PROGS)

clean :
	@$(RM) -v $(PROGS)
	@$(RM) -v $(PROGS:%=%.o)
	@$(RM) -v $(PROGS:%=%.hi)
