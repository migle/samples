# Miguel Ramos, 2013.
HC?=ghc
HC_OPTS?=-O2
HL_OPTS?=-rtsopts
HC_PAROPTS?=-feager-blackholing
HL_PAROPTS?=-threaded
HL_PKGS?=

%.o %.hi : %.hs
	$(HC) $(HC_OPTS) -c $<
%.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -c $<
% %.o %.hi : %.hs
	$(HC) $(HC_OPTS) $(HL_OPTS) $(HL_PKGS) -o $@ $^
% %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) $(HL_OPTS) $(HL_PKGS) -o $@ $^
% : %.o
	$(HC) $(HL_OPTS) $(HL_PKGS) -o $@ $^

%-p.o %-p.hi : %-p.hs
	$(HC) $(HC_OPTS) $(HC_PAROPTS) -c $<
%-p.o %-p.hi : %-p.lhs
	$(HC) $(HC_OPTS) $(HC_PAROPTS) -c $<
%-p %-p.o %-p.hi : %-p.hs
	$(HC) $(HC_OPTS) $(HC_PAROPTS) $(HL_OPTS) $(HL_PAROPTS) $(HL_PKGS) -o $@ $^
%-p %-p.o %-p.hi : %-p.lhs
	$(HC) $(HC_OPTS) $(HC_PARTOPS) $(HL_OPTS) $(HL_PAROPTS) $(HL_PKGS) -o $@ $^
%-p : %-p.o
	$(HC) $(HL_OPTS) $(HL_PAROPTS) $(HL_PKGS) -o $@ $^

%.s : %.hs
	$(HC) $(HC_OPTS) -S -o $@ $<
%.s : %.lhs
	$(HC) $(HC_OPTS) -S -o $@ $<

%.ll %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -fforce-recomp -keep-llvm-file -c $<
%.ll %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -fforce-recomp -keep-llvm-file -c $<

%.dump-cmm %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-cmm -c $<
%.dump-cmm %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-cmm -c $<

%.dump-llvm %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-llvm -c $<
%.dump-llvm %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-llvm -c $<

%.dump-opt-cmm %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-opt-cmm -c $<
%.dump-opt-cmm %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-opt-cmm -c $<

%.dump-prep %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-prep -c $<
%.dump-prep %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-prep -c $<

%.dump-simpl %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-simpl -c $<
%.dump-simpl %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-simpl -c $<

%.dump-stg %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-stg -c $<
%.dump-stg %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-stg -c $<

%.dump-stranal %.o %.hi : %.hs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-stranal -c $<
%.dump-stranal %.o %.hi : %.lhs
	$(HC) $(HC_OPTS) -ddump-to-file -ddump-stranal -c $<

all : $(PROGS)

clean :
	@$(RM) -v $(PROGS)
	@$(RM) -v $(PROGS:%=%.hspp)
	@$(RM) -v $(PROGS:%=%.hc)
	@$(RM) -v $(PROGS:%=%.hi)
	@$(RM) -v $(PROGS:%=%.o)
	@$(RM) -v $(PROGS:%=%.s)
	@$(RM) -v $(PROGS:%=%.ll)
	@$(RM) -v $(PROGS:%=%.dump-*)
