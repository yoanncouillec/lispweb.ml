open Expr
open Mem
open Env
open Host

let rec string_of_channel channel accu = 
  try
    let line = input_line channel in
    string_of_channel channel (accu^line)
  with
  | End_of_file -> accu

let expr_of_string s = 
  let lexbuf = Lexing.from_string s in
  Parser.start Lexer.token lexbuf
  
let print_position out_channel (lexbuf:Lexing.lexbuf) =
  let pos = lexbuf.lex_curr_p in
  Printf.fprintf out_channel "%s:%d:%d" 
    pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
  
let parse_with_error lexbuf =
  try Parser.start Lexer.token lexbuf with
    Lexer.SyntaxError msg ->
     Printf.fprintf stderr "%a: %s\n" print_position lexbuf msg; None
  | Parser.Error -> 
     Printf.fprintf stderr "%a: syntax error\n" print_position lexbuf; None
     
let rec parse_and_print lexbuf =
  match parse_with_error lexbuf with
  | Some value -> parse_and_print lexbuf
  | None -> ()
  
let expr_of_filename filename : expr option = 
  let lexbuf = Lexing.from_string (string_of_channel (open_in filename) "") in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_with_error lexbuf

let rec apply_bin_op op v1 v2 = 
  match (v1, v2) with
  | (EInt n1, EInt n2) ->
     (match op with
      | OPlus -> EInt (n1 + n2)
      | OMinus -> EInt (n1 - n2)
      | OMult -> EInt (n1 * n2)
      | ODiv -> EInt (n1 / n2))
  | _ -> failwith "Should be integers"

let rec get_function s fs = 
  match fs with
  | [] -> failwith ("Eval: EHostCall: function not found: "^s^" is not in ("
                    ^ (List.fold_left (fun a -> function (b,_) -> a^" "^b) "" functions)^")")
  | (s',f)::rest -> 
     if s = s' then f else get_function s rest

let rec eval_quasi_quote e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =
  match e with
  | EBinary (op, e1, e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval_quasi_quote e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (EBinary (op, v1, v2)) genv'' mem''))
  | ENot e ->
     eval_quasi_quote e genv env denv mem
	  (fun v genv' mem' ->
	   cont v genv' mem')
  | EAnd (e1,e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv' mem' ->
         eval_quasi_quote e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (EAnd(v1, v2)) genv'' mem''))
  | ESet (s, e) -> 
     eval_quasi_quote e genv env denv mem
       (fun v genv' mem' -> 
         cont v genv' mem')
  | EIf (e1, e2, e3) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 -> 
             eval_quasi_quote e3 genv2 env denv mem2
               (fun v3 genv3 mem3 -> 
	         eval_quasi_quote (EIf(v1, v2, v3)) genv3 env denv mem3 cont)))

  | ECond (EElseClause(e1)::rest) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (ECond(rest)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | ECond(v3) ->
                cont (ECond((EElseClause v1)::v3)) genv2 mem2
             | _ -> failwith "Don't confond bananas & apples"))
    
  | ECond (EClause(e1,e2)::rest) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
         eval_quasi_quote e2 genv1 env denv mem1
	   (fun v2 genv2 mem2 -> 
             eval_quasi_quote (ECond(rest)) genv2 env denv mem2
               (fun v3 genv3 mem3 ->
                 match v3 with
                 | ECond(v4) ->
                    cont (ECond((EClause(v1, v2))::v4)) genv3 mem3
                 | _ -> failwith "Don't confond cabbage & tomato")))
  | ELet ([], body, tenv) ->
     eval_quasi_quote body genv env denv mem
       (fun v genv1 mem1 ->
         cont (ELet ([], v, tenv)) genv1 mem1)
    
  | ELet ((s, e1)::rest, body, tenv) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (ELet(rest, body, tenv)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             |  (ELet(rest, body, tenv)) ->
                 cont (ELet((s, v1)::rest, body, tenv)) genv2 mem2
             | _ -> failwith "Bad Bad!"))

  | EDefine (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
	 cont (EDefine (s, v1)) genv1 mem1)

  | ELambda (Param(s), e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELambda (Param(s), v1)) genv1 mem1)

  | ELambda (ParamOpt(s, e1), e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e1 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (ELambda (ParamOpt(s, v1), v2)) genv2 mem2))

  | ELambdaDot (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELambdaDot (s, v1)) genv1 mem1)

  | EThunk (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThunk(v1)) genv1 mem1)
    
  | EThunkApp (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThunk(v1)) genv1 mem1)

  | EApp (e1, Arg e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e1 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (EApp(v1, Arg v2)) genv2 mem2))

  | EApp (e1, ArgOpt(s, e2)) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e1 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (EApp(v1, ArgOpt(s, v2))) genv2 mem2))

  | EBegin (e1::rest) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (EBegin rest) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EBegin v2 ->
                cont (EBegin(v1::v2)) genv2 mem2
             | _ -> failwith "blah blah"))

  | ECatch (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECatch(s, v1)) genv1 mem1)

  | EThrow (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThrow (s, v1)) genv1 mem1)

  | EBlock (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EBlock (s, v1)) genv1 mem1)

  | EReturnFrom (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EReturnFrom (s, v1)) genv1 mem1)

  | ECallcc (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECallcc (s, v1)) genv1 mem1)

  | EEqual (e1, e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (EEqual (v1, v2)) genv2 mem2))

  | EList (e1::rest) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (EList rest) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EList(v2) ->
                cont (EList (v1::v2)) genv2 mem2
             | _ -> failwith "hard stuff here"))

  | ECar e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECar v1) genv1 mem1)
         
  | ECdr e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECdr v1) genv1 mem1)
         
  | ECons (e1, e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (ECons (v1, v2)) genv2 mem2))

  | EHostCall (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EHostCall(s,v1)) genv1 mem1)

  | EEval e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EEval e1) genv1 mem1)

  | ELoad e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELoad e1) genv1 mem1)

  | ELoadString e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELoadString e1) genv1 mem1)

  | ECallWithNewThread e1 ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECallWithNewThread e1) genv1 mem1)

  | EUnQuote e ->
     eval e genv env denv mem cont
  | _ -> cont e genv mem    
    
