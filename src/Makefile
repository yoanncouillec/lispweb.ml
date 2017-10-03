all: lispwebeval

lispwebeval: lispweb.cmo parser.cmi parser.cmo lexer.cmo lispwebeval.cmo
	ocamlc -o $@ str.cma unix.cma lispweb.cmo parser.cmo lexer.cmo lispwebeval.cmo

lispwebrepl: lispweb.cmo parser.cmi parser.cmo lexer.cmo lispwebrepl.cmo
	ocamlc -o $@ str.cma unix.cma lispweb.cmo parser.cmo lexer.cmo lispwebrepl.cmo

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
	./$^ < test/inc.lw

clean:
	rm -rf *.cm* lispwebeval lispwebrepl

mrproper: clean
	rm -rf *~
