let rec string_of_channel channel accu = 
  try
    let line = input_line channel in
    string_of_channel channel (accu^line)
  with
  | End_of_file -> accu

let expr_of_scheme_string s = 
  let lexbuf = Lexing.from_string s in
  Parser.start Lexer.token lexbuf
  
let print_position out_channel (lexbuf:Lexing.lexbuf) =
  let pos = lexbuf.lex_curr_p in
  Printf.fprintf out_channel "%s:%d:%d" 
    pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
  
let parse_with_error language lexbuf =
  match language with
    | "lisp" -> 
       (try Parser.start Lexer.token lexbuf with
          Lexer.SyntaxError msg ->
           Printf.fprintf stderr "%a: %s\n" print_position lexbuf msg; None
        | Parser.Error -> 
           Printf.fprintf stderr "%a: syntax error\n" print_position lexbuf; None)
    | "js" -> 
       (try ParserJs.start LexerJs.token lexbuf with
          LexerJs.SyntaxError msg ->
           Printf.fprintf stderr "%a: %s\n" print_position lexbuf msg; None
        | ParserJs.Error -> 
           Printf.fprintf stderr "%a: syntax error\n" print_position lexbuf; None)
    | _ -> failwith "unknown language"
     
let rec parse_and_print language lexbuf =
  match parse_with_error language lexbuf with
  | Some _ -> parse_and_print language lexbuf
  | None -> ()
  
let expr_of_filename language filename : Expr.expr option =
  let lexbuf = Lexing.from_string (string_of_channel (open_in filename) "") in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_with_error language lexbuf

let expr_of_filename_no_opt filename : Expr.expr =
  match expr_of_filename "lisp" filename with
  | None -> failwith "cannot parse"
  | Some e -> e

