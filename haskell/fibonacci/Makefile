# Miguel Ramos, 2013.

PROGS=fibolist fibonaive fibotail

% : %.hs
	ghc -O2 $<

all : $(PROGS)

clean :
	@$(RM) -v $(PROGS)
	@$(RM) -v $(PROGS:%=%.o)
	@$(RM) -v $(PROGS:%=%.hi)
