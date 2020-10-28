open Eval
open Expr
   
let _ =
  let execname = List.hd (Array.to_list Sys.argv) in
  let version = "1.0" in
  let help = "Usage: "^execname^" [options] [files]\nOptions:\n  --help Print this message and exit" in 
  let sargs = List.tl (Array.to_list Sys.argv) in
  let rec expr_of_args accu = function
    | "--file"::filename::rest ->
       expr_of_args (ELoad (EString(filename,None),None)::accu) rest
    | "--file"::[] ->
       failwith "expr_of_args"
    | "--version"::rest ->
       expr_of_args ((EHostCall("Pervasives.print_endline",EList([EString(version,None)],None),None))::accu) rest
    | "--help"::rest ->
       expr_of_args ((EHostCall("Pervasives.print_endline",EList([EString(help,None)],None),None))::accu) rest
    | key::value::rest when String.length key > 2 && String.get key 0 = '-' && String.get key 1 = '-' ->
       expr_of_args (EDefine (key, EString (value, None), None)::accu) rest
    | [] -> Expr.EBegin (List.rev accu,None)
    | _ ->
       failwith "expr_of_args"
  in
  eval (expr_of_args [] sargs) [] [] [] []
    (fun v _ _ -> print_endline (string_of_expr v) ; v)

