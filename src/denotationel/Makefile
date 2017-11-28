# ocamllex lexer.mll
# 83 states, 7013 transitions, table size 28550 bytes
# ocamlc -c lexer.ml -o lexer.cmo
# menhir parser.mly
# ocamlc -c parser.ml -o parser.cmo
# ocamlc -c env.ml -o env.cmo
# ocamlc -c mem.ml -o mem.cmo
# ocamlc -c expr.ml -o expr.cmo
# ocamlc -c value.ml -o value.cmo
# ocamlc -c host.ml -o host.cmo
# ocamlc -c deno.ml -o deno.cmo
# ocamlc -c eval.ml -o eval.cmo
# ocamlc -c pretty.ml -o pretty.cmo
# ocamlc -c exec.ml -o exec.cmo
# ocamlc -c lispwebeval.ml -o lispwebeval.cmo
# ocamlc -pp "camlp4 camlp4-options" -o lispwebeval str.cma unix.cma lexer.cmo parser.cmo env.cmo mem.cmo expr.cmo value.cmo host.cmo deno.cmo eval.cmo pretty.cmo exec.cmo lispwebeval.cmo
# rm parser.ml lexer.ml

BINS=lispwebeval
DEPS=expr.cmo value.cmo env.cmo mem.cmo host.cmo pretty.cmo eval.cmo exec.cmo


all: $(BINS)

lispwebeval: $(DEPS) parser.cmo lexer.cmo lispwebeval.cmo
	ocamlc -pp "camlp4 camlp4-options" -o $@ str.cma unix.cma $(DEPS) parser.cmo lexer.cmo lispwebeval.cmo

parser.cmo:parser.ml
	ocamlc parser.mli
	ocamlc -c parser.ml -o parser.cmo

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
	rm -rf lispwebeval lispwebrepl *.cmo lexer.ml parser.ml *.cmi parser.mli

mrproper: clean
	rm -rf *~
