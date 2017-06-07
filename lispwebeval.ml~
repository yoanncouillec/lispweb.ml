let _ = 
  print_endline "        Arith version 1.0";
  try
    while true do
      print_string "\n# " ; 
      flush stdout ;
      let lexbuf = Lexing.from_string (read_line ()) in
      try
        let expressions = Parser.start Lexer.token lexbuf in
        try
          List.iter
            (fun expression ->
              let instructions = Machine.compile expression in
              let result = Machine.eval ([], instructions) in
              print_string "= " ; print_int result ; print_newline ())
            expressions
        with
      | Machine.Div_by_zero -> print_endline "! Division by 0"
      with 
      | Failure m -> print_string "! " ; print_endline m
      | Parsing.Parse_error -> print_endline "! Parse error"
    done
  with End_of_file ->
    print_newline()
