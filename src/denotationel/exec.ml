open Pretty
open Eval

let exec expected e = 
  let current = (eval e [] [] []
		      (fun v _ ->  v)) in
  (if expected = current then
     print_string "[OK] "
   else
     print_string ("[FAILED] ")) ;
  print_endline ((string_of_expr e)^" -> "^(string_of_value current)) ;
  (if expected = current then print_string "" else
     (print_endline ("expected: "^(string_of_value expected)) ;
      print_endline ("current: "^(string_of_value current))))
