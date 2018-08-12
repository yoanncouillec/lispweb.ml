exception Error

type token = 
  | TRUE
  | THROW
  | SET
  | RPAREN
  | RETURNFROM
  | PLUS
  | NOT
  | MULT
  | MINUS
  | LPAREN
  | LOAD
  | LIST
  | LETSTAR
  | LETREC
  | LET
  | LAMBDA
  | IF
  | HOSTCALL
  | FALSE
  | EVAL
  | ER_STRING of (string)
  | ER_INT of (int)
  | ER_IDENT of (string)
  | ER_CHAR_ESC of (string)
  | ER_CHAR of (string)
  | EQUAL
  | EOF
  | DEFINE
  | CUNQUOTE
  | CQUOTE
  | CQUASIQUOTE
  | CONS
  | CDR
  | CATCH
  | CAR
  | CALLCC
  | BLOCK
  | BEGIN
  | AND


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Expr.expr)