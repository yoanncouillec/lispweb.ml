type expression = 
  | EInteger of int
  | EIdent of string
  | EString of string
  | EQuote of expression
  | EBoolean of bool
  | EIf of expression * expression * expression
  | ELambda of string * expression
  | EApplication of expression * expression

type environment = (string * value) list
and value = 
  | VInteger of int
  | VString of string
  | VQuote of expression
  | VBoolean of bool
  | VClosure of string * expression * environment

let rec lookup env s =
  match env with
  | (s',v') :: rest ->
     if s = s' then v' else lookup rest s
  | [] -> failwith "No such binding"

let extend env s v = (s, v) :: env

let rec eval env = function
  | EInteger n -> VInteger n
  | EIdent s -> lookup env s
  | EString s -> VString s
  | EQuote e -> VQuote e
  | EBoolean b -> VBoolean b
  | EIf (e1, e2, e3) ->
     (match eval env e1 with
      | VBoolean false -> eval env e3
      | _ -> eval env e2)
  | ELambda (s, e) -> VClosure (s, e, env)
  | EApplication (e1, e2) -> 
     match eval env e1 with
     | VClosure (s', e', env') ->
	let arg = eval env e2 in
	eval (extend env' s' arg) e'
     | _ -> failwith "Not a closure"

let rec string_of_expression = function
  | EInteger n -> string_of_int n
  | EIdent s -> s
  | EString s -> "\"" ^ s ^ "\""
  | EQuote e -> "'" ^ (string_of_expression e)
  | EBoolean b -> string_of_bool b
  | EIf (e1, e2, e3) -> 
     "(if " ^ (string_of_expression e1) 
     ^ " " ^ (string_of_expression e2)
     ^ " " ^ (string_of_expression e3) ^ ")"
  | ELambda (s, e) -> "(lambda (" ^ s ^ ") " ^ (string_of_expression e) ^ ")"
  | EApplication (e1, e2) -> 
     "(" ^ (string_of_expression e1) ^ " " ^ (string_of_expression e2) ^ ")"

let string_of_value = function
  | VInteger n -> string_of_int n
  | VString s -> "\"" ^ s ^ "\""
  | VQuote e -> "'" ^ (string_of_expression e)
  | VBoolean b -> string_of_bool b
  | VClosure (s, e, env) -> "#CLOSURE"
