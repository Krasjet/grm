# not a makefile, but rather an install script

# on BSDs, GNU rm is sometimes named grm, so make sure you are
# not overriding it
PREFIX = /usr

install:
	mkdir -p ${PREFIX}/bin
	cp -f grm ${PREFIX}/bin/

uninstall:
	rm -f ${PREFIX}/bin/grm

.PHONY: install uninstall
