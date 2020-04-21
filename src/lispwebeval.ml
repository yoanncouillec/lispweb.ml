open Eval
open Expr
   
let _ =
  let execname = List.hd (Array.to_list Sys.argv) in
  let version = "1.0" in
  let help = "Usage: "^execname^" [options] [files]\nOptions:\n  --help Print this message and exit" in 
  let sargs = List.tl (Array.to_list Sys.argv) in
  let rec expression_of_args accu = function
    | "--help"::rest ->
       expression_of_args ((EHostCall("Pervasives.print_endline",EList([EString(help)])))::accu) rest   
    | "--version"::rest ->
       expression_of_args ((EHostCall("Pervasives.print_endline",EList([EString(version)])))::accu) rest
    | file::rest ->
       expression_of_args ((ELoad (EString(file)))::accu) rest
    | [] -> Expr.EBegin (List.rev accu)
  in
  eval (expression_of_args [] sargs) [] [] [] [] (fun v _ _ -> print_endline (string_of_expr v) ; v)
