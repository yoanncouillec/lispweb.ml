{
  open Parser
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ''' { QUOTE }
  | "equal?" { EQUAL }
  | "#t" { TRUE }
  | "#f" { FALSE }
  | "if" { IF }
  | "lambda" { LAMBDA }
  | "let" { LET }
  | "letrec" { LETREC }
  | "set!" { SET }
  | "list" { LIST }
  | "car" { CAR }
  | "cdr" { CDR }
  | "cons" { CONS }
  | "begin" { BEGIN }
  | "throw" { THROW }  
  | "catch" { CATCH }  
  | "block" { BLOCK }  
  | "return-from" { RETURNFROM }  
  | "call/cc" { CALLCC }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { MULT }
  | '\"' ('\\'* | [^'\"'])* '\"' { ER_STRING (Lexing.lexeme lexbuf) }
  | ['0'-'9']+ { ER_INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''a'-'z''+''-''*''/''#''-''@''{'']''*''&''%''$''!''.''?']+ { ER_IDENT (Lexing.lexeme lexbuf) }