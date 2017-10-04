exception Error

type token = 
  | TRUE
  | TAG
  | STRING_TO_INT
  | STRING_APPEND
  | STRING of (string)
  | SCRIPT
  | RPAREN
  | QUOTE
  | PLUS
  | MULT
  | MINUS
  | LPAREN
  | LISTEN
  | LIST
  | LET
  | LAMBDA
  | INT_TO_STRING
  | INT of (int)
  | IF
  | IDENT of (string)
  | HTML
  | FROM_SERVER
  | FALSE
  | EOF
  | DIV


val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Lispweb.expression)