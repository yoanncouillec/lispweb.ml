open Pretty
open Eval
open Expr
   
let _ =
  let version = "1.0" in
  let sargs = List.tl (Array.to_list Sys.argv) in
  let rec expression_of_args accu = function
    | "--version"::rest ->
       expression_of_args ((EHostCall("Pervasives.print_endline",EList([EString(version)])))::accu) rest
    | file::rest ->
       expression_of_args ((ELoad (EString(file)))::accu) rest
    | [] -> Expr.EBegin (List.rev accu)
  in
  eval (expression_of_args [] sargs) [] [] [] [] (fun v _ _ -> print_endline (string_of_value v) ; v)
