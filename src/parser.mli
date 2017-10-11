exception Error

type token = 
  | TRUE
  | TAG
  | STRING_TO_INT
  | STRING_APPEND
  | SCRIPT
  | RPAREN
  | QUOTE
  | PLUS
  | MULT
  | MINUS
  | MAKE_STRING
  | LPAREN
  | LISTEN
  | LIST
  | LET
  | LAMBDA
  | INT_TO_STRING
  | IF
  | HTML
  | HOSTCALL
  | FROM_SERVER
  | FALSE
  | ER_STRING of (string)
  | ER_INT of (int)
  | ER_IDENT of (string)
  | EQUAL
  | EOF
  | DYNAMIC_LET
  | DYNAMIC
  | DIV
  | BEGIN


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Lispweb.expression)