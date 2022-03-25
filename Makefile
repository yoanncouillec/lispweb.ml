build:
	dune build

build-images: build-ocaml-image build-lispweb-image

build-ocaml-image:
	docker build -t context:latest -f docker/DockerfileContext .

build-lispweb-image:
	docker build --no-cache -t lispw:latest -f docker/DockerfileLispweb .

run-image:
	docker run -e LEVEL=INFO lispw

test-release:
	dune runtest

welcome:
	LISPW_LIB_DIR=/usr/lib/lispw/ LEVEL=INFO rlwrap lispw --load scm/examples/hello.scm

repl:
	LISPW_LIB_DIR=/usr/lib/lispw/ rlwrap lispw --load scm/examples/repl.scm

doc: clean
	dune build
	dune build @doc
	python3 -m http.server --directory _build/default/_doc/_html/

install:
	mkdir /usr/lib/lispw
	cp -R ./scm/lib/* /usr/lib/lispw
	cp ./_build/default/bin/lispwebevaluate.exe /usr/bin/lispw
#echo "You should consider adding: echo 'export LISPW_LIB_DIR=/usr/lib/lispw/' > ~/.profile"

uninstall:
	rm -r /usr/lib/lispw
	rm /usr/bin/lispw

clean:
	dune clean
