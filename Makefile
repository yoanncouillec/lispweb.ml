build:
	dune build

runtest: clean build
	dune runtest

clean:
	dune clean
