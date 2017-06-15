type ident = string

type expression = 
  | EInteger of int
  | EIdent of ident
  | EString of string
  | EQuote of expression
  | EBoolean of bool
  | EPlus of expression * expression
  | EIf of expression * expression * expression
  | ELambda of ident * expression
  | ELet of ident * expression * expression
  | EListen of expression
  | EList of expression list
  | ETag of expression * expression * expression list 
  | EStringAppend of expression * expression
  | EStringToInt of expression
  | EIntToString of expression
  | EHtml of expression
  | EScript of expression
  | EFromServer of ident
  | EApplication of expression * expression

type script = 
  | SInteger of int
  | SIdent of string
  | SString of string
  | SBoolean of bool
  | SPlus of script * script
  | SIf of script * script * script
  | SFunction of string * script
  | SVar of string * script
  | SStringAppend of script * script
  | SApplication of string * script
  | SBlock of script list

type environment = (string * value) list

and value = 
  | VInteger of int
  | VString of string
  | VQuote of expression
  | VBoolean of bool
  | VList of value list
  | VTag of string * value * value list (* tagname attributes content *)
  | VClosure of string * expression * environment
  | VScript of script

let rec lookup env s =
  match env with
  | (s',v') :: rest ->
     if s = s' then v' else lookup rest s
  | [] -> failwith "No such binding"

let extend env s v = (s, v) :: env

let rec string_of_expression = function
  | EInteger n -> string_of_int n
  | EIdent s -> s
  | EString s -> "\"" ^ s ^ "\""
  | EQuote e -> "'" ^ (string_of_expression e)
  | EBoolean b -> string_of_bool b
  | EPlus (e1, e2) -> "(+ "^(string_of_expression e1)^(string_of_expression e2)^")"
  | EIf (e1, e2, e3) -> 
     "(if " ^ (string_of_expression e1) 
     ^ " " ^ (string_of_expression e2)
     ^ " " ^ (string_of_expression e3) ^ ")"
  | ELambda (s, e) -> "(lambda (" ^ s ^ ") " ^ (string_of_expression e) ^ ")"
  | ELet (s, e1, e2) -> "(let ("^s^" "^(string_of_expression e1)^") "^(string_of_expression e2)^")"
  | EListen e1 -> "(listen "^(string_of_expression e1)^")"
  | EList l -> "(list"^(List.fold_left (fun acc e -> acc ^ " " ^(string_of_expression e)) "" l)^")"
  | ETag (e, _, l) -> (* TODO *)
     "(tag "^(string_of_expression e)^" "
     ^(List.fold_left (fun acc e -> acc^" "^(string_of_expression e)) "" l)
     ^")"
  | EStringAppend (e1, e2) -> 
     "(string-append "^(string_of_expression e1)^" "^(string_of_expression e2)^")"
  | EStringToInt e -> "(string->int "^(string_of_expression e)^")"
  | EIntToString e -> "(int->string "^(string_of_expression e)^")"
  | EHtml e -> "(html "^(string_of_expression e)^")"
  | EScript e -> "(script "^(string_of_expression e)^")"
  | EFromServer ident -> "(from-server "^ident^")"
  | EApplication (e1, e2) -> 
     "(" ^ (string_of_expression e1) ^ " " ^ (string_of_expression e2) ^ ")"

and string_of_value = function
  | VInteger n -> string_of_int n
  | VString s -> "\"" ^ s ^ "\""
  | VQuote e -> "'" ^ (string_of_expression e)
  | VBoolean b -> string_of_bool b
  | VList l -> 
     (List.fold_left (fun acc v -> acc ^ " " ^ (string_of_value v)) "(list" l) ^ ")"
  | VTag (s, _, l) -> (* TODO *)
     (List.fold_left (fun acc v -> acc ^ " " ^ (string_of_value v)) ("(tag \""^s^"\"") l) ^ ")"
  | VClosure (s, e, env) -> "#CLOSURE"
  | VScript e -> "(script "^(string_of_script e)^")"

and string_of_script = function
  | SInteger (n) -> string_of_int n
  | SIdent (s) -> s
  | SString (s) -> "\"" ^ s ^ "\""
  | SBoolean (true) -> "true"
  | SBoolean (false) -> "false"
  | SPlus (e1, e2) -> "(" ^ "(" ^ (string_of_script e1) ^ ")" ^ "+"
		      ^ "(" ^ (string_of_script e2) ^ ")" ^ ")"
  | SIf (e1, e2, e3) -> "if (" ^ (string_of_script e1) ^ "){"
			^ (string_of_script e2) ^ "} else {"
			^ (string_of_script e3) ^ "}"
  | SFunction (s, e1) -> "function("^s^"){"^(string_of_script e1)^"}"
  | SStringAppend (e1, e2) -> (string_of_script e1)^".concat("^(string_of_script e2)^")"
  | SVar (s, e1) -> "var "^s^" = "^(string_of_script e1)^""
  | SApplication (s, e1) -> s^"("^(string_of_script e1)^")"
  | SBlock(l) -> (List.fold_left (fun acc e -> acc ^ (string_of_script e)^";") "{" l) ^"}"

