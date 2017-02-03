CABAL ?= cabal
GHC ?= ghc

.PHONY : all
all : cabal.sandbox.config
	$(CABAL) install --disable-documentation
	cp .cabal-sandbox/bin/hw5* .

~/.cabal/config :
	$(CABAL) update

cabal.sandbox.config : ~/.cabal/config
	$(CABAL) update
	$(CABAL) sandbox init
	$(CABAL) install --dependencies-only

.PHONY : clean
clean :
	$(CABAL) clean
	rm -f hw5

.PHONY : distclean
distclean : clean
	rm -rf cabal.sandbox.config .cabal-sandbox

.PHONY : run-tests
run-tests : all
	./hw5 --timeout=2
