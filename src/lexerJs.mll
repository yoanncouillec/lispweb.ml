{
  open ParserJs

  exception SyntaxError of string

  let next_line (lexbuf:Lexing.lexbuf) =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = lexbuf.lex_curr_pos;
                 pos_lnum = pos.pos_lnum + 1
      }

}
rule token = parse
  | [' ' '\t'] { token lexbuf }
  | ['\n'] { next_line lexbuf; token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | "," { COMMA }
  | "." { DOT }
  | "true" { TRUE }
  | "false" { FALSE }
  | "if" { IF }
  | "else" { ELSE }
  | "=>" { ARROW }
  | "let" { LET }
  | "var" { VAR }
  | "=" { ASSIGNMENT }
  | "!" { NOT }
  | "&&" { AND }
  | "{" { LCBRACKET }
  | "{" { RCBRACKET }	
  | "throw" { THROW }
  | "try" { TRY }		
  | "catch" { CATCH }  
  | "hostcall" { HOSTCALL }
  | "eval" { EVAL }
  | "load-string" { LOAD_STRING }
  | "load" { LOAD }
  | "call-with-new-thread" { CALLWITHNEWTHREAD }
  | "get-env" { GET }
  | "start-with" { STARTWITH }
  | "scheme->js" { SCHEMETOJS }
  | "js->string" { JSTOSTRING }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { MULT }
  | "/" { DIV }
  | ''' ['A'-'Z''a'-'z''0'-'9'' '':''=''&''?'] ''' { ER_CHAR (Lexing.lexeme lexbuf) }
  | ''' '\\'['A'-'Z''a'-'z''0'-'9'' '] ''' { ER_CHAR_ESC (Lexing.lexeme lexbuf) }
  | '\"' (('\\' _) | [^'\"'])* '\"' { ER_STRING (Lexing.lexeme lexbuf) }
  | ['0'-'9']+ { ER_INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''a'-'z''<''/''-''$']['A'-'Z''a'-'z''-''*''/''#''-''@''{'']''*''&''%''$''!''?''_''0'-'9''>''.']* { ER_IDENT (Lexing.lexeme lexbuf) }
  | [':']['A'-'Z''a'-'z''+''-''*''/''#''-''@''{'']''*''&''%''$''!''?''_''0'-'9''>''.']* { ER_IDENT_OPT (Lexing.lexeme lexbuf) }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof { EOF }
