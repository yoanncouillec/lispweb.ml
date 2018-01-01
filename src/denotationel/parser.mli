exception Error

type token = 
  | TRUE
  | THROW
  | SET
  | RPAREN
  | RETURNFROM
  | QUOTE
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
  | ER_STRING of (string)
  | ER_INT of (int)
  | ER_IDENT of (string)
  | ER_CHAR_ESC of (string)
  | ER_CHAR of (string)
  | EQUAL
  | EOF
  | DEFINE
  | CONS
  | CDR
  | CATCH
  | CAR
  | CALLCC
  | BLOCK
  | BEGIN


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Expr.expr)