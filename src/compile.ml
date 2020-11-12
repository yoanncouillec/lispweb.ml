open Eval
open Expr

let wrap e =
  CFunction(CtInteger,"main",[],CBegin(e::CReturn(CInt 0)::[]))
  

let _ =
  let execname = List.hd (Array.to_list Sys.argv) in
  let version = "1.0" in
  let help = "Usage: "^execname^" [options] [files]\nOptions:\n  --help Print this message and exit" in 
  let sargs = List.tl (Array.to_list Sys.argv) in
  match expr_of_filename "lisp" (List.hd sargs) with
  | Some (e) ->
     print_endline(string_of_c_expr (wrap (c_expr_of_expr e)))
