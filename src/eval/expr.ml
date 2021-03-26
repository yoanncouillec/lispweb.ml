type operator = OPlus | OMinus | OMult | ODiv | OLt

type clause =
  | EClause of expr * expr
  | EElseClause of expr

and param =
  | Param of string
  | ParamOpt of string * expr

and arg =
  | Arg of expr
  | ArgOpt of string * expr

and js_expr =
  | JsVar of string
  | JsDot of js_expr * js_expr
  | JsString of string
  | JsSequence of js_expr list
  | JsApp of js_expr * js_expr list
  | JsAssignement of string * js_expr
  | JsFunction of string list * js_expr

and c_type =
  | CtVoid
  | CtInteger
  | CtChar
  | CtPointer of c_type

and c_expr =
  | CInt of int
  | CVar of string
  | CBinOp of operator * c_expr * c_expr
  | CBegin of c_expr list
  | CVarDecl of c_type * string * c_expr * c_expr
  | CFunction of c_type * string * ((c_type * string)list) * c_expr
  | CReturn of c_expr
  | CCall of c_expr * c_expr list

and expr =
  | EStyle of ANSITerminal.style
  | EDot of expr * expr
  | EJsExpr of js_expr
  | EAnd of expr * expr
  | EApp of expr * (expr list) * ((string * expr) list)
  | EBegin of expr list
  | EBinary of operator * expr * expr
  | EBlock of string * expr
  | EAnonymousBlock of expr
  | EBool of bool
  | EBytes of Bytes.t
  | ECallWithNewThread of expr
  | ECallcc of string * expr
  | ECar of expr
  | ECatch of string * expr
  | EThrow of string * expr
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
  | EFloat of float
  | EImport of string
  | ELambda of (string list) * ((string * expr) list) * expr
  | ELambdaDot of string * expr
  | ELet of ((string * expr) list) * expr * env
  | EList of expr list
  | ENot of expr
  | EQuasiQuote of expr
  | EQuote of expr
  | ERegexp of Str.regexp
  | EReturnFrom of string * expr
  | EAnonymousReturnFrom of expr
  | ESet of string * expr
  | EGet of expr
  | EStartWith of expr
  | ESchemeToJs of expr
  | EJsToString of expr
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
  | ETime of Unix.tm
  | EUnQuote of expr
  | EUnit of unit
  | EVar of string
	
 and env = (string option * expr ref) list

 and mem = (expr ref * expr) list
			       
 and cont = expr -> env -> mem -> expr

let rec c_expr_of_expr = function
  | EVar (s) -> CVar(s)
  | EInt (n) -> CInt(n)
  | EBinary(op,e1,e2) -> CBinOp(op,c_expr_of_expr e1,c_expr_of_expr e2)
  | EBegin(es) -> CBegin(List.map c_expr_of_expr es)
  | ELet([],body,_) -> c_expr_of_expr body
  | ELet((s,e)::rest,body,env) -> CVarDecl (CtInteger,s, c_expr_of_expr e, c_expr_of_expr (ELet(rest,body,env)))
  | _ -> failwith "c_expr_of_expr: not implemented"

let rec string_of_c_type = function
  | CtVoid -> "void"
  | CtInteger -> "int"
  | CtChar -> "char"
  | CtPointer(t) -> (string_of_c_type t)^" *"

let rec string_of_c_expr = function
  | CInt(n) -> string_of_int n
  | CVar(s) -> s
  | CBinOp(OPlus,e1,e2) -> "("^(string_of_c_expr e1)^" + "^(string_of_c_expr e2)^");"
  | CBinOp(OMinus, c_e1, c_e2) -> (string_of_c_expr c_e1) ^ " - " ^ (string_of_c_expr c_e2)
  | CBinOp(OMult, c_e1, c_e2) -> (string_of_c_expr c_e1) ^ " * " ^ (string_of_c_expr c_e2)
  | CBinOp(ODiv, c_e1, c_e2) -> (string_of_c_expr c_e1) ^ " / " ^ (string_of_c_expr c_e2)
  | CBinOp(OLt, c_e1, c_e2) -> (string_of_c_expr c_e1) ^ " < " ^ (string_of_c_expr c_e2)
  | CBegin(es) -> "{"^(List.fold_left (fun accu e -> accu^(string_of_c_expr e)) "" es)^"}"
  | CVarDecl(t, s, e, body) ->
     "{"^(string_of_c_type t)^" "^s^" = "^(string_of_c_expr e)^";"^(string_of_c_expr body)^"}"
  | CFunction(t,s,args,body) ->
     (string_of_c_type t)^" "^s^"()"^(string_of_c_expr body)
  | CReturn (e) -> "return "^(string_of_c_expr e)^";"
  | CCall (c_expr, []) -> (string_of_c_expr c_expr)^"()"
  | CCall (c_expr, fst::rest) -> (string_of_c_expr c_expr) ^ "("^(List.fold_left (fun accu c_expr -> accu^", "^(string_of_c_expr c_expr)) (string_of_c_expr fst) rest)^")"

  
let rec string_of_param = function
  | Param s -> s
  | ParamOpt(s, e) -> s ^ " " ^ (string_of_expr e)
          
and string_of_arg = function
  | Arg e -> string_of_expr e
  | ArgOpt(s, e) -> s ^ " " ^ (string_of_expr e)

