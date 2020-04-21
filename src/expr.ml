type operator = OPlus | OMinus | OMult | ODiv

type clause =
  | EClause of expr * expr
  | EElseClause of expr

and param =
  | Param of string
  | ParamOpt of string * expr
                 
and arg =
  | Arg of expr
  | ArgOpt of string * expr
            
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
  | ELet of ((string * expr) list) * expr * env
  | EDefine of string * expr
  | EThunk of expr
  | EThunkApp of expr
  | ELambda of param * expr
  | ELambdaDot of string * expr
  | EApp of expr * arg
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
  | ECallWithNewThread of expr

and value = 
  | VUnit of unit
  | VInt of int
  | VBool of bool
  | VString of string
  | VChar of char
  | VClosure of env * expr
  | VCont of cont
  | VList of value list
  | VExpr of expr
  | VQuote of expr
  | VFile of Unix.file_descr
  | VInetAddr of Unix.inet_addr
  | VSockAddr of Unix.sockaddr
  | VSockDomain of Unix.socket_domain
  | VSockBoolOption of Unix.socket_bool_option
  | VShutdownCommand of Unix.shutdown_command
  | VChannelIn of in_channel
  | VChannelOut of out_channel
  | VThread of Thread.t
  | VSslProtocol of Ssl.protocol
  | VSslSocket of Ssl.socket
  | VSslCertificate of Ssl.certificate
  | VSslCipher of Ssl.cipher
  | VSslContextType of Ssl.context_type
  | VSslContext of Ssl.context
  | VBytes of Bytes.t
  | VRegexp of Str.regexp
  | VHostEntry of Unix.host_entry	
	
 and env = (string * value ref) list

 and mem = (value ref * value) list
			       
 and cont = value  -> env -> mem -> value

let rec string_of_param = function
  | Param s -> s
  | ParamOpt(s, e) -> s ^ " " ^ (string_of_expr e)
          
and string_of_arg = function
  | Arg e -> string_of_expr e
  | ArgOpt(s, e) -> s ^ " " ^ (string_of_expr e)
          
and string_of_expr = function
  | EInt n -> string_of_int n
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
          | ODiv -> "/"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool b -> string_of_bool b
  | ENot e -> "(not "^(string_of_expr e)^")"
  | EAnd (e1,e2) -> "(and "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECond clauses ->
     "(cond "^
       (List.fold_left
          (fun a clause ->
            a^
              (match clause with
               | EClause (e1,e2) -> "("^(string_of_expr e1)^" "^(string_of_expr e2)^")"
               | EElseClause e -> "(else "^(string_of_expr e)^")"))
          ""
          clauses)
       ^")"
  | ECallWithNewThread e ->
     "(call-with-new-thread "^(string_of_expr e)^")"
  | EString s -> "\"" ^ s ^ "\""
  | EChar c -> "'" ^ (String.make 1 c) ^ "'"
  | EQuote e -> "(quote " ^ (string_of_expr e) ^")"
  | EQuasiQuote e -> "(quasiquote " ^ (string_of_expr e) ^")"
  | EUnQuote e -> "(unquote " ^ (string_of_expr e) ^")"
  | EVar s -> s
  | ESet (s, e) -> "(set! "^s^(string_of_expr e)^")"
  | EEval e -> "(eval "^(string_of_expr e)^")"
  | ELoad e -> "(load "^(string_of_expr e)^")"
  | EIf (e1, e2, e3) -> 
     "(if "^(string_of_expr e1)^" "^(string_of_expr e2)^" "^(string_of_expr e3)^")"
  | ELet (bindings, body,_) ->
     "(let ("^
       (List.fold_left
          (fun a -> function (s,e) -> a ^ "("^s^" "^(string_of_expr e)^")")
          ""
          bindings)^") "^(string_of_expr body)^")"
  | EDefine (s, e) ->
    "(define "^s^" "^(string_of_expr e)^")"
  | ELambda (p, body) ->
     "(lambda ("^(string_of_param p)^") "^(string_of_expr body)^")"
  | ELambdaDot (s, body) ->
     "(lambda (. "^s^") "^(string_of_expr body)^")"
  | EThunk (body) ->
     "(lambda () "^(string_of_expr body)^")"
  | EThunkApp e ->
     "("^(string_of_expr e)^")"
  | EApp (e1, a) ->
     "("^(string_of_expr e1)^" "^(string_of_arg a)^")"
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
