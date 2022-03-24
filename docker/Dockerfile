FROM ubuntu
WORKDIR /app
COPY . ./
RUN apt update -y
RUN apt install make -y
RUN apt install ocaml -y
RUN apt install opam -y
RUN opam init -y
RUN opam install dune
RUN make
ENTRYPOINT [""]

