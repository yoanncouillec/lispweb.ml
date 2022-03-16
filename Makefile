build:
	dune build

runtest: clean build
	dune runtest

doc: clean
	dune build
	dune build @doc
	python3 -m http.server --directory _build/default/_doc/_html/

clean:
	dune clean
