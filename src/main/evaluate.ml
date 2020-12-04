open Expr

let read_file filename = 
  let lines = ref [] in
  let chan = open_in filename in
  try
    while true; do
      lines := input_line chan :: !lines
    done; !lines
  with End_of_file ->
    close_in chan;
    List.rev !lines ;;

let string_of_uri uri = 
    try let connection = Curl.init () and write_buff = Buffer.create 1763 in
        Curl.set_writefunction connection
                (fun x -> Buffer.add_string write_buff x; String.length x);
        Curl.set_url connection uri;
        Curl.perform connection;
        Curl.global_cleanup ();
        Buffer.contents write_buff;
    with _ -> failwith "string_of_uri error"

let _ =
  let execname = List.hd (Array.to_list Sys.argv) in
  let version = "1.0" in
  let help = "Usage: "^execname^" [options] [files]\nOptions:\n  --help Print this message and exit" in 
  let sargs = List.tl (Array.to_list Sys.argv) in
  let from_syntax = EDefine ("--from-syntax", EString ("lisp")) in
  let load_lib_uri = "" in
  let load_lib_ast = EEval (ELoadString (EString (string_of_uri load_lib_uri))) in
  let rec expr_of_args accu args =
    match args with
    | "--load"::filename::rest ->
       expr_of_args (EApp ((EVar "load-file"), [EString(filename)],[])::accu) rest
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
