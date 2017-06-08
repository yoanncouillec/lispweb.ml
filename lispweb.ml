type expression = 
  | EInteger of int
  | EIdent of string
  | EString of string
  | EQuote of expression
  | EBoolean of bool
  | EIf of expression * expression * expression
  | ELambda of string * expression
  | EStringAppend of expression * expression
  | EServe of string * expression
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
  | EServe (s, e) ->
     (match eval env e with
     | VClosure (s', e', env') ->
	let server = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
	let address = Unix.inet_addr_of_string "127.0.0.1" in 
	Unix.bind server (Unix.ADDR_INET(address, 8080));
	Unix.listen server 100;
	let (client, _) = Unix.accept server in
	let client_in = Unix.in_channel_of_descr client in
	let client_out = Unix.out_channel_of_descr client in
	(match eval (extend env' s' (VString "Yoann")) e' with
	 | VString s as res ->
	    output_string client_out ("HTTP/1.1 200 OK\n\n<html><body>"
				      ^ s
				      ^ "</body></html>") ; 
	    flush client_out ;
	    Unix.shutdown client Unix.SHUTDOWN_ALL ;
	    res
	 | _ -> failwith "Not a string"))
  | EStringAppend (e1, e2) -> 
     (match (eval env e1, eval env e2) with
      | (VString s1, VString s2) -> VString (s1^s2))
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
