type ident = string

type operator = OPlus | OMinus | OMult

type expr =
  | EInt of int
  | EBinary of operator * expr * expr
  | EBool of bool
  | EString of string
  | EQuote of expr
  | EVar of ident
  | ESet of ident * expr
  | EIf of expr * expr * expr
  | ELet of ident * expr * expr
  | ELambda of ident * expr
  | EApp of expr * expr
  | EBegin of expr list
  | ECatch of ident * expr
  | EThrow of ident * expr
  | EBlock of ident * expr
  | EReturnFrom of ident * expr
  | ECallcc of ident * expr
  | EEqual of expr * expr
  | ECar of expr
  | ECdr of expr
  | ECons of expr * expr
  | EList of expr list

type value = 
  | VUnit
  | VInt of int
  | VBool of bool
  | VString of string
  | VClosure of env * ident * expr
  | VCont of cont
  | VList of value list
  | VQuote of expr

and env = (ident * value ref) list

and mem = (value ref * value) list

and cont = value  -> mem -> value

and funct = value -> cont -> mem -> value

let extend_env id r env = (id, r)::env

let rec get_env id env =
    match env with
    | [] -> failwith ("get_env: binding not found: "^id)
    | (id', r)::rest ->
       if id = id' then r else get_env id rest
				       
let extend_mem r v mem = (r, v)::mem

let rec get_mem r mem =
    match mem with
    | [] -> failwith "get_mem: binding not found"
    | (r', v)::rest ->
       if r == r' then v else get_mem r rest

and apply_bin_op op v1 v2 = 
  match (v1, v2) with
  | (VInt n1, VInt n2) ->
     (match op with
      | OPlus -> VInt (n1 + n2)
      | OMinus -> VInt (n1 - n2)
      | OMult -> VInt (n1 * n2))
  | _ -> failwith "Should be integers"

and eval e (env:env) (denv:env) (mem:mem) (cont:cont) =
  (*(print_endline ("evaluate: "^(string_of_expr e)));*)
  match e with
  | EInt n -> cont (VInt n) mem
  | EBinary (op, e1, e2) ->
     eval e1 env denv mem
	  (fun v1 mem' ->
	   eval e2 env denv mem'
		(fun v2 mem'' ->
		 cont (apply_bin_op op v1 v2) mem''))
  | EBool b -> cont (VBool b) mem
  | EString s -> cont (VString s) mem
  | EQuote e -> cont (VQuote e) mem
  | EVar s -> cont (get_mem (get_env s env) mem) mem
  | ESet (s, e) -> 
     eval e env denv mem
	  (fun v mem' -> 
	   let addr = get_env s env in
	   cont v (extend_mem addr v mem'))
  | EIf (a, b, c) -> 
     eval a env denv mem
	  (fun v mem' -> 
	   (match v with 
	    | VBool x -> if x then eval b env denv mem' cont else eval c env denv mem' cont
	    | _ -> failwith "eval EIf: expecting a boolean"))
  | ELet (s, expr, body) ->
     eval expr env denv mem
	  (fun v mem' ->
	   let addr = ref v in
	   eval body (extend_env s addr env) denv (extend_mem addr v mem') cont)
  | ELambda (s, e) -> cont (VClosure (env, s, e)) mem
  | EApp (e1, e2) ->
     eval e1 env denv mem
	  (fun v mem' -> 
	   (match v with
	    | (VClosure (env', s, body)) ->
	       eval e2 env denv mem'
		    (fun v mem'' ->
		     let addr = ref v in
		     eval body 
			  (extend_env s addr env')
			  denv
			  (extend_mem addr v mem'')
			  cont)
	    | VCont k ->
	       eval e2 env denv mem' k
	    | _ -> failwith "Not a closure"))
  | EBegin [] -> cont VUnit mem
  | EBegin (expression::[]) ->
     eval expression env denv mem cont
  | EBegin (expression::rest) ->
     eval expression env denv mem (fun vs mem' -> eval (EBegin rest) env denv mem' cont)
  | ECatch (s, expression) -> 
     let addr = ref (VCont cont) in
     eval expression env (extend_env s addr denv) (extend_mem addr !addr mem) cont
  | EThrow (s, expression) ->
     eval expression env denv mem
	  (fun v mem' -> 
	   (match !(get_env s denv) with
	    | VCont cont' -> cont' v mem'
	    | _ -> failwith "Not a continuation"))
  | EBlock (s, expression) -> 
     let addr = ref (VCont cont) in
     eval expression (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EReturnFrom (s, expression) ->
     eval expression env denv mem
	  (fun v mem' -> 
	   (match !(get_env s env) with
	    | VCont cont' -> cont' v mem'
	    | _ -> failwith "Not a continuation"))
  | ECallcc (s, expression) ->
     let addr = ref (VCont cont) in
     eval expression (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EEqual (e1, e2) ->
     eval e1 env denv mem
	  (fun v mem' -> 
	   eval e2 env denv mem'
		(fun v' mem'' ->
		 cont (VBool (v = v')) mem''))
  | EList [] -> cont (VList []) mem
  | EList (e::rest) ->
     eval e env denv mem
	  (fun v mem' ->
	   eval (EList rest) env denv mem'
		(fun vs mem'' ->
		 match vs with 
		 | VList vs ->
		    cont (VList (v::vs)) mem''
		 | _ -> failwith "Should only be a VList"))
  | ECar e ->
     eval e env denv mem
	  (fun v mem' ->
	   match v with
	   | VList (hd::_) -> cont hd mem'
	   | _ -> failwith "Should be a list")
  | ECdr e ->
     eval e env denv mem
	  (fun v mem' ->
	   match v with
	   | VList (_::tl) -> cont (VList tl) mem'
	   | _ -> failwith "Should be a list")
  | ECons (e1, e2) ->
     eval e1 env denv mem
	  (fun v1 mem' ->
	   eval e2 env denv mem'
		(fun v2 mem'' ->
		 match v2 with
		 | VList v2 -> cont (VList (v1::v2)) mem''
		 | _ -> cont (VList (v1::[v2])) mem''))

and string_of_value = function
  | VUnit -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VString s -> "\"" ^ s ^ "\""
  | VQuote e -> "'" ^ (string_of_expr e)
  | VClosure (_, s, body)-> "#CLOSURE (lambda("^s^") "^(string_of_expr body)^")"
  | VCont _ -> "#CONT"
  | VList vs ->
     "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_value e)) "" vs)^")"

and string_of_expr = function
  | EInt n -> string_of_int n
  | EBinary (op, e1, e2) ->
     "("^(match op with
	  | OPlus -> "+"
	  | OMult -> "*"
	  | OMinus -> "-")^" "^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBool b -> string_of_bool b
  | EString s -> "\"" ^ s ^ "\""
  | EQuote e -> "'" ^ (string_of_expr e)
  | EVar s -> s
  | ESet (s, e) -> "(set! "^s^(string_of_expr e)^")"
  | EIf (e1, e2, e3) -> 
     "(if "^(string_of_expr e1)^" "^(string_of_expr e2)^" "^(string_of_expr e3)^")"
  | ELet (s, e, body) ->
    "(let ("^s^" "^(string_of_expr e)^") "^(string_of_expr body)^")"
  | ELambda (s, body) ->
     "(lambda ("^s^") "^(string_of_expr body)^")"
  | EApp (e1, e2) ->
     "("^(string_of_expr e1)^" "^(string_of_expr e2)^")"
  | EBegin es -> 
     "(begin "^(List.fold_left (fun acc x -> acc^" "^(string_of_expr x)) "" es)^")"
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

let exec expected e = 
  let current = (eval e [] [] []
		      (fun v _ ->  v)) in
  (if expected = current then
     print_string "[OK] "
   else
     print_string ("[FAILED] ")) ;
  print_endline ((string_of_expr e)^" -> "^(string_of_value current)) ;
  (if expected = current then print_string "" else
     (print_endline ("expected: "^(string_of_value expected)) ;
      print_endline ("current: "^(string_of_value current))))

(* let _ = *)
(*   exec (VInt 12) (EInt 12) ;  *)
(*   exec (VBool true) (EBool true) ; *)
(*   exec (VInt 12) (EIf (EBool true, (EInt 12), EInt 13)) ;  *)
(*   exec (VInt 13) (EIf (EBool false, (EInt 12), EInt 13)) ;  *)
(*   exec (VInt 12) (EIf (EApp (ELambda ("x", EVar "x"), EBool true), (EInt 12), EInt 13)) ;  *)
(*   exec (VInt 13) (EIf (EApp (ELambda ("x", EVar "x"), EBool false), (EInt 12), EInt 13)) ;  *)
(*   exec (VInt 12) (EApp (ELambda ("x", EVar "x"), EInt 12)) ; *)
(*   exec (VInt 14) (EBegin [EInt 12; EInt 13; EInt 14]) ; *)
(*   exec (VInt 12) (ELet ("x", EInt 12, EVar "x")) ; *)
(*   exec (VInt 12) (ELet ("f", ELambda ("x", EVar "x"), EApp (EVar "f", EInt 12))) ; *)
(*   exec (VInt 13) (ELet ("x", EInt 12, EBegin ([ESet("x", EInt 13);EVar "x"]))) ; *)
(*   exec (VInt 12) (ECatch ("exn", (EThrow ("exn", (EInt 12))))) ; *)
(*   exec (VInt 12) (ECatch ("exn", EBegin [EInt 11; (EThrow ("exn", (EInt 12))); EInt 13])) ; *)
(*   exec (VInt 12) (ELet ("x", EInt 12,  *)
(* 			(ECatch ("exn",  *)
(* 				 EBegin [EInt 11;  *)
(* 					 (EThrow ("exn", (EVar "x")));  *)
(* 					 EInt 13])))); *)
(*   exec (VBool true) (EEqual (EInt 12, EInt 12)) ; *)
(*   exec (VBool false) (EEqual (EInt 12, EInt 13)) ; *)
