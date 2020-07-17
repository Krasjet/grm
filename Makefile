# not a makefile, but rather an install script

PREFIX = /usr

install:
	mkdir -p ${PREFIX}/bin
	cp -f grm ${PREFIX}/bin/

uninstall:
	rm -f ${PREFIX}/bin/grm

.PHONY: install uninstall
