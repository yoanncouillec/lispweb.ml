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

let rec eval e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =
  (*(print_endline ("evaluate: "^(string_of_expr e)));*)
  match e with
  | EInt n -> cont (VInt n) genv mem
  | EBinary (op, e1, e2) ->
     eval e1 genv env denv mem
	  (fun v1 genv' mem' ->
	   eval e2 genv' env denv mem'
		(fun v2 genv'' mem'' ->
		 cont (apply_bin_op op v1 v2) genv'' mem''))
  | EBool b -> cont (VBool b) genv mem
  | ENot e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | VBool b -> cont (VBool (not b)) genv' mem'
	   | _ -> failwith ("eval ENot: boolean expected: "^(string_of_value v)))
  | EString s -> cont (VString s) genv mem
  | EChar c -> cont (VChar c) genv mem
  | EQuote e -> cont (VQuote e) genv mem
  | EVar s -> 
     (match get_env s env with
      | EnvAddr addr -> cont (get_mem addr mem) genv mem
      | EnvNotFound _ -> 
	 (match get_env s genv with
	  | EnvAddr addr -> cont (get_mem addr mem) genv mem
	  | EnvNotFound id -> failwith ("binding not found: "^id)))
  | ESet (s, e) -> 
     eval e genv env denv mem
	  (fun v genv' mem' -> 
	   (match get_env s env with
	    | EnvAddr addr -> cont v genv' (extend_mem addr v mem')
	    | EnvNotFound _ -> 
	       (match get_env s genv with
		| EnvAddr addr -> cont v genv' (extend_mem addr v mem')
		| EnvNotFound id -> failwith ("binding not found: "^id))))
  | EIf (a, b, c) -> 
     eval a genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with 
	    | VBool x -> if x then eval b genv' env denv mem' cont else eval c genv' env denv mem' cont
	    | _ -> failwith "eval EIf: expecting a boolean"))
  | ELet (s, expr, body) ->
     eval expr genv env denv mem
	  (fun v genv' mem' ->
	   let addr = ref v in
	   eval body genv' (extend_env s addr env) denv (extend_mem addr v mem') cont)
  | EDefine (s, expr) ->
     eval expr genv env denv mem
	  (fun v genv' mem' -> 
	   let addr = ref v in
	   cont VUnit (extend_env s addr genv') (extend_mem addr v mem'))
  | ELambda (_, _) as e -> cont (VClosure (env, e)) genv mem
  | EThunk _ as e -> cont (VClosure (env, e)) genv mem
  | EThunkApp e ->
     eval e genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with
	    | (VClosure (env', EThunk (body))) ->
	       eval body genv' env denv mem' cont
	    | _ -> failwith "eval EThunkApp: should be a thunk"))
  | EApp (e1, e2) ->
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with
	    | (VClosure (env', ELambda (s, body))) ->
	       eval e2 genv' env denv mem'
		    (fun v genv'' mem'' ->
		     let addr = ref v in
		     eval body 
			  genv''
			  (extend_env s addr env')
			  denv
			  (extend_mem addr v mem'')
			  cont)
	    | VCont k ->
	       eval e2 genv' env denv mem' k
	    | _ -> failwith "Not a closure"))
  | EBegin [] -> cont VUnit genv mem
  | EBegin (expression::[]) ->
     eval expression genv env denv mem cont
  | EBegin (expression::rest) ->
     eval expression genv env denv mem (fun vs genv' mem' -> eval (EBegin rest) genv' env denv mem' cont)
  | ECatch (s, expression) -> 
     let addr = ref (VCont cont) in
     eval expression genv env (extend_env s addr denv) (extend_mem addr !addr mem) cont
  | EThrow (s, expression) ->
     eval expression genv env denv mem
	  (fun v genv' mem' -> 
	   (match get_env s denv with
	    | EnvAddr addr -> 
	       (match !addr with
		| VCont cont' -> cont' v genv' mem'
		| _ -> failwith "Not a continuation")
	    | EnvNotFound id -> failwith ("eval EThrow: binding not found: "^id)))
  | EBlock (s, expression) -> 
     let addr = ref (VCont cont) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EReturnFrom (s, expression) ->
     eval expression genv env denv mem
	  (fun v genv' mem' -> 
	   (match get_env s env with
	    | EnvAddr addr ->
	       (match !addr with
		| VCont cont' -> cont' v genv' mem'
		| _ -> failwith "Not a continuation")
	    | EnvNotFound id -> failwith ("eval EReturnFrom: binding not found: "^id)))
  | ECallcc (s, expression) ->
     let addr = ref (VCont cont) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EEqual (e1, e2) ->
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   eval e2 genv' env denv mem'
		(fun v' genv'' mem'' ->
		 cont (VBool (v = v')) genv'' mem''))
  | EList [] -> cont (VList []) genv mem
  | EList (e::rest) ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   eval (EList rest) genv' env denv mem'
		(fun vs genv'' mem'' ->
		 match vs with 
		 | VList vs ->
		    cont (VList (v::vs)) genv'' mem''
		 | _ -> failwith "Should only be a VList"))
  | ECar e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | VList (hd::_) -> cont hd genv' mem'
	   | _ -> failwith ("Eval ECar: Should be a list: "^(string_of_value v)))
  | ECdr e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | VList (_::tl) -> cont (VList tl) genv' mem'
	   | _ -> failwith ("Eval ECdr: Should be a list: "^(string_of_value v)))
  | ECons (e1, e2) ->
     eval e1 genv env denv mem
	  (fun v1 genv' mem' ->
	   eval e2 genv' env denv mem'
		(fun v2 genv'' mem'' ->
		 match v2 with
		 | VList v2 -> cont (VList (v1::v2)) genv'' mem''
		 | _ -> cont (VList (v1::[v2])) genv'' mem''))
  | EHostCall (s, e) ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   cont ((List.assoc s functions) v) genv' mem')

