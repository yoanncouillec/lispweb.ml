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

OCB_FLAGS   = -use-ocamlfind -use-menhir -I src -I lib -tag thread -r -package unix# uses menhir
OCB = ocamlbuild $(OCB_FLAGS)

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

test: native
	./lispwebeval.native test/add.scm
