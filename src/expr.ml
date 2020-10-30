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

and js_expr =
  | JsVar of string
  | JsDot of string * string
  | JsString of string
  | JsSequence of js_expr list
  | JsApp of js_expr * js_expr list
  | JsFunction of string list * js_expr

and expr =
  | EDot of string * string
  | EJsExpr of js_expr
  | EAnd of expr * expr * Lexing.position option
  | EApp of expr * arg * Lexing.position option
  | EBegin of expr list * Lexing.position option
  | EBinary of operator * expr * expr * Lexing.position option
  | EBlock of string * expr * Lexing.position option
  | EBool of bool * Lexing.position option
  | EBytes of Bytes.t * Lexing.position option
  | ECallWithNewThread of expr * Lexing.position option
  | ECallcc of string * expr * Lexing.position option
  | ECar of expr * Lexing.position option
  | ECatch of string * expr * Lexing.position option
  | ECdr of expr * Lexing.position option
  | EChannelIn of in_channel * Lexing.position option
  | EChannelOut of out_channel * Lexing.position option
  | EChar of char * Lexing.position option
  | EClosure of env * expr * Lexing.position option
  | ECond of clause list * Lexing.position option
  | ECons of expr * expr * Lexing.position option
  | ECont of cont * Lexing.position option
  | EDefine of string * expr * Lexing.position option
  | EEqual of expr * expr * Lexing.position option
  | EEval of expr * Lexing.position option
  | EFile of Unix.file_descr * Lexing.position option
  | EHostCall of string * expr * Lexing.position option
  | EHostEntry of Unix.host_entry * Lexing.position option
  | EIf of expr * expr * expr * Lexing.position option
  | EInetAddr of Unix.inet_addr * Lexing.position option
  | EInt of int * Lexing.position option
  | ELambda of param * expr * Lexing.position option
  | ELambdaDot of string * expr * Lexing.position option
  | ELet of ((string * expr) list) * expr * env * Lexing.position option
  | EList of expr list * Lexing.position option
  | ELoad of expr * Lexing.position option
  | ELoadString of expr * Lexing.position option
  | ENot of expr * Lexing.position option
  | EQuasiQuote of expr * Lexing.position option
  | EQuote of expr * Lexing.position option
  | ERegexp of Str.regexp * Lexing.position option
  | EReturnFrom of string * expr * Lexing.position option
  | ESet of string * expr * Lexing.position option
  | EGet of expr * Lexing.position option
  | EStartWith of expr * Lexing.position option
  | ESchemeToJs of expr * Lexing.position option
  | EJsToString of expr
  | EShutdownCommand of Unix.shutdown_command * Lexing.position option
  | ESockAddr of Unix.sockaddr * Lexing.position option
  | ESockBoolOption of Unix.socket_bool_option * Lexing.position option
  | ESockDomain of Unix.socket_domain * Lexing.position option
  | ESslCertificate of Ssl.certificate * Lexing.position option
  | ESslCipher of Ssl.cipher * Lexing.position option
  | ESslContext of Ssl.context * Lexing.position option
  | ESslContextType of Ssl.context_type * Lexing.position option
  | ESslProtocol of Ssl.protocol * Lexing.position option
  | ESslSocket of Ssl.socket * Lexing.position option
  | EString of string * Lexing.position option
  | EThread of Thread.t * Lexing.position option
  | EThrow of string * expr * Lexing.position option
  | EThunk of expr * Lexing.position option
  | EThunkApp of expr * Lexing.position option
  | EUnQuote of expr * Lexing.position option
  | EUnit of unit * Lexing.position option
  | EVar of string * Lexing.position option
	
 and env = (string * expr ref) list

 and mem = (expr ref * expr) list
			       
 and cont = expr -> env -> mem -> expr

let rec string_of_param = function
  | Param s -> s
  | ParamOpt(s, e) -> s ^ " " ^ (string_of_expr e)
          
and string_of_arg = function
  | Arg e -> string_of_expr e
  | ArgOpt(s, e) -> s ^ " " ^ (string_of_expr e)

and string_of_jsexpr = function
  | JsVar(s) -> s
  | JsDot(s1,s2) -> "("^s1^")."^s2
  | JsString(s) -> "\""^s^"\""
  | JsSequence(es) ->
     List.fold_left (fun a e -> a^";"^(string_of_jsexpr e)) "" es
  | JsApp(e1,[]) ->
     "("^(string_of_jsexpr e1)^")"^"()"
  | JsApp(e1,arg::rest) ->
     "("^(string_of_jsexpr e1)^")"^"("^(string_of_jsexpr arg)^(List.fold_left (fun a arg -> a^", "^(string_of_jsexpr arg)) "" rest)^")"
  | JsFunction([],e1) ->
     "function (){"^(string_of_jsexpr e1)^"}"
  | JsFunction(param::rest,e1) ->
     "function ("^param^(List.fold_left (fun a param -> a^", "^param) "" rest)^"){"^(string_of_jsexpr e1)^"}"

