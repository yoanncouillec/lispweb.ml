build-distrib:
	dune build

build-context-image:
	docker build -t context:latest -f docker/DockerfileContext .

build-hello-image: build-context-image
	docker build --no-cache -t lispwhello:latest -f docker/DockerfileLispweb .

build-repl-image: build-context-image
	docker build --no-cache -t lispwrepl:latest -f docker/DockerfileLispwebRepl .

run-hello-image:
	docker run -e LEVEL=INFO lispwhello

run-repl-image:
	docker run -i lispwrepl

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
