exception Error

type token = 
  | TRUE
  | THROW
  | RPAREN
  | LPAREN
  | LIST
  | LET
  | LAMBDA
  | IF
  | FALSE
  | ER_INT of (int)
  | ER_IDENT of (string)
  | EQUAL
  | EOF
  | CONS
  | CDR
  | CATCH
  | CAR
  | BEGIN


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Deno.expr)