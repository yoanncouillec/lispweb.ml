type expression = 
  | EInteger of int
  | EIdent of string
  | EString of string
  | EQuote of expression
  | EBoolean of bool
  | EPlus of expression * expression
  | EIf of expression * expression * expression
  | ELambda of string * expression
  | ELet of string * expression * expression
  | EListen of expression
  | EList of expression list
  | ETag of expression * expression list 
  | EStringAppend of expression * expression
  | EStringToInt of expression
  | EIntToString of expression
  | EToHtml of expression
  | EApplication of expression * expression

type environment = (string * value) list

and value = 
  | VInteger of int
  | VString of string
  | VQuote of expression
  | VBoolean of bool
  | VList of value list
  | VTag of string * value list
  | VClosure of string * expression * environment

let rec lookup env s =
  match env with
  | (s',v') :: rest ->
     if s = s' then v' else lookup rest s
  | [] -> failwith "No such binding"

let extend env s v = (s, v) :: env

let rec value_to_html = function
  | VTag (tag, l) ->
     "<" ^ tag ^ ">"
     ^ (List.fold_left (fun acc vt -> (value_to_html vt) ^ acc) "" l)
     ^ "</" ^ tag ^ ">"
  | VString s -> s
  | VList l -> (List.fold_left (fun acc vt -> (value_to_html vt) ^ acc) "" l)
  | _ -> failwith "value_to_html: not implemented"

let rec eval env = function
  | EInteger n -> VInteger n
  | EIdent s -> lookup env s
  | EString s -> VString s
  | EQuote e -> VQuote e
  | EBoolean b -> VBoolean b
  | EPlus (e1, e2) ->
     (match (eval env e1, eval env e2) with
      | (VInteger n1, VInteger n2) -> VInteger (n1 + n2)
      | _ -> failwith "+: Integer expected")
  | EIf (e1, e2, e3) ->
     (match eval env e1 with
      | VBoolean false -> eval env e3
      | _ -> eval env e2)
  | ELambda (s, e) -> VClosure (s, e, env)
  | ELet (s, e1, e2) -> eval (extend env s (eval env e1)) e2
  | EListen e ->
     (match eval env e with
      | VInteger port ->
	 let server = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
	 let address = Unix.inet_addr_of_string "127.0.0.1" in 
	 Unix.bind server (Unix.ADDR_INET(address, port));
	 Unix.listen server 100;
	 let client = fst (Unix.accept server) in
	 let cin = Unix.in_channel_of_descr client in
	 let cout = Unix.out_channel_of_descr client in
	 (match Str.split_delim (Str.regexp " ") (input_line cin) with
	  | cmd::qs::prtcl::[] -> 
	     (match Str.split_delim (Str.regexp "?") qs with
	      | uri::arg::[] ->
		 (match lookup env uri with
		  | VClosure (parameter, body, env') ->
		     (match Str.split_delim (Str.regexp "=") arg with
		      | key::value::[] ->
			 if key = parameter then
			   (match eval (extend env' parameter (VString value)) body with
			    | VString s as res ->
			       output_string cout ("HTTP/1.1 200 OK\n\n" ^ s) ; 
			       flush cout ;
			       Unix.close client ;
			       Unix.close server ;
			       res)
			 else failwith "Query string parameter name is not correct")))))
  | EList l -> VList (List.fold_left (fun acc e -> (eval env e)::acc) [] l)
  | ETag (e1, l) ->
     (match eval env e1 with
      | VString s  -> VTag (s, List.fold_left (fun acc e -> (eval env e) :: acc) [] l)
      | _ -> failwith "tag: expect a string as first argument")
  | EStringAppend (e1, e2) -> 
     (match (eval env e1, eval env e2) with
      | (VString s1, VString s2) -> VString (s1^s2))
  | EStringToInt e ->
     (match eval env e with
      | VString s -> VInteger (int_of_string s)
      | _ -> failwith "String expected")
  | EIntToString e ->
     (match eval env e with
      | VInteger s -> VString (string_of_int s)
      | _ -> failwith "Integer expected")
  | EToHtml e -> VString (value_to_html (eval env e))
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

let rec string_of_value = function
  | VInteger n -> string_of_int n
  | VString s -> "\"" ^ s ^ "\""
  | VQuote e -> "'" ^ (string_of_expression e)
  | VBoolean b -> string_of_bool b
  | VList l -> 
     (List.fold_right (fun v acc -> acc ^ " " ^ (string_of_value v)) l "(list") ^ ")"
  | VTag (s, l) -> 
     (List.fold_right (fun v acc -> acc ^ " " ^ (string_of_value v)) l ("(tag \""^s^"\"")) ^ ")"
  | VClosure (s, e, env) -> "#CLOSURE"
