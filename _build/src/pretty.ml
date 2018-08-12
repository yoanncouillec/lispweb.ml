open Value
open Expr

let rec string_of_value = function
  | VUnit _ -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VString s -> "\"" ^ s ^ "\""
  | VChar c -> "'" ^ (String.make 1 c) ^ "'"
  | VExpr e -> "'" ^ (string_of_expr e)
  | VClosure (_, e)-> "#CLOSURE"^(string_of_expr e)^")"
  | VCont _ -> "#CONT"
  | VList vs ->
     "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_value e)) "" vs)^")"
  | VFile _ -> "#FILE"
  | VInetAddr _ -> "#INETADDR"
  | VSockAddr _ -> "#SOCKADDR"
  | VShutdownCommand _ -> "#SHUTDOWNCOMMAND"
  | VChannelIn _ -> "#INCHANNEL"
  | VChannelOut _ -> "#OUTCHANNEL"

and string_of_expr = function
  | EInt n -> string_of_int n
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool b -> string_of_bool b
  | ENot e -> "(not "^(string_of_expr e)^")"
  | EString s -> "\"" ^ s ^ "\""
  | EChar c -> "'" ^ (String.make 1 c) ^ "'"
  | EQuote e -> "(quote" ^ (string_of_expr e) ^")"
  | EQuasiQuote e -> "(quasiquote" ^ (string_of_expr e) ^")"
  | EUnQuote e -> "(unquote" ^ (string_of_expr e) ^")"
  | EVar s -> s
  | ESet (s, e) -> "(set! "^s^(string_of_expr e)^")"
  | ELoad e -> "(load "^(string_of_expr e)^")"
  | EIf (e1, e2, e3) -> 
     "(if "^(string_of_expr e1)^" "^(string_of_expr e2)^" "^(string_of_expr e3)^")"
  | ELet (s, e, body) ->
    "(let ("^s^" "^(string_of_expr e)^") "^(string_of_expr body)^")"
  | EDefine (s, e) ->
    "(define "^s^" "^(string_of_expr e)^")"
  | ELambda (s, body) ->
     "(lambda ("^s^") "^(string_of_expr body)^")"
  | ELambdaDot (s, body) ->
     "(lambda (. "^s^") "^(string_of_expr body)^")"
  | EThunk (body) ->
     "(lambda () "^(string_of_expr body)^")"
  | EThunkApp e ->
     "("^(string_of_expr e)^")"
  | EApp (e1, e2) ->
     "("^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBegin es -> 
     "(begin"^(List.fold_left (fun acc x -> acc^" "^(string_of_expr x)) "" es)^")"
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
  | EHostCall (s, e) ->  "(hostcall " ^ s ^ " " ^ (string_of_expr e) ^ ")"
