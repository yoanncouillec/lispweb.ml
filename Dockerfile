FROM ubuntu:latest
RUN apt update
RUN apt install -y opam
RUN opam ini --disable-sandboxing
RUN eval `opam env`
RUN opam switch create ocaml-base-compiler.4.08.1
RUN eval `opam env`
RUN which ocaml
RUN ocaml -version
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y libssl-dev pkg-config
RUN apt install -y libcurl4-gnutls-dev
RUN opam install -y core
RUN opam install -y ANSITerminal
RUN opam install -y ocurl
RUN opam install -y ssl
RUN opam install -y ISO8601
RUN apt install -y menhir
RUN apt install -y ocamlbuild
RUN opam install -y ocamlfind
ENV PATH="/root/.opam/ocaml-base-compiler.4.08.1/bin:${PATH}"
ENV OPAM_SWITCH_PREFIX='/root/.opam/ocaml-base-compiler.4.08.1'
ENV CAML_LD_LIBRARY_PATH='/root/.opam/ocaml-base-compiler.4.08.1/lib/stublibs:/root/.opam/ocaml-base-compiler.4.08.1/lib/ocaml/stublibs:/root/.opam/ocaml-base-compiler.4.08.1/lib/ocaml'
ENV OCAML_TOPLEVEL_PATH='/root/.opam/ocaml-base-compiler.4.08.1/lib/toplevel'
ENV MANPATH=':/root/.opam/ocaml-base-compiler.4.08.1/man'
