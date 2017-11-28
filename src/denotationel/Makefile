BINS=lispwebeval
DEPS=lexer.cmo parser.cmo expr.cmo value.cmo host.cmo deno.cmo lispwebeval.cmo

all: $(BINS)

lispwebeval: parser.cmi $(DEPS)
	ocamlc -pp "camlp4 camlp4-options" -o $@ str.cma unix.cma $(DEPS)

%.cmi: %.mli
	ocamlc $^

.SUFFIXES: .mll .mly .mli .ml .cmi .cmo .cmx

.mll.mli:
	ocamllex $<

.mll.ml:
	ocamllex $<

.mly.mli:
	menhir $<

.mly.ml:
	menhir $<

.mli.cmi:
	ocamlc -c $^

%.cmi:%.ml
	ocamlc -c $^ -o $@

%.cmo:%.ml
	ocamlc -c $^ -o $@

test: lispwebeval
	./$^ < test/test.scm

clean:
	rm -rf lispwebeval lispwebrepl *.cmo lexer.ml parser.ml

mrproper: clean
	rm -rf *~
