open Eval
open Expr

let wrap e =
  CFunction(CtInteger,"main",[],CBegin(e::CReturn(CInt 0)::[]))
  
let _ =
  let sargs = List.tl (Array.to_list Sys.argv) in
  match Parse.expr_of_filename "lisp" (List.hd sargs) with
  | Some (e) ->
     print_endline(string_of_c_expr (wrap (c_expr_of_expr e)))
  | None ->
     failwith ("Cannot parse "^(List.hd sargs))