and string_of_jsexpr = function
  | JsVar(s) -> s
  | JsDot(e1,e2) -> "("^(string_of_jsexpr e1)^")."^(string_of_jsexpr e2)
  | JsString(s) -> "\""^s^"\""
  | JsSequence(e1::rest) ->
     List.fold_left (fun a e -> a^";"^(string_of_jsexpr e)) (string_of_jsexpr e1) rest
  | JsApp(e1,[]) ->
     "("^(string_of_jsexpr e1)^")"^"()"
  | JsApp(e1,arg::rest) ->
     "("^(string_of_jsexpr e1)^")"^"("^(string_of_jsexpr arg)^(List.fold_left (fun a arg -> a^", "^(string_of_jsexpr arg)) "" rest)^")"
  | JsFunction([],e1) ->
     "(() => "^(string_of_jsexpr e1)^")"
  | JsFunction(param::rest,e1) ->
     "(("^param^(List.fold_left (fun a param -> a^", "^param) "" rest)^") => "^(string_of_jsexpr e1)^")"
  | JsAssignement(s,e) ->
     s ^ " = " ^ (string_of_jsexpr e)
  | JsSequence ([]) -> ""

and string_of_expr = function
  | EDot (e1, e2) -> "(-> "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EJsToString(e1) -> "(js->string "^(string_of_expr e1)^")"
  | EJsExpr(js_expr) -> string_of_jsexpr js_expr
  | ESchemeToJs (e) -> "(scheme->js "^(string_of_expr e)^")"
  | EInt (n) -> string_of_int n
  | EFloat (n) -> string_of_float n
  | ETime (tm) -> "#TM"
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
          | ODiv -> "/"
          | OLt -> "<"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool (true) -> "#t"
  | EBool (false) -> "#f"
  | ENot (e) -> "(not "^(string_of_expr e)^")"
  | EAnd (e1,e2) -> "(and "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECond (clauses) ->
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
  | ECallWithNewThread (e) ->
     "(call-with-new-thread "^(string_of_expr e)^")"
  | EString (s) -> "\"" ^ s ^ "\""
  | EChar (c) -> "'" ^ (String.make 1 c) ^ "'"
  | EQuote (e) -> "(quote " ^ (string_of_expr e) ^")"
  | EQuasiQuote (e) -> "(quasiquote " ^ (string_of_expr e) ^")"
  | EUnQuote (e) -> "(unquote " ^ (string_of_expr e) ^")"
  | EVar (s) -> s
  | ESet (s, e) -> "(set! "^s^(string_of_expr e)^")"
  | EGet (e) -> "(get "^(string_of_expr e)^")"
  | EStartWith (e) -> "(start-with "^(string_of_expr e)^")"
  | EEval (e) -> "(eval "^(string_of_expr e)^")"
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
  | ELambda ([], _, body) ->
     "(lambda () "^(string_of_expr body)^")"
  | ELambda (fst::rest, _, body) ->
     "(lambda ("^(List.fold_left (fun accu param -> accu^" "^param) fst rest)^") "^(string_of_expr body)^")"
  | ELambdaDot (s, body) ->
     "(lambda (. "^s^") "^(string_of_expr body)^")"
  | EApp (e1, [],_ ) -> "("^(string_of_expr e1)^")"
  | EApp (e1, fst::posparams, optparams) ->
     "("^(string_of_expr e1)^" "^(string_of_expr fst)^(List.fold_left (fun a -> function e3 -> a^" "^(string_of_expr e3)) "" posparams)^")"

  | EBegin (es) -> 
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
  | EList (es) -> "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_expr e)) "" es)^")"
  | ECar (e) -> "(car "^(string_of_expr e)^")"
  | ECdr (e) -> "(cdr "^(string_of_expr e)^")"
  | ECons (e1,e2) -> "(cons "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECallcc (s, e) -> "(call/cc "^s^" "^(string_of_expr e)^")"
  | EHostCall (s, e) ->  "(hostcall " ^ s ^ " " ^ (string_of_expr e) ^ ")"
  | EUnit (_) -> "()"
  (*| EClosure (_, e) -> "#CLOSURE"^(string_of_expr e)^")"*)
  | EClosure (_,e) -> "<fun>"
  | ECont (_) -> "#CONT"
  | EFile (_) -> "#FILE"
  | EInetAddr (_) -> "#INETADDR"
  | ESockAddr (ADDR_INET(inet_addr,port)) ->
     (Unix.string_of_inet_addr inet_addr)^":"^(string_of_int port)
  | ESockAddr (ADDR_UNIX name) -> name
  | ESockDomain (_) -> "#SOCKDOMAIN"
  | ESockBoolOption (_) -> "#SOCK_BOOL_OPTION"
  | EShutdownCommand (_) -> "#SHUTDOWNCOMMAND"
  | EChannelIn (_) -> "#INCHANNEL"
  | EChannelOut (_) -> "#OUTCHANNEL"
  | EThread (_) -> "Thread.t"
  | ESslProtocol (_) -> "Ssl.protocol"
  | ESslSocket (_) -> "Ssl.socket"
  | ESslCertificate (_) -> "Ssl.certificate"
  | ESslCipher (_) -> "Ssl.cipher"
  | ESslContextType (_) -> "Ssl.context_type"
  | ESslContext (_) -> "Ssl.context"
  | EBytes (_) -> "#BYTES"
  | ERegexp (_) -> "#REGEXP"
  | EHostEntry (_) -> "Unix.host_entry"
  | EAnonymousBlock (_) -> "#ANONYMOUSBLOCK"
  | EAnonymousReturnFrom (_) -> "#ANONYMOUSRETURNFROM"
  | EStyle(_) -> "#STYLE"
