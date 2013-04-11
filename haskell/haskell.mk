# Miguel Ramos, 2013.

% : %.hs
	ghc -O2 -rtsopts $<

% : %.lhs
	ghc -O2 -rtsopts $<

%-p : %-p.hs
	ghc -O2 -threaded -rtsopts $<

%-p : %-p.lhs
	ghc -O2 -threaded -rtsopts $<

all : $(PROGS)

clean :
	@$(RM) -v $(PROGS)
	@$(RM) -v $(PROGS:%=%.o)
	@$(RM) -v $(PROGS:%=%.hi)
