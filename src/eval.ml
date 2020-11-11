open Expr
open Mem
open Env
open Host

let string_of_position (position:Lexing.position option) =
  match position with
  | Some p -> "(" ^ p.pos_fname
                ^ "," ^ (string_of_int p.pos_lnum)
                ^ "," ^ (string_of_int p.pos_bol)
                ^ "," ^ (string_of_int p.pos_cnum) ^ ")"
  | None -> "NOPOS"

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
  | Some _ -> parse_and_print lexbuf
  | None -> ()
  
let expr_of_filename filename : expr option = 
  let lexbuf = Lexing.from_string (string_of_channel (open_in filename) "") in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_with_error lexbuf

let rec apply_bin_op op v1 v2 = 
  match (v1, v2) with
  | (EInt (n1,p), EInt (n2,_)) ->
     (match op with
      | OPlus -> EInt (n1 + n2,p)
      | OMinus -> EInt (n1 - n2,p)
      | OMult -> EInt (n1 * n2,p)
      | ODiv -> EInt (n1 / n2,p))
  | _ -> failwith "Should be integers"

let rec get_function s fs = 
  match fs with
  | [] -> failwith ("Eval: EHostCall: function not found: "^s^" is not in ("
                    ^ (List.fold_left (fun a -> function (b,_) -> a^" "^b) "" functions)^")")
  | (s',f)::rest -> 
     if s = s' then f else get_function s rest

(* EVAL QUASI QUOTE *)

let rec eval_quasi_quote e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =

  match e with       

  | EBinary (op, e1, e2,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval_quasi_quote e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (EBinary (op, v1, v2,p)) genv'' mem''))

  | ENot (e,_) ->
     eval_quasi_quote e genv env denv mem
       (fun v genv' mem' ->
	 cont v genv' mem')

  | EAnd (e1,e2,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv' mem' ->
         eval_quasi_quote e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (EAnd(v1, v2, p)) genv'' mem''))

  | ESet (s, e,_) -> 
     eval_quasi_quote e genv env denv mem
       (fun v genv' mem' -> 
         cont v genv' mem')

  | EIf (e1, e2, e3,p) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 -> 
             eval_quasi_quote e3 genv2 env denv mem2
               (fun v3 genv3 mem3 -> 
	         eval_quasi_quote (EIf(v1, v2, v3,p)) genv3 env denv mem3 cont)))

  | ECond (EElseClause(e1)::rest,p) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (ECond(rest,p)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | ECond(v3,p) ->
                cont (ECond((EElseClause v1)::v3,p)) genv2 mem2
             | _ -> failwith "Don't confond bananas & apples"))

  | ECond (EClause(e1,e2)::rest,p) -> 
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
         eval_quasi_quote e2 genv1 env denv mem1
	   (fun v2 genv2 mem2 -> 
             eval_quasi_quote (ECond(rest,p)) genv2 env denv mem2
               (fun v3 genv3 mem3 ->
                 match v3 with
                 | ECond(v4,p) ->
                    cont (ECond((EClause(v1, v2))::v4,p)) genv3 mem3
                 | _ -> failwith "Don't confond cabbage & tomato")))

  | ELet ([], body, tenv,p) ->
     eval_quasi_quote body genv env denv mem
       (fun v genv1 mem1 ->
         cont (ELet ([], v, tenv,p)) genv1 mem1)

  | ELet ((s, e1)::rest, body, tenv,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (ELet(rest, body, tenv,p)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             |  ELet(rest, body, tenv,p) ->
                 cont (ELet((s, v1)::rest, body, tenv,p)) genv2 mem2
             | _ -> failwith "Bad Bad!"))

  | EDefine (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
	 cont (EDefine (s, v1,p)) genv1 mem1)

  | ELambda (Param(s), e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELambda (Param(s), v1,p)) genv1 mem1)

  | ELambda (ParamOpt(s, e1), e2,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e1 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (ELambda (ParamOpt(s, v1), v2,p)) genv2 mem2))

  | ELambdaDot (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELambdaDot (s, v1,p)) genv1 mem1)

  | EThunk (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThunk(v1,p)) genv1 mem1)

  | EThunkApp (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThunk(v1,p)) genv1 mem1)

  | EApp (e1, []) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EApp(v1, [])) genv1 mem1)

  | EApp (e1, (Arg(e2))::rest) ->
     eval_quasi_quote e2 genv env denv mem
       (fun v2 genv2 mem2 ->
         eval_quasi_quote (EApp(e1,rest)) genv2 env denv mem2
           (fun v3 genv3 mem3 ->
             match v3 with
             | EApp(v1,vrest) ->
                cont (EApp(v1, (Arg v2)::vrest)) genv3 mem3
             | _ -> failwith "chuck norris help me"))

  | EApp (e1, ArgOpt(s, e2)::rest) ->
     eval_quasi_quote e2 genv env denv mem
       (fun v2 genv2 mem2 ->
         eval_quasi_quote (EApp(e1,rest)) genv2 env denv mem2
           (fun v3 genv3 mem3 ->
             match v3 with
             | EApp(v1,vrest) ->
                cont (EApp(v1, ArgOpt(s, v2)::vrest)) genv3 mem3
             | _ -> failwith "bruce lee help me"))

  | EBegin (e1::rest,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (EBegin (rest,p)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EBegin (v2,p) ->
                cont (EBegin(v1::v2,p)) genv2 mem2
             | _ -> failwith "blah blah"))

  | ECatch (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECatch(s, v1,p)) genv1 mem1)

  | EThrow (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EThrow (s, v1,p)) genv1 mem1)

  | EBlock (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EBlock (s, v1,p)) genv1 mem1)

  | EReturnFrom (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EReturnFrom (s, v1,p)) genv1 mem1)

  | ECallcc (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECallcc (s, v1,p)) genv1 mem1)

  | EEqual (e1, e2,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (EEqual (v1, v2,p)) genv2 mem2))

  | EList (e1::rest,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (EList (rest,p)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EList(v2,p) ->
                cont (EList (v1::v2,p)) genv2 mem2
             | _ -> failwith "hard stuff here"))

  | ECar (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECar (v1,p)) genv1 mem1)

  | ECdr (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECdr (v1,p)) genv1 mem1)

  | ECons (e1, e2,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote e2 genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             cont (ECons (v1, v2,p)) genv2 mem2))

  | EHostCall (s, e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EHostCall(s,v1,p)) genv1 mem1)

  | EEval (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EEval (e1,p)) genv1 mem1)

  | ELoad (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELoad (e1,p)) genv1 mem1)

  | ELoadString (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELoadString (e1,p)) genv1 mem1)

  | ECallWithNewThread (e1,p) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECallWithNewThread (e1,p)) genv1 mem1)

  | EUnQuote (e,p) ->
     eval e genv env denv mem cont
  | _ -> cont e genv mem
      
