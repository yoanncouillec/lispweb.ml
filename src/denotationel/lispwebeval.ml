open Pretty
open Eval

let rec evalist es genv env denv mem cont = 
  match es with
  | [] -> failwith "evalist: empty"
  | e::[] -> 
     print_endline (string_of_expr e) ;
     eval e genv env denv mem cont
  | e::rest -> 
     print_endline (string_of_expr e) ;
     eval e genv env denv mem
	  (fun _ genv' mem' -> 
	   evalist rest genv' env denv mem'
		   (fun v genv'' mem'' -> 
		    cont v genv'' mem''))
let _ =					 
  let expressions = List.map Eval.expr_of_filename (List.tl (Array.to_list Sys.argv)) in
  evalist expressions [] [] [] []
	  (fun v _ _ -> print_endline (string_of_value v) ; v)
