type ident = string

type expr =
  | EInt of int
  | EBool of bool
  | EVar of ident
  | ESet of ident * expr
  | EIf of expr * expr * expr
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

let rec evalist es env cont mem = 
  match es with
  | [] -> failwith "evalist: empty"
  | e::[] -> eval e env cont mem
  | e::rest -> 
     eval e env 
	  (fun vs mem' -> 
	   (match vs with
	    | v::[] -> 
	       evalist rest env (fun vs' mem'' -> cont (v::vs') mem'') mem')) 
	  mem

and eval e (env:env) (cont:cont) (mem:mem) =
  match e with
  | EInt n -> cont [(VInt n)] mem
  | EBool b -> cont [(VBool b)] mem
  | EVar s -> cont [(get_mem (get_env s env) mem)] mem
  | ESet (s, e) -> 
     eval e env 
	  (fun vs mem' -> 
	   match vs with
	   | v::[] -> cont [v] (extend_mem (ref v) v mem'))
	  mem
  | EIf (a, b, c) -> 
     eval e env 
	  (fun v mem' -> 
	   (match v with 
	    | (VBool x)::[] -> if x then eval b env cont mem' else eval c env cont mem'
	    | _ -> failwith "eval EIf: expecting a boolean")) mem
  | ELambda (ss, e) -> cont [(VClosure (env, ss, e))] mem
  | EApp (e, es) ->
     eval e env 
	  (fun v mem' -> 
	   (match v with
	    | (VClosure (env', ss, e'))::[] ->
	       evalist es env 
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
			eval e' env'' cont mem''')
		       mem'))
	  mem

let string_of_value = function
  | VUnit -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  | VClosure _ -> "#CLOSURE"

let exec e = 
  print_endline 
    (string_of_value 
       (eval e 
	     []
	     (fun vs _ -> match vs with v::_ -> v) 
	     []))

let _ =
  exec (EInt 12) ; 
  exec (EBool true) ;
  exec (EApp (ELambda (["x"], EVar "x"), [EInt 12])) ;
