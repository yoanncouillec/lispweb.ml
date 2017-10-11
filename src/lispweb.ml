type ident = string

type operator =
  | OPlus
  | OMinus
  | OMult
  | ODiv

type expression = 
  | EInteger of int
  | EIdent of ident
  | EString of string
  | EMakeString of expression
  | EQuote of expression
  | EBoolean of bool
  | EBinary of operator * expression * expression
  | EIf of expression * expression * expression
  | ELambda of ident list * expression
  | ELet of (ident * expression) list * expression
  | EDynamicLet of (ident * expression) list * expression
  | EDynamic of ident
  | EDynamicSet of ident * expression
  | EListen of expression
  | EList of expression list
  | EEqual of expression * expression
  | EBegin of expression list
  | ETag of expression * expression * expression list 
  | EStringAppend of expression * expression
  | EStringToInt of expression
  | EIntToString of expression
  | EHtml of expression
  | EScript of expression
  | EFromServer of ident
  | EApplication of expression * expression list
  | EHostCall of string * expression

type script = 
  | SInteger of int
  | SIdent of string
  | SString of string
  | SBoolean of bool
  | SBinary of operator * script * script
  | SIf of script * script * script
  | SFunction of string list * script
  | SVar of string * script
  | SStringAppend of script * script
  | SApplication of string * script list
  | SBlock of script list

type value = 
  | VUnit of unit
  | VInteger of int
  | VString of string
  | VQuote of expression
  | VBoolean of bool
  | VList of value list
  | VTag of string * value * value list (* tagname attributes content *)
  | VClosure of string list * expression * environment
  | VScript of script
  | VFile of Unix.file_descr

and environment = (string * namespace) list

and namespace = Dynamic of value ref | Static of value

let rec lookup_static (env:environment) (s:string) : value =
  match env with
  | (s', ns') :: rest ->
     (match ns' with
      | Static v' ->
	 (if s = s' then v' else lookup_static rest s)
      | _ -> lookup_static rest s)
  | [] -> failwith ("No such binding: "^s)

let rec lookup_dynamic (env:environment) (s:string) : value ref =
  match env with
  | (s', ns') :: rest ->
     (match ns' with
      | Dynamic vr' ->
	 (if s = s' then vr' else lookup_dynamic rest s)
      | _ -> lookup_dynamic rest s)
  | [] -> failwith ("No such binding: "^s)

let extend (env:environment) (s:string) (ns:namespace) = (s,ns) :: env

let rec string_of_expression = function
  | EInteger n -> string_of_int n
  | EIdent s -> s
  | EString s -> "\"" ^ s ^ "\""
  | EMakeString e -> "(string " ^ (string_of_expression e) ^ ")"
  | EQuote e -> "'" ^ (string_of_expression e)
  | EBoolean b -> string_of_bool b
  | EBinary (op, e1, e2) -> 
     (match op with 
      | OPlus -> "(+ "^(string_of_expression e1)^" "^(string_of_expression e2)^")"
      | OMinus -> "(- "^(string_of_expression e1)^" "^(string_of_expression e2)^")"
      | OMult -> "(* "^(string_of_expression e1)^" "^(string_of_expression e2)^")"
      | ODiv -> "(/ "^(string_of_expression e1)^" "^(string_of_expression e2)^")")
  | EIf (e1, e2, e3) -> 
     "(if " ^ (string_of_expression e1) 
     ^ " " ^ (string_of_expression e2)
     ^ " " ^ (string_of_expression e3) ^ ")"
  | ELambda (sx, e) -> "(lambda (" ^ (List.fold_left (fun a x -> a^" "^x) "" sx) ^ ") " ^ (string_of_expression e) ^ ")"
  | ELet (bx, e2) -> "(let ("^(List.fold_left (fun a (s, e1) -> "("^s^" "^(string_of_expression e1)^")"^a) "" bx)^") "^(string_of_expression e2)^")"
  | EDynamicLet (bx, e2) -> "(dynamic-let ("^(List.fold_left (fun a (s, e1) -> "("^s^" "^(string_of_expression e1)^")"^a) "" bx)^") "^(string_of_expression e2)^")"
  | EDynamic s -> "(dynamic "^s^")"
  | EDynamicSet (s,e) -> "(dynamic-set! "^s^" "^(string_of_expression e)^")"
  | EListen e1 -> "(listen "^(string_of_expression e1)^")"
  | EList l -> "(list"^(List.fold_left (fun acc e -> acc ^ " " ^(string_of_expression e)) "" l)^")"
  | EEqual (e1,e2) -> "(equal? "^(string_of_expression e1)^" "^(string_of_expression e2)^")"
  | EBegin l -> "(begin"^(List.fold_left (fun acc e -> acc ^ " " ^(string_of_expression e)) "" l)^")"
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
  | EApplication (e1, ex) -> "(" ^ (string_of_expression e1) ^ " " ^ (List.fold_left (fun a x -> a^" "^(string_of_expression x)) "" ex) ^ ")"
  | EHostCall (s, e) ->  "(hostcall" ^ s ^ " " ^ (string_of_expression e) ^ ")"

