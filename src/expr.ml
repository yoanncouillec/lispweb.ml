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
  | EAnd of expr * expr
  | EApp of expr * arg
  | EBegin of expr list
  | EBinary of operator * expr * expr
  | EBlock of string * expr
  | EBool of bool
  | EBytes of Bytes.t
  | ECallWithNewThread of expr
  | ECallcc of string * expr
  | ECar of expr
  | ECatch of string * expr
  | ECdr of expr
  | EChannelIn of in_channel
  | EChannelOut of out_channel
  | EChar of char
  | EClosure of env * expr
  | ECond of clause list
  | ECons of expr * expr
  | ECont of cont
  | EDefine of string * expr
  | EEqual of expr * expr
  | EEval of expr
  | EFile of Unix.file_descr
  | EHostCall of string * expr
  | EHostEntry of Unix.host_entry
  | EIf of expr * expr * expr
  | EInetAddr of Unix.inet_addr
  | EInt of int
  | ELambda of param * expr
  | ELambdaDot of string * expr
  | ELet of ((string * expr) list) * expr * env
  | EList of expr list
  | ELoad of expr
  | ELoadString of expr
  | ENot of expr
  | EQuasiQuote of expr
  | EQuote of expr
  | ERegexp of Str.regexp
  | EReturnFrom of string * expr
  | ESet of string * expr
  | EShutdownCommand of Unix.shutdown_command
  | ESockAddr of Unix.sockaddr
  | ESockBoolOption of Unix.socket_bool_option
  | ESockDomain of Unix.socket_domain
  | ESslCertificate of Ssl.certificate
  | ESslCipher of Ssl.cipher
  | ESslContext of Ssl.context
  | ESslContextType of Ssl.context_type
  | ESslProtocol of Ssl.protocol
  | ESslSocket of Ssl.socket
  | EString of string
  | EThread of Thread.t
  | EThrow of string * expr
  | EThunk of expr
  | EThunkApp of expr
  | EUnQuote of expr
  | EUnit of unit
  | EVar of string
	
 and env = (string * expr ref) list

 and mem = (expr ref * expr) list
			       
 and cont = expr -> env -> mem -> expr

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
  | ELoadString e -> "(load-string "^(string_of_expr e)^")"
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
  | EUnit _ -> "()"
  | EClosure (_, e)-> "#CLOSURE"^(string_of_expr e)^")"
  | ECont _ -> "#CONT"
  | EFile _ -> "#FILE"
  | EInetAddr _ -> "#INETADDR"
  | ESockAddr _ -> "#SOCKADDR"
  | ESockDomain _ -> "#SOCKDOMAIN"
  | ESockBoolOption _ -> "#SOCK_BOOL_OPTION"
  | EShutdownCommand _ -> "#SHUTDOWNCOMMAND"
  | EChannelIn _ -> "#INCHANNEL"
  | EChannelOut _ -> "#OUTCHANNEL"
  | EThread _ -> "Thread.t"
  | ESslProtocol _ -> "Ssl.protocol"
  | ESslSocket _ -> "Ssl.socket"
  | ESslCertificate _ -> "Ssl.certificate"
  | ESslCipher _ -> "Ssl.cipher"
  | ESslContextType _ -> "Ssl.context_type"
  | ESslContext _ -> "Ssl.context"
  | EBytes _ -> "#BYTES"
  | ERegexp _ -> "#REGEXP"
  | EHostEntry _ -> "Unix.host_entry"

                                                                         