open Deno

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
    print_string (string_of_expr expression) ; print_newline () ;
    (* let tags = ["head";"body";"div";"span";"form";"input";"button"] in *)
    (* let env = List.fold_left (fun env tag -> extend env tag (parse env ("(lambda (l"^tag^") (tag \""^tag^"\" l"^tag^"))"))) env tags in *)
    (* let env = populate_env env [("id","(lambda (x) x)"); *)
    (* 				("idd","(lambda (x) (id x))")] in *)
    let value = eval expression [] [] [] (fun x _ -> x) in
    print_string (string_of_value value) ; print_newline ()
  with 
  | Failure m -> print_string "! " ; print_endline m
  | Parsing.Parse_error -> print_endline "! Parse error"