let rec script_of_value = function
  | VInteger n -> SInteger n
  | VString s -> SString s
  | VQuote _ -> failwith "script_of_value: cannot compile value of type VQuote to script"
  | VBoolean b -> SBoolean b
  | VList _ -> failwith "script_of_value: cannot compile value of type VList to script. will be compiled to array in further version"
  | VTag (_,_,_) -> failwith "script_of_value: cannot compile value of type VTag to script"
  | VClosure (s, e, env) -> failwith "script_of_value: cannot compile value of type VClosure to script. will be compiled to ScriptValueClosure in further version. need a compiler from value to script_value. then need to define script_value"
  | VScript s -> failwith "script_of_value: cannot compile value of type VScript to script"

let rec script_of_expression env = function
  | EInteger (n) -> SInteger (n)
  | EIdent (s) -> SIdent (s)
  | EString (s) -> SString (s)
  | EBoolean (b) -> SBoolean (b)
  | EPlus (a,b) -> SPlus (script_of_expression env a,script_of_expression env b)
  | EIf (a,b,c) -> SIf (script_of_expression env a, 
			script_of_expression env b, 
			script_of_expression env c)
  | ELambda (s,body) -> SFunction(s,script_of_expression env body)
  | ELet (s, e1, e2) -> SBlock ([SVar (s, script_of_expression env e1);
				script_of_expression env e2])
  | EStringAppend (e1, e2) -> SStringAppend (script_of_expression env e1,
					     script_of_expression env e2)
  | EApplication (e1, e2) ->
     (match e1 with
      | EIdent s -> SApplication (s, script_of_expression env e2)
      | _ -> failwith "script_of_expression: call expects an identifer at functional position")
  | EFromServer ident -> script_of_value (lookup env ident)
  | _ -> failwith "script_of_expression: cannot compile"
	       
let rec value_to_html = function
  | VTag (tag, VList attrs, l) ->
     "<" ^ tag 
     ^ (List.fold_left 
	  (fun acc attr ->
	   (print_endline (string_of_value attr));
	   (match attr with
	    | VList((VString attrname)::attrvalue::[]) -> acc ^ " " ^ attrname ^ "='"^(value_to_html attrvalue)^"' "
	    | _ -> failwith "value_to_html VTag: attribute is not a couple")) 
	  "" 
	  attrs)
     ^ ">"
     ^ (List.fold_left (fun acc vt -> acc ^ (value_to_html vt)) "" l)
     ^ "</" ^ tag ^ ">"
  | VString s -> s
  | VScript e -> (string_of_script e)
  | VList l -> (List.fold_left (fun acc vt -> acc ^ (value_to_html vt)) "" l)
  | _ -> failwith "value_to_html: not implemented" (* TODO *)

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
			       res
			    | _ -> failwith "eval EListen: expects a string for query string parameter value")
			 else failwith "eval EListen: query string parameter name does not match argument name of called service"
		      | _ -> failwith "eval EListen: query string parameter is malformed, should be one key=value")
		  | _ -> failwith "eval EListen: uri does not match any function in the execution environment")
	      | _ -> failwith "eval EListen: query string does not contain parameter, it is mandatory in this semantic")
	  | _ -> failwith "eval EListen: http command line is malformed, should be:  <command> <query_string> <protocol>, ex: GET /hello?name=Alan  HTTP/1.1")
      | _ -> failwith "eval EListen: port should be of type integer")
  | EList l -> VList (List.fold_left (fun acc e -> acc@[(eval env e)]) [] l)
  | ETag (tag, attributes, expressions) ->
     (match eval env tag with
      | VString s  -> 
	 VTag (s, 
	       eval env attributes,
	       List.fold_left
		 (fun acc e -> acc@[(eval env e)]) [] expressions)
      | _ -> failwith "tag: expect a string as first argument")
  | EStringAppend (e1, e2) -> 
     (match (eval env e1, eval env e2) with
      | (VString s1, VString s2) -> VString (s1^s2)
      | _ -> failwith "eval EStringAppend: arguments should be evaluated to strings")
  | EStringToInt e ->
     (match eval env e with
      | VString s -> VInteger (int_of_string s)
      | _ -> failwith "String expected")
  | EIntToString e ->
     (match eval env e with
      | VInteger s -> VString (string_of_int s)
      | _ -> failwith "Integer expected")
  | EHtml e -> VString ("<html>"^(value_to_html (eval env e))^"</html>")
  | EScript e -> VScript (script_of_expression env e)
  | EFromServer _ -> failwith "eval EFromServer: cannot be executed on server. should be executed on client"
  | EApplication (e1, e2) -> 
     (match eval env e1 with
      | VClosure (s', e', env') ->
	 let arg = eval env e2 in
	 eval (extend env' s' arg) e'
      | _ -> failwith "Not a closure")

