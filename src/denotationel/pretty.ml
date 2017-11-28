open Value
open Expr

let string_of_vhost = function
  | VFile _ -> "#FILE"

let rec string_of_value = function
  | VUnit -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VString s -> "\"" ^ s ^ "\""
  | VQuote e -> "'" ^ (string_of_expr e)
  | VClosure (_, s, body)-> "#CLOSURE (lambda("^s^") "^(string_of_expr body)^")"
  | VCont _ -> "#CONT"
  | VList vs ->
     "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_value e)) "" vs)^")"
  | VHost vh -> string_of_vhost vh

and string_of_expr = function
  | EInt n -> string_of_int n
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool b -> string_of_bool b
  | EString s -> "\"" ^ s ^ "\""
  | EQuote e -> "'" ^ (string_of_expr e)
  | EVar s -> s
  | ESet (s, e) -> "(set! "^s^(string_of_expr e)^")"
  | EIf (e1, e2, e3) -> 
     "(if "^(string_of_expr e1)^" "^(string_of_expr e2)^" "^(string_of_expr e3)^")"
  | ELet (s, e, body) ->
    "(let ("^s^" "^(string_of_expr e)^") "^(string_of_expr body)^")"
  | ELambda (s, body) ->
     "(lambda ("^s^") "^(string_of_expr body)^")"
  | EApp (e1, e2) ->
     "("^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBegin es -> 
     "(begin "^(List.fold_left (fun acc x -> acc^" "^(string_of_expr x)) "" es)^")"
  | ECatch (s, e) ->
     "(catch ("^s^") "^(string_of_expr e)^")"
  | EThrow (s, e) ->
     "(throw ("^s^") "^(string_of_expr e)^")"
  | EBlock (s, e) ->
     "(block ("^s^") "^(string_of_expr e)^")"
  | EReturnFrom (s, e) ->
     "(return-from ("^s^") "^(string_of_expr e)^")"
  | EEqual (e1, e2) ->
     "(equal? "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EList es -> "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_expr e)) "" es)^")"
  | ECar e -> "(car "^(string_of_expr e)^")"
  | ECdr e -> "(cdr "^(string_of_expr e)^")"
  | ECons (e1,e2) -> "(cons "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECallcc (s, e) -> "(call/cc "^s^" "^(string_of_expr e)^")"
  | EHostCall (s, e) ->  "(hostcall" ^ s ^ " " ^ (string_of_expr e) ^ ")"