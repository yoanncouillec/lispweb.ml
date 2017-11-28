exception Error

type token = 
  | TRUE
  | THROW
  | SET
  | RPAREN
  | RETURNFROM
  | QUOTE
  | PLUS
  | MULT
  | MINUS
  | LPAREN
  | LIST
  | LETREC
  | LET
  | LAMBDA
  | IF
  | FALSE
  | ER_STRING of (string)
  | ER_INT of (int)
  | ER_IDENT of (string)
  | EQUAL
  | EOF
  | CONS
  | CDR
  | CATCH
  | CAR
  | CALLCC
  | BLOCK
  | BEGIN


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Expr.expr)