and string_of_value = function
  | VUnit _ -> "()"
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
  | VFile f -> "#FILE"

and string_of_script = function
  | SInteger (n) -> string_of_int n
  | SIdent (s) -> s
  | SString (s) -> "\"" ^ s ^ "\""
  | SBoolean (true) -> "true"
  | SBoolean (false) -> "false"
  | SBinary (op, e1, e2) -> 
     (match op with
      | OPlus -> "(" ^ "(" ^ (string_of_script e1) ^ ")" ^ "+"^ "(" ^ (string_of_script e2) ^ ")" ^ ")"
      | OMinus -> "(" ^ "(" ^ (string_of_script e1) ^ ")" ^ "-"^ "(" ^ (string_of_script e2) ^ ")" ^ ")"
      | OMult -> "(" ^ "(" ^ (string_of_script e1) ^ ")" ^ "*"^ "(" ^ (string_of_script e2) ^ ")" ^ ")"
      | ODiv -> "(" ^ "(" ^ (string_of_script e1) ^ ")" ^ "/"^ "(" ^ (string_of_script e2) ^ ")" ^ ")")
  | SIf (e1, e2, e3) -> "if (" ^ (string_of_script e1) ^ "){"
			^ (string_of_script e2) ^ "} else {"
			^ (string_of_script e3) ^ "}"
  | SFunction (sx, e1) -> "function("^(List.fold_left (fun a x -> a^", "^x) "" sx)^"){"^(string_of_script e1)^"}"
  | SStringAppend (e1, e2) -> (string_of_script e1)^".concat("^(string_of_script e2)^")"
  | SVar (s, e1) -> "var "^s^" = "^(string_of_script e1)^""
  | SApplication (s, ex) -> s^"("^(List.fold_left (fun a x -> a^(string_of_script x)) "" ex)^")"
  | SBlock(l) -> (List.fold_left (fun acc e -> acc ^ (string_of_script e)^";") "{" l) ^"}"

let rec script_of_value = function
  | VUnit _ -> failwith "script_of_value: cannot compile value of type VUnit"
  | VInteger n -> SInteger n
  | VString s -> SString s
  | VQuote _ -> failwith "script_of_value: cannot compile value of type VQuote to script"
  | VBoolean b -> SBoolean b
  | VList _ -> failwith "script_of_value: cannot compile value of type VList to script. will be compiled to array in further version"
  | VTag (_,_,_) -> failwith "script_of_value: cannot compile value of type VTag to script"
  | VClosure (s, e, env) -> failwith "script_of_value: cannot compile value of type VClosure to script. will be compiled to ScriptValueClosure in further version. need a compiler from value to script_value. then need to define script_value"
  | VScript s -> failwith "script_of_value: cannot compile value of type VScript to script"
  | VFile _ -> failwith "script_of_value: cannot compile value of type VFile to script"

