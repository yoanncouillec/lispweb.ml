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
	$(OCB) src/evaluate.native
	$(OCB) src/compile.native

byte: sanity
	$(OCB) evaluate.byte
	$(OCB) compile.byte

profile: sanity
	$(OCB) -tag profile main.native

debug: sanity
	$(OCB) -tag debug main.byte

# check that menhir is installed, use "opam install menhir"
sanity:
	which menhir

install: install-bin install-lib

install-bin:
	cp evaluate.native /usr/local/bin/evaluate.$(VERSION).native
	rm -f /usr/local/bin/evaluate.native
	ln -s /usr/local/bin/evaluate.$(VERSION).native /usr/local/bin/evaluate.native
	rm -f /usr/local/bin/evaluate
	ln -s /usr/local/bin/evaluate.$(VERSION).native /usr/local/bin/evaluate

uninstall-bin:
	rm -f /usr/local/bin/evaluate
	rm -f  /usr/local/bin/evaluate.native
	rm -f /usr/local/bin/evaluate.$(VERSION).native

install-lib:
	mkdir -p /usr/local/lib/lispweb
	cp -R lib/* /usr/local/lib/lispweb

uninstall-lib:
	rm -rf /usr/local/lib/lispweb

uninstall: uninstall-bin uninstall-lib

test: native
	./evaluate.native --load test/testapp.scm
	./evaluate.native --load test/deb.scm
	./evaluate.native --load test/add.scm
	./evaluate.native --load test/first.scm
	./evaluate.native --load test/let.scm
	./evaluate.native --load test/catch.scm
	./evaluate.native --load test/block.scm
	./evaluate.native --load test/all.scm
	./evaluate.native --load test/library.scm
	./evaluate.native --load test/define.scm
	./evaluate.native --load test/basic.scm
	./evaluate.native --from-syntax js --load test/add.js
	./evaluate.native --from-syntax js --load test/first.js
	./evaluate.native --from-syntax js --load test/let.js
	./evaluate.native --from-syntax js --load test/function.js
	./evaluate.native --load test/list.scm
	./evaluate.native --load test/string.scm	
	./evaluate.native --load test/callcc.scm
