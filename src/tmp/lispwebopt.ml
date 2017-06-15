let _ = 
  let input_filename = Sys.argv.(1) in
  let output_filename = ref ((Filename.chop_suffix input_filename ".source") ^ 
    ".s") in
  let options = [
    "-o", Arg.Set_string output_filename, "Set output file";
  ] in
    Arg.parse options (fun x -> ()) "Options: ";
    let in_chan = open_in input_filename in
    let out_chan = open_out_bin !output_filename in
    let lexbuf = Lexing.from_channel in_chan in
    let expressions = Parser.start Lexer.token lexbuf in
    output_string out_chan ".globl start\nstart:\n";
    List.iter
      (fun expression ->
        let instructions = Machine.compile expression in
        List.iter 
	  (fun instr -> output_string out_chan (Machine.expansion instr)) 
	  instructions)
      expressions ;
    output_string out_chan "movq $0x2000001,%rax\n";
    output_string out_chan "movq $0,%rdi\n";
    output_string out_chan "syscall\n";
    close_out out_chan
        
