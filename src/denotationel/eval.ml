open Expr
open Value
open Mem
open Env
open Host
open Pretty

let rec apply_bin_op op v1 v2 = 
  match (v1, v2) with
  | (VInt n1, VInt n2) ->
     (match op with
      | OPlus -> VInt (n1 + n2)
      | OMinus -> VInt (n1 - n2)
      | OMult -> VInt (n1 * n2))
  | _ -> failwith "Should be integers"

let rec eval e (env:env) (denv:env) (mem:mem) (cont:cont) =
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
  | EChar c -> cont (VChar c) mem
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
  | EHostCall (s, e) ->
     eval e env denv mem
	  (fun v mem' ->
	   cont ((List.assoc s functions) v) mem')

