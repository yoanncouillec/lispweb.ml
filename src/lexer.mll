{
  open Parser
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ''' { QUOTE }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { MULT }
  | '/' { DIV }
  | "equal?" { EQUAL }
  | "#t" { TRUE }
  | "#f" { FALSE }
  | "if" { IF }
  | "lambda" { LAMBDA }
  | "let" { LET }
  | "dyn-let" { DYNAMIC_LET }
  | "dyn" { DYNAMIC }
  | "dyn-set!" { DYNAMIC_SET }
  | "listen" { LISTEN }
  | "list" { LIST }
  | "tag" { TAG }
  | "begin" { BEGIN }
  | "string-append" { STRING_APPEND }
  | "string->int" { STRING_TO_INT }
  | "int->string" { INT_TO_STRING }
  | "html" { HTML }
  | "script" { SCRIPT }
  | "from-server" { FROM_SERVER }
  | "hostcall" { HOSTCALL }
  | "make-string" { MAKE_STRING }
  | '\"' ('\\'* | [^'\"'])* '\"' { ER_STRING (Lexing.lexeme lexbuf) }
  | ['0'-'9']+ { ER_INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''a'-'z''+''-''*''/''#''-''@''{'']''*''&''%''$''!''.']+ { ER_IDENT (Lexing.lexeme lexbuf) }