and eval e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =
  (*(print_endline ("evaluate: "^(string_of_expr e)));*)
  match e with
  | EInt n -> cont (EInt n) genv mem
  | EBinary (op, e1, e2) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	   eval e2 genv' env denv mem'
		(fun v2 genv'' mem'' ->
		 cont (apply_bin_op op v1 v2) genv'' mem''))
  | EBool b -> cont (EBool b) genv mem
  | ENot e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | EBool b -> cont (EBool (not b)) genv' mem'
	   | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v)))
  | EAnd (e1,e2) ->
     eval e1 genv env denv mem
	  (fun v1 genv' mem' ->
	    (match v1 with
	    | EBool b1 -> 
               eval e2 genv' env denv mem'
	         (fun v2 genv'' mem'' ->
	           (match v2 with
	            | EBool b2 -> cont (EBool (b1 && b2)) genv'' mem''
	            | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v2))))
	    | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v1))))
  | EString s -> cont (EString s) genv mem
  | EChar c -> cont (EChar c) genv mem
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
	    | EBool x -> if x then eval b genv' env denv mem' cont 
			 else eval c genv' env denv mem' cont
	    | _ -> failwith "eval EIf: expecting a boolean"))
  | ECond ([]) -> 
     cont (EUnit()) genv mem
  | ECond (EElseClause(e1)::rest) -> 
     eval e1 genv env denv mem cont
  | ECond (EClause(e1,e2)::[]) -> 
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with 
	    | EBool x -> if x then eval e2 genv' env denv mem' cont 
			 else cont (EUnit()) genv' mem'
	    | _ -> failwith "eval ECond: expecting a boolean"))
  | ECond (EClause(e1,e2)::rest) -> 
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with 
	    | EBool x -> if x then eval e2 genv' env denv mem' cont 
			 else eval (ECond(rest)) genv' env denv mem' cont
	    | _ -> failwith "eval ECond: expecting a boolean"))
  | ELet ([], body, tenv) ->
	   eval body genv (List.append tenv env) denv mem cont
  | ELet ((s, expr)::rest, body, tenv) ->
     eval expr genv env denv mem
	  (fun v genv' mem' ->
	   let addr = ref v in
	   eval (ELet(rest,body,(extend_env s addr tenv))) genv' env denv (extend_mem addr v mem') cont)
  | EDefine (s, expr) ->
     eval expr genv env denv mem
	  (fun v genv' mem' -> 
	   let addr = ref v in
	   cont (EUnit()) (extend_env s addr genv') (extend_mem addr v mem'))
  | ELambda (_, _) as e -> cont (EClosure (env, e)) genv mem
  | ELambdaDot (_, _) as e -> cont (EClosure (env, e)) genv mem
  | EThunk _ as e -> cont (EClosure (env, e)) genv mem
  | EThunkApp e1 ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with
	  | (EClosure (env', EThunk (body))) ->
	     eval body genv' env denv mem' cont
	  | (EClosure (env', ELambda (ParamOpt (s, e2), body))) ->
	     eval e2 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval body 
		   genv''
		   (extend_env (String.sub s 1 ((String.length s) - 1)) addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | _ -> failwith "eval EThunkApp: should be a thunk"))
  | EApp (e1, Arg e2) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with
	  | (EClosure (env', ELambda (Param s, body))) ->
	     eval e2 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval body 
		   genv''
		   (extend_env s addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | (EClosure (env', ELambda (ParamOpt (s, e3), body))) ->
	     eval e3 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval (EApp (body, Arg e2))
		   genv''
                   (extend_env (String.sub s 1 ((String.length s) - 1)) addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | ECont k ->
	     eval e2 genv' env denv mem' k
	  | _ -> failwith ("Not a closure: "^(string_of_expr v))))
  | EApp (e1, ArgOpt(s, e2)) ->
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   (match v with
	    | (EClosure (env', ELambda (Param s, body))) ->
	       eval e2 genv' env denv mem'
		    (fun v genv'' mem'' ->
		     let addr = ref v in
		     eval body
			  genv''
			  (extend_env s addr env')
			  denv
			  (extend_mem addr v mem'')
			  cont)
	    | (EClosure (env', ELambda (ParamOpt (s, _), body))) ->
	       eval e2 genv' env denv mem'
		    (fun v genv'' mem'' ->
		     let addr = ref v in
		     eval body
			  genv''
		          (extend_env (String.sub s 1 ((String.length s) - 1)) addr env')
			  denv
			  (extend_mem addr v mem'')
			  cont)
	    | ECont k ->
	       eval e2 genv' env denv mem' k
	    | _ -> failwith ("222Not a closure: "^(string_of_expr v))))
  | EBegin [] -> cont (EUnit()) genv mem
  | EBegin (expression::[]) ->
     eval expression genv env denv mem cont
  | EBegin (expression::rest) ->
     eval expression genv env denv mem 
	  (fun vs genv' mem' -> eval (EBegin rest) genv' env denv mem' cont)
  | ECatch (s, expression) -> 
     let addr = ref (ECont cont) in
     eval expression genv env (extend_env s addr denv) (extend_mem addr !addr mem) cont
  | EThrow (s, expression) ->
     eval expression genv env denv mem
	  (fun v genv' mem' -> 
	   (match get_env s denv with
	    | EnvAddr addr -> 
	       (match !addr with
		| ECont cont' -> cont' v genv' mem'
		| _ -> failwith "Not a continuation")
	    | EnvNotFound id -> failwith ("eval EThrow: binding not found: "^id)))
  | EBlock (s, expression) -> 
     let addr = ref (ECont cont) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EReturnFrom (s, expression) ->
     eval expression genv env denv mem
	  (fun v genv' mem' -> 
	   (match get_env s env with
	    | EnvAddr addr ->
	       (match !addr with
		| ECont cont' -> cont' v genv' mem'
		| _ -> failwith "Not a continuation")
	    | EnvNotFound id -> failwith ("eval EReturnFrom: binding not found: "^id)))
  | ECallcc (s, expression) ->
     let addr = ref (ECont cont) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont
  | EEqual (e1, e2) ->
     eval e1 genv env denv mem
	  (fun v genv' mem' -> 
	   eval e2 genv' env denv mem'
		(fun v' genv'' mem'' ->
		 cont (EBool (v = v')) genv'' mem''))
  | EList [] -> cont (EList []) genv mem
  | EList (e::rest) ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   eval (EList rest) genv' env denv mem'
		(fun vs genv'' mem'' ->
		 match vs with 
		 | EList vs ->
		    cont (EList (v::vs)) genv'' mem''
		 | _ -> failwith "Should only be a EList"))
  | ECar e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | EList (hd::_) -> cont hd genv' mem'
	   | _ -> failwith ("Eval ECar: Should be a non-empty list: "^(string_of_expr v)))
  | ECdr e ->
     eval e genv env denv mem
	  (fun v genv' mem' ->
	   match v with
	   | EList (_::tl) -> cont (EList tl) genv' mem'
	   | _ -> failwith ("Eval ECdr: Should be a list: "^(string_of_expr v)))
  | ECons (e1, e2) ->
     eval e1 genv env denv mem
	  (fun v1 genv' mem' ->
	   eval e2 genv' env denv mem'
		(fun v2 genv'' mem'' ->
		 match v2 with
		 | EList v2 -> cont (EList (v1::v2)) genv'' mem''
		 | _ -> cont (EList (v1::[v2])) genv'' mem''))
  | EHostCall (s, e) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 cont ((get_function s functions) v) genv' mem')
  | EQuote e -> cont e genv mem
  | EQuasiQuote e -> eval_quasi_quote e genv env denv mem cont
  | EUnQuote e -> failwith "eval EUnQuote: must be inside a quasiquote"
  | EEval e1 ->
     eval e1 genv env denv mem
       (fun v genv' mem' ->
         eval v genv' env denv mem' cont)
  | ELoad e ->
     eval e genv env denv mem
    (fun v genv' mem' ->
     match v with
       | EString s ->
          (match expr_of_filename s with
           | Some e -> eval e genv' env denv mem' cont
           | None -> failwith "ELoad: cannot parse")
       | _ -> failwith "eval ELoad: should be a string")
  | ELoadString e ->
     eval e genv env denv mem
       (fun v genv' mem' ->
         match v with
         | EString s ->
          (match expr_of_string s with
           | Some e -> eval e genv' env denv mem' cont
           | None -> failwith "ELoad: cannot parse")
         | _ -> failwith "eval ELoad: should be a string")
  | ECallWithNewThread e1 ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         match v1 with
         | EClosure(env', EThunk e2) ->
            let t = Thread.create (fun _ -> eval e2 genv' env' denv mem' (fun v _ _ -> v)) () in
            cont (EThread t) genv' mem'
         | _  -> failwith "eval ECallWithNewThread")
  | EBytes b ->  cont (EBytes b) genv mem
  | EChannelIn c ->  cont (EChannelIn c) genv mem
  | EChannelOut c ->  cont (EChannelOut c) genv mem
  | EClosure (a, b) ->  cont (EClosure(a,b)) genv mem
  | ECont a ->  cont (ECont a) genv mem
  | EFile f ->  cont (EFile f) genv mem
  | EHostEntry h ->  cont (EHostEntry h) genv mem
  | EInetAddr i ->  cont (EInetAddr i) genv mem
  | ERegexp r ->  cont (ERegexp r) genv mem
  | EShutdownCommand s ->  cont (EShutdownCommand s) genv mem
  | ESockAddr s ->  cont (ESockAddr s) genv mem
  | ESockBoolOption s ->  cont (ESockBoolOption s) genv mem
  | ESockDomain a ->  cont (ESockDomain a) genv mem
  | ESslCertificate a ->  cont (ESslCertificate a) genv mem
  | ESslCipher a ->  cont (ESslCipher a) genv mem
  | ESslContext a ->  cont (ESslContext a) genv mem
  | ESslContextType a ->  cont (ESslContextType a) genv mem
  | ESslProtocol a ->  cont (ESslProtocol a) genv mem
  | ESslSocket a ->  cont (ESslSocket a) genv mem
  | EThread a ->  cont (EThread a) genv mem
  | EUnit a ->  cont (EUnit a) genv mem
