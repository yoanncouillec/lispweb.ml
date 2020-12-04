{
  open ParserOpt
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '-' '-' ['A'-'Z''a'-'z']['A'-'Z''a'-'z''-''_''0'-'9']* { ER_OPT (Lexing.lexeme lexbuf) }
  | ['A'-'Z''a'-'z']['A'-'Z''a'-'z''-''_''0'-'9']* { ER_ARG (Lexing.lexeme lexbuf) }
