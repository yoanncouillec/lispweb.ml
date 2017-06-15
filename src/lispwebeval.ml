open Lispweb

let rec string_of_channel channel accu = 
  try
    let line = input_line channel in
    string_of_channel channel (accu^line)
  with
  | End_of_file -> accu

let _ = 
  let lexbuf = Lexing.from_string (string_of_channel stdin "") in
  try
    let expression = Parser.start Lexer.token lexbuf in
    let env = [] in
    let env = List.fold_left (fun env tag -> extend env tag (VClosure ("l"^tag, ETag (EString tag, [EIdent ("l"^tag)]), env))) env ["head";"body";"div";"span";"form";"input"] in
    let value = eval env expression in
    print_string (string_of_value value) ; print_newline ()
  with 
  | Failure m -> print_string "! " ; print_endline m
  | Parsing.Parse_error -> print_endline "! Parse error"
