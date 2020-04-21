#
# Pure OCaml, package from Opam, two directories
#

# - The -I flag introduces sub-directories
# - -use-ocamlfind is required to find packages (from Opam)
# - _tags file introduces packages, bin_annot flag for tool chain
# - using *.mll and *.mly are handled automatically

# - we are using menhir, the modern replacement for OCamlYacc
# OCB_FLAGS = -use-ocamlfind             -I src -I lib # uses ocamlyacc
.PHONY: 	all clean byte native profile debug sanity test

OCB_FLAGS   = -use-ocamlfind -use-menhir -I src -I lib -tag thread -r -package unix -package ssl -package str# uses menhir
OCB = ocamlbuild $(OCB_FLAGS)
VERSION=1.0

all: native byte # profile debug

clean:
	$(OCB) -clean

mrproper: clean
	rm -rf *~

native: sanity
	$(OCB) src/lispwebeval.native

byte: sanity
	$(OCB) lispwebeval.byte

profile: sanity
	$(OCB) -tag profile main.native

debug: sanity
	$(OCB) -tag debug main.byte

# check that menhir is installed, use "opam install menhir"
sanity:
	which menhir

install: install-bin install-lib

install-bin:
	cp lispwebeval.native /usr/local/bin/lispwebeval.$(VERSION).native
	rm -f /usr/local/bin/lispwebeval.native
	ln -s /usr/local/bin/lispwebeval.$(VERSION).native /usr/local/bin/lispwebeval.native
	rm -f /usr/local/bin/lispwebeval
	ln -s /usr/local/bin/lispwebeval.$(VERSION).native /usr/local/bin/lispwebeval

uninstall-bin:
	rm -f /usr/local/bin/lispwebeval
	rm -f  /usr/local/bin/lispwebeval.native
	rm -f /usr/local/bin/lispwebeval.$(VERSION).native

install-lib:
	mkdir -p /usr/local/lib/lispweb
	cp -R lib/* /usr/local/lib/lispweb

uninstall-lib:
	rm -rf /usr/local/lib/lispweb

uninstall: uninstall-bin uninstall-lib

test: native
	./lispwebeval.native test/add.scm
	./lispwebeval.native test/first.scm
	./lispwebeval.native test/let.scm
	./lispwebeval.native test/callcc.scm
	./lispwebeval.native test/catch.scm
	./lispwebeval.native test/block.scm
	./lispwebeval.native test/all.scm
	./lispwebeval.native test/add.scm
#	./lispwebeval.native test/cond.scm
#	./lispwebeval.native test/host.scm
	./lispwebeval.native test/library.scm
#	./lispwebeval.native test/module.scm
	./lispwebeval.native test/define.scm
	./lispwebeval.native test/basic.scm
	./lispwebeval.native test/string.scm
	./lispwebeval.native test/file.scm
#	./lispwebeval.native test/socket.scm
#	./lispwebeval.native test/echo.scm
	./lispwebeval.native test/list.scm
	./lispwebeval.native test/html.scm
	./lispwebeval.native test/test.scm
#	./lispwebeval.native test/http.scm
	./lispwebeval.native test/load.scm