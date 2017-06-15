all: lispwebeval

lispwebeval: lispweb.cmo parser.cmi parser.cmo lexer.cmo lispwebeval.cmo
	ocamlc -o $@ str.cma unix.cma lispweb.cmo parser.cmo lexer.cmo lispwebeval.cmo

lispwebrepl: lispweb.cmo parser.cmi parser.cmo lexer.cmo lispwebrepl.cmo
	ocamlc -o $@ str.cma unix.cma lispweb.cmo parser.cmo lexer.cmo lispwebrepl.cmo

arithc: lispweb.cmo parser.cmi parser.cmo lexer.cmo arithc.cmo
	ocamlc -o $@ lispweb.cmo parser.cmo lexer.cmo arithc.cmo

arithrun: lispweb.cmo arithrun.cmo
	ocamlc -o $@ lispweb.cmo arithrun.cmo

arithopt: lispweb.cmo parser.cmi parser.cmo lexer.cmo arithopt.cmo
	ocamlc -o $@ lispweb.cmo parser.cmo lexer.cmo arithopt.cmo

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

test: arithc arithrun arithopt
	./arithc test.source -o test.bytecode
	./arithrun test.bytecode
	./arithopt test.source -o test.s
	as test.s -o test.o
	ld test.o -o test -macosx_version_min 10.7

clean:
	rm -rf *.cm* lispwebeval lispwebrepl \#*\# *.mli *.bytecode *.s *.o test

mrproper: clean
	rm -rf *~
