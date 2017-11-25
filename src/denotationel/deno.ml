type ident = string

type expr =
  | EInt of int
  | EBool of bool
  | EVar of ident
  | ESet of ident * expr
  | EIf of expr * expr * expr
  | ELet of ident * expr * expr
  | ELambda of ident list * expr
  | EApp of expr * expr list
  | EBegin of expr list

type value = 
  | VUnit
  | VInt of int
  | VBool of bool
  | VClosure of env * ident list * expr

and env = (ident * value ref) list

type mem = (value ref * value) list

type cont = value list -> mem -> value

type funct = value list -> cont -> mem -> value

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

let rec evalist es env mem cont = 
  match es with
  | [] -> failwith "evalist: empty"
  | e::[] -> eval e env mem cont
  | e::rest -> 
     eval e env mem
	  (fun vs mem' -> 
	   (match vs with
	    | v::[] -> 
	       evalist rest env mem' (fun vs' mem'' -> cont (v::vs') mem''))) 

and eval e (env:env) (mem:mem) (cont:cont) =
  match e with
  | EInt n -> cont [(VInt n)] mem
  | EBool b -> cont [(VBool b)] mem
  | EVar s -> cont [(get_mem (get_env s env) mem)] mem
  | ESet (s, e) -> 
     eval e env mem
	  (fun vs mem' -> 
	   match vs with
	   | v::[] -> cont [v] (extend_mem (ref v) v mem'))
  | EIf (a, b, c) -> 
     eval a env mem
	  (fun vs mem' -> 
	   (match vs with 
	    | (VBool x)::[] -> if x then eval b env mem' cont else eval c env mem' cont
	    | _ -> failwith "eval EIf: expecting a boolean"))
  | ELet (s, expr, body) ->
     eval expr env mem
	  (fun vs mem' -> match vs with v::[] -> eval body (extend_env s (ref v) env) (extend_mem (ref v) v mem') cont)
  | ELambda (ss, e) -> cont [(VClosure (env, ss, e))] mem
  | EApp (e, es) ->
     eval e env mem
	  (fun vs mem' -> 
	   (match vs with
	    | (VClosure (env', ss, e'))::[] ->
	       evalist es env mem'
		       (fun vs mem'' ->
			let (env'', mem''') = 
			  (List.fold_left2 
			     (fun a s v ->
			      (match a with
			       | (en,me) ->
				  (extend_env s (ref v) en, extend_mem (ref v) v mem)))
			     (env', mem'')
			     ss
			     vs) in
			eval e' env'' mem''' cont)))
  | EBegin (expression::[]) ->
     eval expression env mem cont
  | EBegin (expression::rest) ->
     eval expression env mem (fun vs mem' -> eval (EBegin rest) env mem' cont)

let string_of_value = function
  | VUnit -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VClosure _ -> "#CLOSURE"

let exec expected e = 
  let current = (eval e [] []
		      (fun vs _ -> match vs with v::_ -> v)) in
  if expected = current then
    print_endline "[OK]"
  else
    (print_endline ("[FAILED]");
     print_endline ("expected: "^(string_of_value expected));
     print_endline ("current: "^(string_of_value current)))

let _ =
  exec (VInt 12) (EInt 12) ; 
  exec (VBool true) (EBool true) ;
  exec (VInt 12) (ESet ("x", (EInt 12))) ; 
  exec (VInt 12) (EIf (EBool true, (EInt 12), EInt 13)) ; 
  exec (VInt 13) (EIf (EBool false, (EInt 12), EInt 13)) ; 
  exec (VInt 12) (EIf (EApp (ELambda (["x"], EVar "x"), [EBool true]), (EInt 12), EInt 13)) ; 
  exec (VInt 13) (EIf (EApp (ELambda (["x"], EVar "x"), [EBool false]), (EInt 12), EInt 13)) ; 
  exec (VInt 12) (EApp (ELambda (["x"], EVar "x"), [EInt 12])) ;
  exec (VInt 13) (EApp (ELambda (["x";"y"], EVar "y"), [EInt 12; EInt 13])) ;
  exec (VInt 14) (EBegin [EInt 12; EInt 13; EInt 14]) ;
  exec (VInt 12) (ELet ("x", EInt 12, EVar "x"));
  exec (VInt 12) (ELet ("f", ELambda (["x"], EVar "x"), EApp (EVar "f", [EInt 12])));

