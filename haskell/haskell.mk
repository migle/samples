# Miguel Ramos, 2013.
SOURCES ?= $(TARGETS:%=%.hs)
SOURCES_HS = $(filter %.hs,$(SOURCES))
SOURCES_LHS = $(filter %.lhs,$(SOURCES))

TARGETS ?= $(SOURCES_LHS:%.lhs=%) $(SOURCES_HS:%.hs=%)
PACKAGES ?=

HC ?= ghc
HC_OPTS ?= -O2
HL_OPTS ?= -rtsopts
HC_PAROPTS ?= -feager-blackholing
HL_PAROPTS ?= -threaded
HL_PACKAGES = $(foreach pkg,$(PACKAGES),-package $(pkg))

COMPILE.hs = $(HC) $(HC_OPTS) -c
COMPILE-p.hs = $(HC) $(HC_OPTS) $(HC_PAROPTS) -c
NOASM.hs = $(HC) $(HC_OPTS) -S
NOASM-p.hs = $(HC) $(HC_OPTS) $(HC_PAROPTS) -S
LINK.hs = $(HC) $(HC_OPTS) $(HL_OPTS) $(HL_PACKAGES)
LINK-p.hs = $(HC) $(HC_OPTS) $(HC_PAROPTS) $(HL_OPTS) $(HL_PAROPTS) $(HL_PACKAGES)

%.o %.hi : %.hs
	$(COMPILE.hs) $<
%.o %.hi : %.lhs
	$(COMPILE.hs) $<
% : %.o
	$(LINK.hs) $^ -o $@
% %.o %.hi : %.hs
	$(LINK.hs) $^ -o $@
% %.o %.hi : %.lhs
	$(LINK.hs) $^ -o $@

%-p.o %-p.hi : %-p.hs
	$(COMPILE-p.hs) $<
%-p.o %-p.hi : %-p.lhs
	$(COMPILE-p.hs) $<
%-p : %-p.o
	$(LINK-p.hs) $^ -o $@
%-p %-p.o %-p.hi : %-p.hs
	$(LINK-p.hs) $^ -o $@
%-p %-p.o %-p.hi : %-p.lhs
	$(LINK-p.hs) $^ -o $@

%.s : %.hs
	$(NOASM.hs) $<
%.s : %.lhs
	$(NOASM.hs) $<

%.ll %.o %.hi : %.hs
	$(COMPILE.hs) -fforce-recomp -keep-llvm-file $<
%.ll %.o %.hi : %.lhs
	$(COMPILE.hs) -fforce-recomp -keep-llvm-file $<

%.dump-cmm %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-cmm $<
%.dump-cmm %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-cmm $<

%.dump-llvm %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-llvm $<
%.dump-llvm %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-llvm $<

%.dump-opt-cmm %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-opt-cmm $<
%.dump-opt-cmm %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-opt-cmm $<

%.dump-prep %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-prep $<
%.dump-prep %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-prep $<

%.dump-simpl %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-simpl $<
%.dump-simpl %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-simpl $<

%.dump-stg %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-stg $<
%.dump-stg %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-stg $<

%.dump-stranal %.o %.hi : %.hs
	$(COMPILE.hs) -ddump-to-file -ddump-stranal $<
%.dump-stranal %.o %.hi : %.lhs
	$(COMPILE.hs) -ddump-to-file -ddump-stranal $<

all : $(TARGETS)

clean :
	@$(RM) -v $(TARGETS)
	@$(RM) -v $(SOURCES_HS:%.hs=%.hspp) $(SOURCES_LHS:%.lhs=%.hspp)
	@$(RM) -v $(SOURCES_HS:%.hs=%.hc) $(SOURCES_LHS:%.lhs=%.hc)
	@$(RM) -v $(SOURCES_HS:%.hs=%.hi) $(SOURCES_LHS:%.lhs=%.hi)
	@$(RM) -v $(SOURCES_HS:%.hs=%.o) $(SOURCES_LHS:%.lhs=%.o)
	@$(RM) -v $(SOURCES_HS:%.hs=%.s) $(SOURCES_LHS:%.lhs=%.s)
	@$(RM) -v $(SOURCES_HS:%.hs=%.ll) $(SOURCES_LHS:%.lhs=%.ll)
	@$(RM) -v $(SOURCES_HS:%.hs=%.dump-*) $(SOURCES_LHS:%.lhs=%.dump-*)
