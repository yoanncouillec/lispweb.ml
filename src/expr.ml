type operator = OPlus | OMinus | OMult | ODiv

type clause =
  | EClause of expr * expr
  | EElseClause of expr

and expr =
  | EInt of int
  | EBinary of operator * expr * expr
  | EBool of bool
  | ENot of expr
  | EAnd of expr * expr
  | EChar of char
  | EString of string
  | EQuote of expr
  | EQuasiQuote of expr
  | EUnQuote of expr
  | EVar of string
  | ESet of string * expr
  | EIf of expr * expr * expr
  | ECond of clause list
  | ELet of string * expr * expr
  | EDefine of string * expr
  | EThunk of expr
  | EThunkApp of expr
  | ELambda of string * expr
  | ELambdaDot of string * expr
  | EApp of expr * expr
  | EBegin of expr list
  | ECatch of string * expr
  | EThrow of string * expr
  | EBlock of string * expr
  | EReturnFrom of string * expr
  | ECallcc of string * expr
  | EEqual of expr * expr
  | ECar of expr
  | ECdr of expr
  | ECons of expr * expr
  | EList of expr list
  | EHostCall of string * expr
  | ELoad of expr
  | EEval of expr

let rec string_of_expr = function
  | EInt n -> string_of_int n
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
          | ODiv -> "/"
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
  | EEval e -> "(eval "^(string_of_expr e)^")"
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