and string_of_expr = function
  | EDot (s1, s2) -> "(-> "^s1^" "^s2^")"
  | EJsToString(e1) -> "(js->string "^(string_of_expr e1)^")"
  | EJsExpr(js_expr) -> string_of_jsexpr js_expr
  | ESchemeToJs (e, _) -> "(scheme->js "^(string_of_expr e)^")"
  | EInt (n, _) -> string_of_int n
  | EBinary (op, e1, e2, _) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
          | ODiv -> "/"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool (b, _) -> string_of_bool b
  | ENot (e, _) -> "(not "^(string_of_expr e)^")"
  | EAnd (e1,e2,_) -> "(and "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECond (clauses,_) ->
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
  | ECallWithNewThread (e,_) ->
     "(call-with-new-thread "^(string_of_expr e)^")"
  | EString (s,_) -> "\"" ^ s ^ "\""
  | EChar (c,_) -> "'" ^ (String.make 1 c) ^ "'"
  | EQuote (e,_) -> "(quote " ^ (string_of_expr e) ^")"
  | EQuasiQuote (e,_) -> "(quasiquote " ^ (string_of_expr e) ^")"
  | EUnQuote (e,_) -> "(unquote " ^ (string_of_expr e) ^")"
  | EVar (s,_) -> s
  | ESet (s, e,_) -> "(set! "^s^(string_of_expr e)^")"
  | EGet (e, _) -> "(get "^(string_of_expr e)^")"
  | EStartWith (e, _) -> "(start-with "^(string_of_expr e)^")"
  | EEval (e,_) -> "(eval "^(string_of_expr e)^")"
  | ELoad (e,_) -> "(load "^(string_of_expr e)^")"
  | ELoadString (e,_) -> "(load-string "^(string_of_expr e)^")"
  | EIf (e1, e2, e3,_) -> 
     "(if "^(string_of_expr e1)^" "^(string_of_expr e2)^" "^(string_of_expr e3)^")"
  | ELet (bindings, body,_,_) ->
     "(let ("^
       (List.fold_left
          (fun a -> function (s,e) -> a ^ "("^s^" "^(string_of_expr e)^")")
          ""
          bindings)^") "^(string_of_expr body)^")"
  | EDefine (s, e,_) ->
    "(define "^s^" "^(string_of_expr e)^")"
  | ELambda (p, body,_) ->
     "(lambda ("^(string_of_param p)^") "^(string_of_expr body)^")"
  | ELambdaDot (s, body,_) ->
     "(lambda (. "^s^") "^(string_of_expr body)^")"
  | EThunk (body,_) ->
     "(lambda () "^(string_of_expr body)^")"
  | EThunkApp (e,_) ->
     "("^(string_of_expr e)^")"
  | EApp (e1, a,_) ->
     "("^(string_of_expr e1)^" "^(string_of_arg a)^")"
  | EBegin (es,_) -> 
     "(begin"^(List.fold_left (fun acc x -> acc^" "^(string_of_expr x)) "" es)^")"
  | ECatch (s, e,_) ->
     "(catch ("^s^") "^(string_of_expr e)^")"
  | EThrow (s, e,_) ->
     "(throw ("^s^") "^(string_of_expr e)^")"
  | EBlock (s, e,_) ->
     "(block ("^s^") "^(string_of_expr e)^")"
  | EReturnFrom (s, e,_) ->
     "(return-from ("^s^") "^(string_of_expr e)^")"
  | EEqual (e1, e2,_) ->
     "(equal? "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EList (es,_) -> "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_expr e)) "" es)^")"
  | ECar (e,_) -> "(car "^(string_of_expr e)^")"
  | ECdr (e,_) -> "(cdr "^(string_of_expr e)^")"
  | ECons (e1,e2,_) -> "(cons "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | ECallcc (s, e,_) -> "(call/cc "^s^" "^(string_of_expr e)^")"
  | EHostCall (s, e,_) ->  "(hostcall " ^ s ^ " " ^ (string_of_expr e) ^ ")"
  | EUnit (_,_) -> "()"
  | EClosure (_, e,_) -> "#CLOSURE"^(string_of_expr e)^")"
  | ECont (_,_) -> "#CONT"
  | EFile (_,_) -> "#FILE"
  | EInetAddr (_,_) -> "#INETADDR"
  | ESockAddr (_,_) -> "#SOCKADDR"
  | ESockDomain (_,_) -> "#SOCKDOMAIN"
  | ESockBoolOption (_,_) -> "#SOCK_BOOL_OPTION"
  | EShutdownCommand (_,_) -> "#SHUTDOWNCOMMAND"
  | EChannelIn (_,_) -> "#INCHANNEL"
  | EChannelOut (_,_) -> "#OUTCHANNEL"
  | EThread (_,_) -> "Thread.t"
  | ESslProtocol (_,_) -> "Ssl.protocol"
  | ESslSocket (_,_) -> "Ssl.socket"
  | ESslCertificate (_,_) -> "Ssl.certificate"
  | ESslCipher (_,_) -> "Ssl.cipher"
  | ESslContextType (_,_) -> "Ssl.context_type"
  | ESslContext (_,_) -> "Ssl.context"
  | EBytes (_,_) -> "#BYTES"
  | ERegexp (_,_) -> "#REGEXP"
  | EHostEntry (_,_) -> "Unix.host_entry"
