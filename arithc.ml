let _ = 
  let input_filename = Sys.argv.(1) in
  let output_filename = ref ((Filename.chop_suffix input_filename ".source") ^ 
    ".bytecode") in
  let options = [
    "-o", Arg.Set_string output_filename, "Set output file";
  ] in
    Arg.parse options (fun x -> ()) "Options: ";
    let in_chan = open_in input_filename in
    let out_chan = open_out_bin !output_filename in
    let lexbuf = Lexing.from_channel in_chan in
    let expressions = Parser.start Lexer.token lexbuf in
    List.iter
      (fun expression ->
        let instructions = Machine.compile expression in
        List.iter (Machine.output_instr out_chan) instructions)
      expressions ;
    close_out out_chan
      
