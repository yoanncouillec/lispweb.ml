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

OCB_FLAGS   = -use-ocamlfind -use-menhir -I src -I src/eval -I src/parse -I src/main -tag thread -r -package unix -package ssl -package str -package curl -package ISO8601 -package ANSITerminal -package core # uses menhir
OCB = ocamlbuild $(OCB_FLAGS)
VERSION=1.0

all: native byte # profile debug

clean:
	$(OCB) -clean

mrproper: clean
	rm -rf *~

native: sanity
	$(OCB) lispwebevaluate.native
	$(OCB) lispwebcompile.native

byte: sanity
	$(OCB) lispwebevaluate.byte
	$(OCB) lispwebcompile.byte

profile: sanity
	$(OCB) -tag profile main.native

debug: sanity
	$(OCB) -tag debug main.byte

# check that menhir is installed, use "opam install menhir"
sanity:
	which menhir

install: install-bin install-lib

install-bin:
	cp lispwebevaluate.native /usr/local/bin/lispwebevaluate.$(VERSION).native
	rm -f /usr/local/bin/lispwebevaluate.native
	ln -s /usr/local/bin/lispwebevaluate.$(VERSION).native /usr/local/bin/lispwebevaluate.native
	rm -f /usr/local/bin/lispwebevaluate
	ln -s /usr/local/bin/lispwebevaluate.$(VERSION).native /usr/local/bin/lispwebevaluate

uninstall-bin:
	rm -f /usr/local/bin/lispwebevaluate
	rm -f  /usr/local/bin/lispwebevaluate.native
	rm -f /usr/local/bin/lispwebevaluate.$(VERSION).native

install-lib:
	mkdir -p /usr/local/lib/lispweb
	cp -R lib/* /usr/local/lib/lispweb

uninstall-lib:
	rm -rf /usr/local/lib/lispweb

uninstall: uninstall-bin uninstall-lib

build_images: build_ocaml_image build_lispweb_image

build_ocaml_image:
	docker build -t ocaml:latest -f docker/DockerfileOCaml .

build_lispweb_image:
	docker build --no-cache -t lispweb:latest -f docker/DockerfileLispweb .

repl:
	./lispwebevaluate.native -lrepl

test: native
	./lispwebevaluate.native --load test/basic_test.scm
	./lispwebevaluate.native --load test/string_test.scm
	./lispwebevaluate.native --load test/list_test.scm
	./lispwebevaluate.native --load test/load_test.scm
	# ./lispwebevaluate.native --load test/library.scm
	# ./lispwebevaluate.native --from-syntax js --load test/add.js
	# ./lispwebevaluate.native --from-syntax js --load test/first.js
	# ./lispwebevaluate.native --from-syntax js --load test/let.js
	# ./lispwebevaluate.native --from-syntax js --load test/function.js

test_install:
	lispwebevaluate --load test/basic_test.scm
	lispwebevaluate --load test/string_test.scm
	lispwebevaluate --load test/list_test.scm
	lispwebevaluate --load test/load_test.scm
