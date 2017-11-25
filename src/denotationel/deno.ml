type ident = string

type expr =
  | EInt of int
  | EBool of bool
  | EVar of ident
  | ESet of ident * expr
  | EIf of expr * expr * expr
  | ELet of ident * expr * expr
  | ELambda of ident * expr
  | EApp of expr * expr
  | EBegin of expr list
  | ECatch of ident * expr
  | EThrow of ident * expr
  | EEqual of expr * expr

type value = 
  | VUnit
  | VInt of int
  | VBool of bool
  | VClosure of env * ident * expr
  | VCont of cont

and env = (ident * value ref) list

and mem = (value ref * value) list

and cont = value  -> mem -> value

and funct = value -> cont -> mem -> value

let extend_env id r env = (id, r)::env

let rec get_env id = function
  | [] -> failwith "get_env: binding not found"
  | (id', r)::rest ->
     if id = id' then r else get_env id rest

let extend_mem r v mem = (r, v)::mem

let rec get_mem r = function
  | [] -> failwith "get_mem: binding not found"
  | (r', v)::rest ->
     if r = r' then v else get_mem r rest

and eval e (env:env) (denv:env) (mem:mem) (cont:cont) =
  match e with
  | EInt n -> cont (VInt n) mem
  | EBool b -> cont (VBool b) mem
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
	   eval body (extend_env s (ref v) env) denv (extend_mem (ref v) v mem') cont)
  | ELambda (s, e) -> cont (VClosure (env, s, e)) mem
  | EApp (e1, e2) ->
     eval e1 env denv mem
	  (fun v mem' -> 
	   (match v with
	    | (VClosure (env', s, body)) ->
	       eval e2 env denv mem'
		    (fun v mem'' ->
		     let (env'', mem''') = (extend_env s (ref v) env, extend_mem (ref v) v mem) in
		     eval body env'' denv mem''' cont)
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
	  (fun vs mem' -> 
	   (match !(get_env s denv) with
	    | VCont cont' -> cont' vs mem'
	    | _ -> failwith "Not a continuation"))
  | EEqual (e1, e2) ->
     eval e1 env denv mem
	  (fun v mem' -> 
	   eval e2 env denv mem'
		(fun v' mem'' ->
		 cont (VBool (v = v')) mem''))
	  
let string_of_value = function
  | VUnit -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VClosure _ -> "#CLOSURE"
  | VCont _ -> "#CONT"

let exec expected e = 
  let current = (eval e [] [] []
		      (fun v _ ->  v)) in
  if expected = current then
    print_endline "[OK]"
  else
    (print_endline ("[FAILED]");
     print_endline ("expected: "^(string_of_value expected));
     print_endline ("current: "^(string_of_value current)))

let _ =
  exec (VInt 12) (EInt 12) ; 
  exec (VBool true) (EBool true) ;
  exec (VInt 12) (EIf (EBool true, (EInt 12), EInt 13)) ; 
  exec (VInt 13) (EIf (EBool false, (EInt 12), EInt 13)) ; 
  exec (VInt 12) (EIf (EApp (ELambda ("x", EVar "x"), EBool true), (EInt 12), EInt 13)) ; 
  exec (VInt 13) (EIf (EApp (ELambda ("x", EVar "x"), EBool false), (EInt 12), EInt 13)) ; 
  exec (VInt 12) (EApp (ELambda ("x", EVar "x"), EInt 12)) ;
  exec (VInt 14) (EBegin [EInt 12; EInt 13; EInt 14]) ;
  exec (VInt 12) (ELet ("x", EInt 12, EVar "x")) ;
  exec (VInt 12) (ELet ("f", ELambda ("x", EVar "x"), EApp (EVar "f", EInt 12))) ;
  exec (VInt 13) (ELet ("x", EInt 12, EBegin ([ESet("x", EInt 13);EVar "x"]))) ;
  exec (VInt 12) (ECatch ("exn", (EThrow ("exn", (EInt 12))))) ;
  exec (VInt 12) (ECatch ("exn", EBegin [EInt 11; (EThrow ("exn", (EInt 12))); EInt 13])) ;
  exec (VInt 12) (ELet ("x", EInt 12, 
			(ECatch ("exn", 
				 EBegin [EInt 11; 
					 (EThrow ("exn", (EVar "x"))); 
					 EInt 13]))));
  exec (VBool true) (EEqual (EInt 12, EInt 12)) ;
  exec (VBool false) (EEqual (EInt 12, EInt 13)) ;
