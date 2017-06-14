{
  open Parser
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ''' { QUOTE }
  | '"' { DQUOTE }
  | '+' { PLUS }   
  | "#t" { TRUE }
  | "#f" { FALSE }
  | "if" { IF }
  | "lambda" { LAMBDA }
  | "let" { LET }
  | "listen" { LISTEN }
  | "list" { LIST }
  | "tag" { TAG }
  | "string-append" { STRING_APPEND }
  | "string->int" { STRING_TO_INT }
  | "int->string" { INT_TO_STRING }
  | "html" { HTML }
  | "script" { SCRIPT }
  | "from-server" { FROM_SERVER }
  | ['0'-'9']+ { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['a'-'z''/']+ { IDENT (Lexing.lexeme lexbuf) }
