open Pretty
open Eval

let _ =					 
  let expressions = 
    List.map Eval.expr_of_filename 
      ("lib/load.scm"::(List.tl (Array.to_list Sys.argv))) in
  eval (Expr.EBegin expressions) [] [] [] []
	  (fun v _ _ -> print_endline (string_of_value v) ; v)
