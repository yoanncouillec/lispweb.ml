open Expr
   
let _ =
  let execname = List.hd (Array.to_list Sys.argv) in
  let version = "1.0" in
  let help = "Usage: "^execname^" [options] [files]\nOptions:\n  --help Print this message and exit" in 
  let sargs = List.tl (Array.to_list Sys.argv) in
  let from_syntax = EDefine ("--from-syntax", EString ("lisp")) in
  let rec expr_of_args accu args =
    match args with
    | "--load"::filename::rest ->
       expr_of_args (ELoad (EVar("--from-syntax"), (EString(filename)))::accu) rest
    | "--load"::[] ->
       failwith "expr_of_args"
    | "--version"::rest ->
       expr_of_args ((EHostCall("Pervasives.print_endline",EList([EString(version)])))::accu) rest
    | "--help"::rest ->
       expr_of_args ((EHostCall("Pervasives.print_endline",EList([EString(help)])))::accu) rest
    | key::rest ->
       (match (String.get key 0, String.get key 1,rest) with
        | ('-','-',value::rest') ->
           expr_of_args (EDefine (key, EString (value))::accu) rest'
        | ('-','l',rest') ->
           expr_of_args (ELoad(EString("lisp"),EString("lib/"^(String.sub key 2 ((String.length key) - 2))^".scm"))::accu) rest'
        | _ -> failwith "evaluate: wrong syntax")
    | [] -> Expr.EBegin (List.rev accu)
  in
  let e = (expr_of_args [from_syntax] sargs) in
  print_endline(string_of_expr e);
  Eval.eval e [] [] [] []
    (fun v _ _ -> print_endline (string_of_expr v) ; v)