let rec script_of_expression env = function
  | EInteger (n) -> SInteger (n)
  | EIdent (s) -> SIdent (s)
  | EString (s) -> SString (s)
  | EBoolean (b) -> SBoolean (b)
  | EBinary (op,a,b) -> SBinary (op, script_of_expression env a,script_of_expression env b)
  | EIf (a,b,c) -> SIf (script_of_expression env a, 
			script_of_expression env b, 
			script_of_expression env c)
  | ELambda (s,body) -> SFunction(s,script_of_expression env body)
  | ELet (bx, e2) -> 
     SBlock (List.fold_left (fun a (s, e1) -> (SVar (s, script_of_expression env e1))::a) [(script_of_expression env e2)] bx)
  | EStringAppend (e1, e2) -> SStringAppend (script_of_expression env e1,
					     script_of_expression env e2)
  | EApplication (e1, ex) ->
     (match e1 with
      | EIdent s -> SApplication (s, List.map (script_of_expression env) ex)
      | _ -> failwith "script_of_expression: call expects an identifer at functional position")
  | EFromServer ident -> script_of_value (lookup_static env ident)
  | _ -> failwith "script_of_expression: cannot compile"
	       
let rec value_to_html = function
  | VTag (tag, VList attrs, l) ->
     "<" ^ tag 
     ^ (List.fold_left 
	  (fun acc attr ->
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
  | VInteger n -> string_of_int n
  | VList l -> (List.fold_left (fun acc vt -> acc ^ (value_to_html vt)) "" l)
  | _ -> failwith "value_to_html: not implemented" (* TODO *)

let rec chars_of_string acc s = 
  if String.length s = 0 then
    acc
  else
    chars_of_string (acc@[String.get s 0]) (String.sub s 1 ((String.length s)-1))

let rec print_chars = function
  | [] -> print_endline "";
  | hd::rest -> print_string "[" ; print_char hd ; print_string "]" ; print_chars rest

let rec read_headers headers cin = 
    let line = input_line cin in
    (if String.compare line "\r" = 0 then
       headers
    else 
       read_headers (headers@[line]) cin)

let rec serve_client env client = 
  let cin = Unix.in_channel_of_descr client in
  let cout = Unix.out_channel_of_descr client in
  (match Str.split_delim (Str.regexp " ") (input_line cin) with
   | cmd::qs::prtcl::[] -> 
      (match Str.split_delim (Str.regexp "?") qs with
       | uri::arg::[] ->
	  (match lookup_static env uri with
	   | VClosure (parameters, body, env') ->
	      (let args = Str.split_delim (Str.regexp "&") arg in
	       (let env'' = 
		  List.fold_left2
		    (fun a arg parameter ->
		     (match Str.split_delim (Str.regexp "=") arg with
		      | key::value::[] ->
			 if key = parameter then
			   (extend a parameter (Static (VString value)))
			 else failwith "eval EListen: query string parameter name does not match argument name of called service"
		      | _ -> failwith "eval EListen: query string parameter is malformed, should be one key=value"))
		    env'
		    args
		    parameters in
		(match eval env'' body with
		 | VString s as res ->
		    let headers = read_headers [] cin in
		    output_string cout ("HTTP/1.1 200 OK\n\n" ^ s) ; 
		    flush cout ;
		    (*Unix.close client ;
			       Unix.close server ;*)
		    res
		 | VInteger n as res ->
		    let headers = read_headers [] cin in
		    output_string cout ("HTTP/1.1 200 OK\n\n" ^ (string_of_int n)) ; 
		    flush cout ;
		    res
		 | _ -> failwith "eval EListen: expects a string for query string parameter value")))
	   | _ -> failwith "eval EListen: uri does not match any function in the execution environment")
       | _ -> failwith "eval EListen: query string does not contain parameter, it is mandatory in this semantic")
   | _ -> failwith "eval EListen: http command line is malformed, should be:  <command> <query_string> <protocol>, ex: GET /hello?name=Alan  HTTP/1.1")

and flag_of_string = function
  | "O_CREAT" -> Unix.O_CREAT
  | "O_RDWR" -> Unix.O_RDWR
  | _ as s -> failwith ("flag_of_string: not managed: " ^ s)

and perm_of_string = int_of_string

and eval env = function
  | EInteger n -> VInteger n
  | EIdent s -> lookup_static env s
  | EString s -> VString s
  | EMakeString e ->
     (match eval env e with
      | VInteger n -> VString (String.create n)
      | _ -> failwith "eval: EMakeString: int expected")
  | EQuote e -> VQuote e
  | EBoolean b -> VBoolean b
  | EBinary (op, e1, e2) ->
     ((function (n1, n2) -> 
       match op with
       | OPlus -> VInteger (n1 + n2)
       | OMinus -> VInteger (n1 - n2)
       | OMult -> VInteger (n1 * n2)
       | ODiv -> VInteger (n1 / n2))
	(match (eval env e1, eval env e2) with
	 | (VInteger n1, VInteger n2) -> (n1,n2)
	 | _ -> failwith "binary operator: Integer expected"))
  | EIf (e1, e2, e3) ->
     (match eval env e1 with
      | VBoolean false -> eval env e3
      | _ -> eval env e2)
  | ELambda (s, e) -> VClosure (s, e, env)
  | ELet (bx, e2) -> eval (List.fold_left (fun a (s, e1) -> extend a s (Static (eval a e1))) env bx) e2
  | EDynamicLet (bx, e2) -> eval (List.fold_left (fun a (s, e1) -> extend a s (Dynamic (ref (eval a e1)))) env bx) e2
  | EDynamic s -> !(lookup_dynamic env s)
  | EDynamicSet (s,e) -> 
     let vr = lookup_dynamic env s in
     VUnit(vr := eval env e)
  | EListen e ->
     (match eval env e with
      | VInteger port ->
	 let server = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
	 let address = Unix.inet_addr_of_string "127.0.0.1" in 
	 Unix.bind server (Unix.ADDR_INET(address, port));
	 Unix.listen server 100;
	 serve_client env (fst (Unix.accept server))
      | _ -> failwith "eval EListen: port should be of type integer")
  | EList l -> VList (List.fold_left (fun acc e -> acc@[(eval env e)]) [] l)
  | EEqual (e1,e2)->
     (match (eval env e1, eval env e2) with
      | VInteger n1, VInteger n2 -> VBoolean (n1 = n2)
      | _ -> failwith "eval: EEQual: not managed type")
  | EBegin l -> List.fold_left (fun acc e -> (eval env e)) (VUnit ()) l
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
  | EApplication (e1, ex) -> 
     (match eval env e1 with
      | VClosure (s'x, e', env') ->
	     eval  
	       (List.fold_left2
		  (fun env'' s' e ->
		   let arg = eval env e in
		   (extend env'' s' (Static arg)))
		  env'
		  s'x
		  ex)
	       e'
      | _ -> failwith "Not a closure")
  | EHostCall (s, e) -> 
     (match s with
      | "Unix.openfile" -> 
	 (match eval env e with
	  | VList(VString(name)::VList(flags)::VString(perm)::[]) -> 
	     VFile (Unix.openfile name (List.map (fun x -> match x with VString s -> flag_of_string s | _ -> failwith "EHostCall:openfile:flag:not a string") flags) (perm_of_string perm))
	  | _ -> failwith "eval EHostCall: arguments error")
      | "Unix.read" -> 
	 (match eval env e with
 	  | VList(VFile(f)::VString(s)::VInteger(ofs)::VInteger(len)::[]) -> VInteger (Unix.read f s ofs len)
	  | _ -> failwith "eval EHostCall: arguments error")
      | "Unix.write" -> 
	 (match eval env e with
 	  | VList(VFile(f)::VString(s)::VInteger(ofs)::VInteger(len)::[]) -> VInteger (Unix.write f s ofs len)
	  | _ -> failwith "eval EHostCall: arguments error")
      | "Unix.close" -> 
	 (match eval env e with
	  | VList(VFile(f)::[]) -> VUnit (Unix.close f)
	  | _ -> failwith "eval EHostCall: arguments error")
      | _ -> failwith "eval EHostCall: unknown host call")

(* fun (VString name, VInteger mode) -> Unix.open name mode *)
