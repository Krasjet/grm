# not a makefile, but rather an install script

# On BSDs, GNU rm is sometimes named grm, so
# make sure you are not overriding it
BIN = grm
PREFIX = /usr/local

install:
	mkdir -p ${PREFIX}/bin
	cp -f grm ${PREFIX}/bin/${BIN}

uninstall:
	rm -f ${PREFIX}/bin/${BIN}

.PHONY: install uninstall