(* EVAL *)

and js_of_scheme e =

  match e with
  | EVar(s1,_) -> JsVar(s1)
  | EDot (s1,s2) -> JsDot(s1,s2)
  | EString (e,_) -> JsString(e)
  | EBegin(es,_) -> JsSequence(List.map js_of_scheme es)
  | ELambda(Param param,e1,_) -> JsFunction([param],js_of_scheme e1)
  | EApp(EVar("print",p),Arg(e1)::[]) -> JsApp(JsDot("console","log"), [js_of_scheme e1])
  | EApp(e1,Arg(e2)::[]) -> JsApp(js_of_scheme e1,[js_of_scheme e2])
  | _ -> failwith ("not implemented: "^(string_of_expr e))

and eval e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =

  (*(print_endline ("evaluate: "^(string_of_expr e)));*)

  match e with

  | EDot (s1, s2) -> failwith "not implemented"
    
  | EJsToString (e1) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EJsExpr (js_expr) ->
             cont (EString((string_of_jsexpr js_expr), None)) genv mem
          | _ -> failwith ("eval EJsToString: type error, should be EJsExpr: "^(string_of_expr e1))))
    
  | EJsExpr (_) -> cont e genv mem
    
  | ESchemeToJs (e,p) -> cont (EJsExpr (js_of_scheme e)) genv mem

  | EInt (n,p) -> cont (EInt (n,p)) genv mem

  | EBinary (op, e1, e2,p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (apply_bin_op op v1 v2) genv'' mem''))

  | EBool (b,p) -> cont (EBool (b,p)) genv mem

  | ENot (e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EBool (b,p) -> cont (EBool (not b,p)) genv' mem'
	 | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v)))

  | EAnd (e1,e2,p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 (match v1 with
	  | EBool (b1,p) -> 
             eval e2 genv' env denv mem'
	       (fun v2 genv'' mem'' ->
	         (match v2 with
	          | EBool (b2,p) -> cont (EBool (b1 && b2,p)) genv'' mem''
	          | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v2))))
	  | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v1))))

  | EString (s,p) -> cont (EString (s,p)) genv mem

  | EChar (c,p) -> cont (EChar (c,p)) genv mem

  | EVar (s,p) -> 
     (match get_env s env with
      | EnvAddr addr -> cont (get_mem addr mem) genv mem
      | EnvNotFound _ -> 
	 (match get_env s genv with
	  | EnvAddr addr -> cont (get_mem addr mem) genv mem
	  | EnvNotFound id -> failwith ("binding not found: "^id)))

  | ESet (s, e,p) -> 
     eval e genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env s env with
	  | EnvAddr addr -> cont v genv' (extend_mem addr v mem')
	  | EnvNotFound _ -> 
	     (match get_env s genv with
	      | EnvAddr addr -> cont v genv' (extend_mem addr v mem')
	      | EnvNotFound id -> failwith ("binding not found: "^id))))

  | EGet (e1, p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EString (s, p) -> 
             (match get_env s env with
              | EnvAddr addr -> cont (get_mem addr mem) genv mem
              | EnvNotFound _ -> 
	         (match get_env s genv with
	          | EnvAddr addr -> cont (get_mem addr mem) genv mem
	          | EnvNotFound id -> failwith ("eval EGet: binding not found: "^id)))
          | _ as e -> failwith ("eval EGet: should be EString: "^(string_of_expr e))))

  | EStartWith (e1, p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EString (s,p) ->
             cont (EList (List.map
                            (fun id -> EString (id,p))
                            (List.concat [get_env_start_with s genv [];
                                          get_env_start_with s env [];
                                          get_env_start_with s denv []]), p))
               genv
               mem
          | _ as e -> failwith ("eval EStartWith: should be EString: "^(string_of_expr e))))

  | EIf (a, b, c,p) -> 
     eval a genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x,p) -> if x then eval b genv' env denv mem' cont 
			   else eval c genv' env denv mem' cont
	  | _ -> failwith "eval EIf: expecting a boolean"))

  | ECond ([],p) -> 
     cont (EUnit((),p)) genv mem

  | ECond (EElseClause(e1)::rest,p) -> 
     eval e1 genv env denv mem cont

  | ECond (EClause(e1,e2)::[],p) -> 
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x,p) -> if x then eval e2 genv' env denv mem' cont 
			 else cont (EUnit((),p)) genv' mem'
	  | _ -> failwith "eval ECond: expecting a boolean"))

  | ECond (EClause(e1,e2)::rest,p) -> 
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x,p) -> if x then eval e2 genv' env denv mem' cont 
			   else eval (ECond(rest,p)) genv' env denv mem' cont
	  | _ -> failwith "eval ECond: expecting a boolean"))

  | ELet ([], body, tenv,p) ->
     eval body genv (List.append tenv env) denv mem cont

  | ELet ((s, expr)::rest, body, tenv,p) ->
     eval expr genv env denv mem
       (fun v genv' mem' ->
	 let addr = ref v in
	 eval (ELet(rest,body,(extend_env s addr tenv),p)) genv' env denv (extend_mem addr v mem') cont)

  | EDefine (s, expr,p) ->
     eval expr genv env denv mem
       (fun v genv' mem' -> 
	 let addr = ref v in
	 cont (EUnit((),p)) (extend_env s addr genv') (extend_mem addr v mem'))

  | ELambda (_, _,p) as e -> cont (EClosure (env, e,p)) genv mem

  | ELambdaDot (_, _,p) as e -> cont (EClosure (env, e,p)) genv mem

  | EThunk (_,p) as e -> cont (EClosure (env, e,p)) genv mem

  | EThunkApp (e1,p) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with
	  | EClosure (env', EThunk (body,_),_) ->
	     eval body genv' env denv mem' cont
	  | EClosure (env', ELambda (ParamOpt (s, e2), body,_),_) ->
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

  | EApp (e1, (Arg e2)::[]) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with
	  | EClosure (env', ELambda (Param s, body,_),_) ->
	     eval e2 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval body 
		   genv''
		   (extend_env s addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | EClosure (env', ELambda (ParamOpt (s, e3), body,_),_) ->
	     eval e3 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval (EApp (body, (Arg e2)::[]))
		   genv''
                   (extend_env (String.sub s 1 ((String.length s) - 1)) addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | ECont (k,_) ->
	     eval e2 genv' env denv mem' k
	  | _ -> failwith ("Not a closure: "^(string_of_expr v))))

  | EApp (e1, (ArgOpt(s, e2)::[])) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with
	  | EClosure (env', ELambda (Param s, body,_),_) ->
	     eval e2 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval body
		   genv''
		   (extend_env s addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | EClosure (env', ELambda (ParamOpt (s, _), body,_),_) ->
	     eval e2 genv' env denv mem'
	       (fun v genv'' mem'' ->
		 let addr = ref v in
		 eval body
		   genv''
		   (extend_env (String.sub s 1 ((String.length s) - 1)) addr env')
		   denv
		   (extend_mem addr v mem'')
		   cont)
	  | ECont (k,_) ->
	     eval e2 genv' env denv mem' k
	  | _ -> failwith ("222Not a closure: "^(string_of_expr v))))

  | EBegin ([],p) -> cont (EUnit((),p)) genv mem

  | EBegin (expression::[],p) ->
     eval expression genv env denv mem cont

  | EBegin (expression::rest,p) ->
     eval expression genv env denv mem 
       (fun vs genv' mem' -> eval (EBegin (rest,p)) genv' env denv mem' cont)

  | ECatch (s, expression,p) -> 
     let addr = ref (ECont (cont,p)) in
     eval expression genv env (extend_env s addr denv) (extend_mem addr !addr mem) cont

  | EThrow (s, expression,p) ->
     eval expression genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env s denv with
	  | EnvAddr addr -> 
	     (match !addr with
	      | ECont (cont',_) -> cont' v genv' mem'
	      | _ -> failwith "Not a continuation")
	  | EnvNotFound id -> failwith ("eval EThrow: binding not found: "^id)))

  | EBlock (s, expression,p) -> 
     let addr = ref (ECont (cont,p)) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont

  | EReturnFrom (s, expression,p) ->
     eval expression genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env s env with
	  | EnvAddr addr ->
	     (match !addr with
	      | ECont (cont',p) -> cont' v genv' mem'
	      | _ -> failwith "Not a continuation")
	  | EnvNotFound id -> failwith ("eval EReturnFrom: binding not found: "^id)))

  | ECallcc (s, expression,p) ->
     let addr = ref (ECont (cont,p)) in
     eval expression genv (extend_env s addr env) denv (extend_mem addr !addr mem) cont

  | EEqual (e1, e2,p) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 eval e2 genv' env denv mem'
	   (fun v' genv'' mem'' ->
	     cont (EBool (v = v',p)) genv'' mem''))

  | EList ([],p) -> cont (EList ([],p)) genv mem

  | EList (e::rest,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 eval (EList (rest,p)) genv' env denv mem'
	   (fun vs genv'' mem'' ->
	     match vs with 
	     | EList (vs,p) ->
		cont (EList (v::vs,p)) genv'' mem''
	     | _ -> failwith "Should only be a EList"))

  | ECar (e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EList ((hd::_),p) -> cont hd genv' mem'
	 | _ -> failwith ("Eval ECar: Should be a list: "^(string_of_expr v)^":"^(string_of_position p)))

  | ECdr (e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EList ((_::tl),p) -> cont (EList (tl,p)) genv' mem'
	 | _ -> failwith ("Eval ECdr: Should be a list: "^(string_of_expr v)))

  | ECons (e1, e2,p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     match v2 with
	     | EList (v2,p) -> cont (EList (v1::v2,p)) genv'' mem''
	     | _ -> cont (EList (v1::[v2],p)) genv'' mem''))

  | EHostCall (s, e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 cont ((get_function s functions) v) genv' mem')

  | EQuote (e,p) -> cont e genv mem
  | EQuasiQuote (e,p) -> eval_quasi_quote e genv env denv mem cont
  | EUnQuote (e,p) -> failwith "eval EUnQuote: must be inside a quasiquote"
  | EEval (e1,p) ->
     eval e1 genv env denv mem
       (fun v genv' mem' ->
         eval v genv' env denv mem' cont)

  | ELoad (e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
         match v with
         | EString (s,p) ->
            (match expr_of_filename s with
             | Some e -> eval e genv' env denv mem' cont
             | None -> failwith "ELoad: cannot parse")
         | _ -> failwith "eval ELoad: should be a string")

  | ELoadString (e,p) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
         match v with
         | EString (s,p) ->
            (match expr_of_string s with
             | Some e -> eval e genv' env denv mem' cont
             | None -> failwith "ELoad: cannot parse")
         | _ -> failwith "eval ELoad: should be a string")

  | ECallWithNewThread (e1,p) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         match v1 with
         | EClosure(env', EThunk (e2,_),_) ->
            let t = Thread.create (fun _ -> eval e2 genv' env' denv mem' (fun v _ _ -> v)) () in
            cont (EThread (t,p)) genv' mem'
         | _  -> failwith "eval ECallWithNewThread")

  | EBytes (b,p) ->  cont (EBytes (b,p)) genv mem
  | EChannelIn (c,p) ->  cont (EChannelIn (c,p)) genv mem
  | EChannelOut (c,p) ->  cont (EChannelOut (c,p)) genv mem
  | EClosure (a, b,p) ->  cont (EClosure(a,b,p)) genv mem
  | ECont (a,p) ->  cont (ECont (a,p)) genv mem
  | EFile (f,p) ->  cont (EFile (f,p)) genv mem
  | EHostEntry (h,p) ->  cont (EHostEntry (h,p)) genv mem
  | EInetAddr (i,p) ->  cont (EInetAddr (i,p)) genv mem
  | ERegexp (r,p) ->  cont (ERegexp (r,p)) genv mem
  | EShutdownCommand (s,p) ->  cont (EShutdownCommand (s,p)) genv mem
  | ESockAddr (s,p) ->  cont (ESockAddr (s,p)) genv mem
  | ESockBoolOption (s,p) ->  cont (ESockBoolOption (s,p)) genv mem
  | ESockDomain (a,p) ->  cont (ESockDomain (a,p)) genv mem
  | ESslCertificate (a,p) ->  cont (ESslCertificate (a,p)) genv mem
  | ESslCipher (a,p) ->  cont (ESslCipher (a,p)) genv mem
  | ESslContext (a,p) ->  cont (ESslContext (a,p)) genv mem
  | ESslContextType (a,p) ->  cont (ESslContextType (a,p)) genv mem
  | ESslProtocol (a,p) ->  cont (ESslProtocol (a,p)) genv mem
  | ESslSocket (a,p) ->  cont (ESslSocket (a,p)) genv mem
  | EThread (a,p) ->  cont (EThread (a,p)) genv mem
  | EUnit (a,p) ->  cont (EUnit (a,p)) genv mem
