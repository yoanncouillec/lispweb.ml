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
    
let rec eval e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =
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
	   | _ -> failwith ("Eval ECar: Should be a list: "^(string_of_expr v)))
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
  | EQuasiQuote e -> failwith "eval EQuasiQuote: not implemented"
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



       	    (* | VClosure (env', ELambdaDot (s, body)) as ldot -> *)
	    (*    eval e2 genv' env denv mem' *)
	    (* 	    (fun v genv'' mem'' -> *)
	    (* 	     (match get_env s env with *)
	    (* 	      | EnvAddr addr ->  *)
	    (* 		 (match (get_mem addr mem'') with *)
	    (* 		  | VList vs -> *)
	    (* 		     addr := VList (vs @ [v]) ; *)
	    (* 		     cont ldot genv'' mem'' *)
	    (* 		  | _ -> failwith "eval EApp-ELambdaDot: VList expected") *)
	    (* 	      | EnvNotFound _ -> *)
	    (* 		 let addr = ref (VList ([v])) in *)
	    (* 		 cont *)
	    (* 		 eval body  *)
	    (* 		      genv'' *)
	    (* 		      (extend_env s addr env') *)
	    (* 		      denv *)
	    (* 		      (extend_mem addr v mem'') *)
	    (* 		      cont))        *)
