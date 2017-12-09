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
  | "let*" { LETSTAR }
  | "define" { DEFINE }
  | "letrec" { LETREC }
  | "set!" { SET }
  | "list" { LIST }
  | "car" { CAR }
  | "cdr" { CDR }
  | "cons" { CONS }
  | "not" { NOT }
  | "begin" { BEGIN }
  | "throw" { THROW }  
  | "catch" { CATCH }  
  | "block" { BLOCK }  
  | "return-from" { RETURNFROM }  
  | "call/cc" { CALLCC }
  | "hostcall" { HOSTCALL }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { MULT }
  | ''' ['A'-'Z''a'-'z''0'-'9'] ''' { ER_CHAR (Lexing.lexeme lexbuf) }
  | '\"' ('\\'* | [^'\"'])* '\"' { ER_STRING (Lexing.lexeme lexbuf) }
  | ['0'-'9']+ { ER_INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''a'-'z']['A'-'Z''a'-'z''+''-''*''/''#''-''@''{'']''*''&''%''$''!''.''?''_''0'-'9''>']* { ER_IDENT (Lexing.lexeme lexbuf) }
