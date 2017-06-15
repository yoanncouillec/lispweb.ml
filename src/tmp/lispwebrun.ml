let _ =
  if Array.length Sys.argv != 2 then failwith "Usage: arithrun <file>";
  let input_filename = Sys.argv.(1) in
  let in_chan = open_in input_filename in
  let instructions = ref [] in
    try
      while true
      do
	instructions := Machine.input_instr in_chan :: !instructions
      done
    with End_of_file ->
      begin
	instructions := List.rev !instructions
      end ;
      print_int (Machine.eval ([],!instructions)) ;
      print_newline ()
      
