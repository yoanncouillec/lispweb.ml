{
  open Parser
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | "equal?" { EQUAL }
  | "#t" { TRUE }
  | "#f" { FALSE }
  | "if" { IF }
  | "lambda" { LAMBDA }
  | "let" { LET }
  | "list" { LIST }
  | "car" { CAR }
  | "cdr" { CDR }
  | "cons" { CONS }
  | "begin" { BEGIN }
  | "throw" { THROW }  
  | "catch" { CATCH }  
  | ['0'-'9']+ { ER_INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''a'-'z''+''-''*''/''#''-''@''{'']''*''&''%''$''!''.''?']+ { ER_IDENT (Lexing.lexeme lexbuf) }
