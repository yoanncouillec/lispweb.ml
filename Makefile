all: bin/lispwebrepl #arithc arithrun arithopt

bin/lispwebrepl: obj/lispweb.cmo obj/parser.cmi obj/parser.cmo obj/lexer.cmo obj/lispwebrepl.cmo
	ocamlc -o $@ str.cma unix.cma obj/lispweb.cmo obj/parser.cmo obj/lexer.cmo obj/lispwebrepl.cmo

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

obj/%.cmi:src/%.ml
	ocamlc -c $^ -o $@

obj/%.cmo:src/%.ml
	ocamlc -c $^ -o $@

test: arithc arithrun arithopt
	./arithc test.source -o test.bytecode
	./arithrun test.bytecode
	./arithopt test.source -o test.s
	as test.s -o test.o
	ld test.o -o test -macosx_version_min 10.7

clean:
	rm -rf *.cm* lispwebeval arithc arithrun arithopt \#*\# *.mli *.bytecode *.s *.o test

mrproper: clean
	rm -rf *~
