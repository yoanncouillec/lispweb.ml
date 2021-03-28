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

let rec apply_bin_op op v1 v2 = 
  match (v1, v2) with
  | (EInt (n1), EInt (n2)) ->
     (match op with
      | OPlus -> EInt (n1 + n2)
      | OMinus -> EInt (n1 - n2)
      | OMult -> EInt (n1 * n2)
      | ODiv -> EInt (n1 / n2)
      | OLt -> EBool (n1 < n2)
     )
  | _ -> failwith "Should be integers"

let rec get_function s fs = 
  match fs with
  | [] -> failwith ("function not found:"^s)(*("Eval: EHostCall: function not found: "^s^" is not in ("
                    ^ (List.fold_left (fun a -> function (b) -> a^" "^b) "" functions)^")")*)
  | (s',f)::rest -> 
     if s = s' then f else get_function s rest

(* EVAL QUASI QUOTE *)

let rec eval_quasi_quote e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =

  match e with       

  | EBinary (op, e1, e2) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval_quasi_quote e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (EBinary (op, v1, v2)) genv'' mem''))

  | ENot (e) ->
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
             |  ELet(rest, body, tenv) ->
                 cont (ELet((s, v1)::rest, body, tenv)) genv2 mem2
             | _ -> failwith "Bad Bad!"))

  | EDefine (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 -> 
	 cont (EDefine (s, v1)) genv1 mem1)

  (* | ELambda (Param(s), e1) ->
   *    eval_quasi_quote e1 genv env denv mem
   *      (fun v1 genv1 mem1 ->
   *        cont (ELambda (Param(s), v1)) genv1 mem1)
   * 
   * | ELambda (ParamOpt(s, e1), e2) ->
   *    eval_quasi_quote e1 genv env denv mem
   *      (fun v1 genv1 mem1 ->
   *        eval_quasi_quote e1 genv1 env denv mem1
   *          (fun v2 genv2 mem2 ->
   *            cont (ELambda (ParamOpt(s, v1), v2)) genv2 mem2)) *)

  | ELambdaDot (s, e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ELambdaDot (s, v1)) genv1 mem1)

  (* | EApp (e1, [],[]) ->
   *    eval_quasi_quote e1 genv env denv mem
   *      (fun v1 genv1 mem1 ->
   *        cont (EApp(v1, [])) genv1 mem1)
   * 
   * | EApp (e1, (Arg(e2))::rest) ->
   *    eval_quasi_quote e2 genv env denv mem
   *      (fun v2 genv2 mem2 ->
   *        eval_quasi_quote (EApp(e1,rest)) genv2 env denv mem2
   *          (fun v3 genv3 mem3 ->
   *            match v3 with
   *            | EApp(v1,vrest) ->
   *               cont (EApp(v1, (Arg v2)::vrest)) genv3 mem3
   *            | _ -> failwith "chuck norris help me"))
   * 
   * | EApp (e1, ArgOpt(s, e2)::rest) ->
   *    eval_quasi_quote e2 genv env denv mem
   *      (fun v2 genv2 mem2 ->
   *        eval_quasi_quote (EApp(e1,rest)) genv2 env denv mem2
   *          (fun v3 genv3 mem3 ->
   *            match v3 with
   *            | EApp(v1,vrest) ->
   *               cont (EApp(v1, ArgOpt(s, v2)::vrest)) genv3 mem3
   *            | _ -> failwith "bruce lee help me")) *)

  | EBegin (e1::rest) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         eval_quasi_quote (EBegin (rest)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EBegin (v2) ->
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
         eval_quasi_quote (EList (rest)) genv1 env denv mem1
           (fun v2 genv2 mem2 ->
             match v2 with
             | EList(v2) ->
                cont (EList (v1::v2)) genv2 mem2
             | _ -> failwith "hard stuff here"))

  | ECar (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECar (v1)) genv1 mem1)

  | ECdr (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECdr (v1)) genv1 mem1)

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

  | EEval (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (EEval (v1)) genv1 mem1)

  | ECallWithNewThread (e1) ->
     eval_quasi_quote e1 genv env denv mem
       (fun v1 genv1 mem1 ->
         cont (ECallWithNewThread (v1)) genv1 mem1)

  | EUnQuote (e) ->
     eval e genv env denv mem cont
  | _ -> cont e genv mem
      
(* EVAL *)

and js_of_scheme e =

  match e with
  | EVar(s1) -> JsVar(s1)
  | EDot (e1,e2) -> JsDot(js_of_scheme e1, js_of_scheme e2)
  | EString (e) -> JsString(e)
  | EBegin(es) -> JsSequence(List.map js_of_scheme es)
  | EDefine(s,e) -> JsAssignement(s, js_of_scheme e)
  | ELambda(posparams, optparams, e1) -> JsFunction(posparams ,js_of_scheme e1)
  | EApp(EVar("print"), e1::[],_) -> JsApp(JsDot(JsVar "console", JsVar "log"), [js_of_scheme e1])
  | EApp(e1, e2::[],_) -> JsApp(js_of_scheme e1,[js_of_scheme e2])
  | EApp(e1,[],[]) -> JsApp(js_of_scheme e1,[])
  | _ -> failwith ("js_of_scheme: not implemented: "^(string_of_expr e))

and eval e (genv:env) (env:env) (denv:env) (mem:mem) (cont:cont) =

  (*(print_newline());
  (print_endline ("evaluate: "^(string_of_expr e)));
  (print_endline ("env: "^(string_of_env mem env)));*)

  match e with

  | EImport s ->
     let prefix = (match Sys.getenv_opt "LISPWEBLIB" with
                   | Some v -> v
                   | None -> "./") in
     let path = prefix^s in
     (match Parse.expr_of_filename "lisp" path with
      | Some e2 ->
         eval e2 genv env denv mem cont
      | _  -> failwith "eval|EImport|cannot parse")
    
  | EDot (s1, s2) -> failwith "not implemented"
    
  | EJsToString (e1) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EJsExpr (js_expr) ->
             cont (EString((string_of_jsexpr js_expr))) genv mem
          | _ -> failwith ("eval EJsToString: type error, should be EJsExpr: "^(string_of_expr e1))))
    
  | EJsExpr (_) -> cont e genv mem
    
  | ESchemeToJs (e) -> cont (EJsExpr (js_of_scheme e)) genv mem

  | EInt (n) -> cont (EInt (n)) genv mem

  | EFloat (n) -> cont (EFloat (n)) genv mem

  | ETime (t) -> cont (ETime (t)) genv mem

  | EBinary (op, e1, e2) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     cont (apply_bin_op op v1 v2) genv'' mem''))

  | EBool (b) -> cont (EBool (b)) genv mem

  | ENot (e) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EBool (b) -> cont (EBool (not b)) genv' mem'
	 | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v)))

  | EAnd (e1,e2) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 (match v1 with
	  | EBool (b1) -> 
             eval e2 genv' env denv mem'
	       (fun v2 genv'' mem'' ->
	         (match v2 with
	          | EBool (b2) -> cont (EBool (b1 && b2)) genv'' mem''
	          | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v2))))
	  | _ -> failwith ("eval ENot: boolean expected: "^(string_of_expr v1))))

  | EString (s) -> cont (EString (s)) genv mem

  | EStyle (s) -> cont (EStyle (s)) genv mem

  | EChar (c) -> cont (EChar (c)) genv mem

  | EVar (s) ->
     (*print_endline("env="^(string_of_env mem env));*)
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

  | EGet (e1) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EString (s) -> 
             (match get_env s env with
              | EnvAddr addr -> cont (get_mem addr mem) genv mem
              | EnvNotFound _ -> 
	         (match get_env s genv with
	          | EnvAddr addr -> cont (get_mem addr mem) genv mem
	          | EnvNotFound id -> failwith ("eval EGet: binding not found: "^id)))
          | _ as e -> failwith ("eval EGet: should be EString: "^(string_of_expr e))))

  | EStartWith (e1) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         (match v1 with
          | EString (s) ->
             cont (EList (List.map
                            (fun id -> EString (id))
                            (List.concat [get_env_start_with s genv [];
                                          get_env_start_with s env [];
                                          get_env_start_with s denv []])))
               genv
               mem
          | _ as e -> failwith ("eval EStartWith: should be EString: "^(string_of_expr e))))

  | EIf (a, b, c) -> 
     eval a genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x) -> if x then eval b genv' env denv mem' cont 
			   else eval c genv' env denv mem' cont
	  | _ -> failwith "eval EIf: expecting a boolean"))

  | ECond ([]) -> 
     cont (EUnit(())) genv mem

  | ECond (EElseClause(e1)::rest) -> 
     eval e1 genv env denv mem cont

  | ECond (EClause(e1,e2)::[]) -> 
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x) -> if x then eval e2 genv' env denv mem' cont 
			 else cont (EUnit(())) genv' mem'
	  | _ -> failwith "eval ECond: expecting a boolean"))

  | ECond (EClause(e1,e2)::rest) -> 
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 (match v with 
	  | EBool (x) -> if x then eval e2 genv' env denv mem' cont 
			   else eval (ECond(rest)) genv' env denv mem' cont
	  | _ -> failwith "eval ECond: expecting a boolean"))

  | ELet ([], body, tenv) ->
     eval body genv (List.append tenv env) denv mem cont

  | ELet ((s, expr)::rest, body, tenv) ->
     eval expr genv env denv mem
       (fun v genv' mem' ->
	 let addr = ref v in
	 eval
           (ELet(rest,body,(extend_env (Some s) addr tenv)))
           genv' env denv (extend_mem addr v mem') cont)

  | EDefine (s, expr) ->
     eval expr genv env denv mem
       (fun v genv' mem' -> 
	 let addr = ref v in
	 cont (EUnit(())) (extend_env (Some s) addr genv') (extend_mem addr v mem'))

  | ELambda (_, _, _) as e -> cont (EClosure (env, e)) genv mem

  | ELambdaDot (_, _) as e -> cont (EClosure (env, e)) genv mem

  | EApp(f, [], []) ->
     eval f genv env denv mem
       (fun vf genv' mem' ->
         (match vf with
          | EClosure (env', ELambda ([], (fstoptparam_s, fstoptparam_expr)::optparams, body)) ->
             eval fstoptparam_expr genv' env denv mem'
               (fun vfstoptparam_expr genv'' mem'' ->
                 let addr_vfstoptparam_expr = ref vfstoptparam_expr in
                 eval (EApp (EClosure (extend_env (Some fstoptparam_s) addr_vfstoptparam_expr env', ELambda ([], optparams, body)),
                                  [],
                                  []))
                   genv''
                   env
                   denv
                   (extend_mem addr_vfstoptparam_expr vfstoptparam_expr mem'')
                   cont)
          | EClosure (env', ELambda ([], [], body)) ->
             eval body genv' env' denv mem' cont
          | _ -> failwith ("eval EApp: should be a closure:"^(string_of_expr vf))))

  | EApp(f, [], (optarg_s, optarg_expr)::optargs) ->
     eval f genv env denv mem
       (fun vf genv' mem' ->
         (match vf with
          | EClosure (env', ELambda ([], optparams, body)) ->
             eval optarg_expr genv' env denv mem'
               (fun voptarg_expr genv'' mem'' ->
                 let addr_voptarg_expr = ref voptarg_expr in
                 eval
                   (EApp (EClosure (extend_env (Some optarg_s) addr_voptarg_expr env',
                                    ELambda ([], List.remove_assoc optarg_s optparams, body)),
                          [],
                          optargs))
                   genv''
                   env
                   denv
                   (extend_mem addr_voptarg_expr voptarg_expr mem'')
                   cont)
          | _ -> failwith "eval EApp: should be a closure"))

  | EApp(f, fstposarg::posargs, optargs) ->
     eval f genv env denv mem
       (fun vf genv' mem' ->
         (match vf with
          | EClosure (env', ELambda (fstposparam::posparams, optparams, body)) ->
             eval fstposarg genv' env denv mem'
               (fun vfstposarg genv'' mem'' ->
                 let addr_vfstposarg = ref vfstposarg in
                 eval
                   (EApp (EClosure (extend_env (Some fstposparam) addr_vfstposarg env',
                                    ELambda (posparams, optparams, body)),
                          posargs,
                          optargs))
                   genv''
                   env
                   denv
                   (extend_mem addr_vfstposarg vfstposarg mem'')
                   cont)
          | ECont (k) ->
             eval fstposarg genv' env denv mem' k
          | _ -> failwith "eval EApp: wrong numbers of positional arguments"))

  | EBegin ([]) -> cont (EUnit(())) genv mem

  | EBegin (expression::[]) ->
     eval expression genv env denv mem cont

  | EBegin (expression::rest) ->
     eval expression genv env denv mem 
       (fun vs genv' mem' -> eval (EBegin (rest)) genv' env denv mem' cont)

  | ECatch (EQuote(EVar(s)), expression) -> 
     let addr = ref (ECont (cont)) in
     eval expression genv env (extend_env (Some s) addr denv) (extend_mem addr !addr mem) cont

  | EThrow (EQuote(EVar(s)), expression) ->
     eval expression genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env s denv with
	  | EnvAddr addr -> 
	     (match !addr with
	      | ECont (cont') -> cont' v genv' mem'
	      | _ -> failwith "Not a continuation")
	  | EnvNotFound id -> failwith ("eval EThrow: binding not found: "^id)))

  | EBlock (EQuote(EVar(s)), expression) -> 
     let addr = ref (ECont (cont)) in
     eval expression genv (extend_env (Some s) addr env) denv (extend_mem addr !addr mem) cont

  | EReturnFrom (EQuote(EVar(s)), expression) ->
     eval expression genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env s env with
	  | EnvAddr addr ->
	     (match !addr with
	      | ECont (cont') -> cont' v genv' mem'
	      | _ -> failwith "Not a continuation")
	  | EnvNotFound id -> failwith ("eval EReturnFrom: binding not found: "^id)))

  | EAnonymousBlock (expression) -> 
     let addr = ref (ECont (cont)) in
     eval expression genv (extend_env None addr env) denv (extend_mem addr !addr mem) cont

  | EAnonymousReturnFrom (expression) ->
     eval expression genv env denv mem
       (fun v genv' mem' -> 
	 (match get_env_top_cont env mem' with
	  | EnvTopContFound cont -> cont v genv' mem'
	  | EnvTopContNotFound -> failwith ("eval EAnonymousReturnFrom: no top cont")))

  | ECallcc (s, expression) ->
     let addr = ref (ECont (cont)) in
     eval expression genv (extend_env (Some s) addr env) denv (extend_mem addr !addr mem) cont

  | EEqual (e1, e2) ->
     eval e1 genv env denv mem
       (fun v genv' mem' -> 
	 eval e2 genv' env denv mem'
	   (fun v' genv'' mem'' ->
	     cont (EBool (v = v')) genv'' mem''))


  | EList ([]) -> cont (EList ([])) genv mem

  | EList (e::rest) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 eval (EList (rest)) genv' env denv mem'
	   (fun vs genv'' mem'' ->
	     match vs with 
	     | EList (vs) ->
		cont (EList (v::vs)) genv'' mem''
	     | _ -> failwith "eval: EList: Should only be evaluated as a EList"))

  | ECar (e) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EList ((hd::_)) -> cont hd genv' mem'
	 | _ -> failwith ("Eval ECar: Should be a list: "^(string_of_expr v)))

  | ECdr (e) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 match v with
	 | EList ((_::tl)) -> cont (EList (tl)) genv' mem'
	 | _ -> failwith ("Eval ECdr: Should be a list: "^(string_of_expr v)))

  | ECons (e1, e2) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
	 eval e2 genv' env denv mem'
	   (fun v2 genv'' mem'' ->
	     match v2 with
	     | EList (v2) -> cont (EList (v1::v2)) genv'' mem''
	     | _ -> cont (EList (v1::[v2])) genv'' mem''))

  | EHostCall (s, e) ->
     eval e genv env denv mem
       (fun v genv' mem' ->
	 cont ((get_function s functions) v) genv' mem')

  | EQuote (e) -> cont e genv mem
  | EQuasiQuote (e) -> eval_quasi_quote e genv env denv mem cont
  | EUnQuote (e) -> failwith "eval EUnQuote: must be inside a quasiquote"

  | EEval (e1) ->
     eval e1 genv env denv mem
       (fun v genv' mem' ->
         eval v genv' env denv mem' cont)

  | ECallWithNewThread (e1) ->
     eval e1 genv env denv mem
       (fun v1 genv' mem' ->
         match v1 with
         | EClosure(env', ELambda ([],[],e2)) ->
            let t = Thread.create (fun _ -> eval e2 genv' env' denv mem' (fun v _ _ -> v)) () in
            cont (EThread (t)) genv' mem'
         | _  -> failwith "eval ECallWithNewThread")

  | EBytes (b) ->  cont (EBytes (b)) genv mem
  | EChannelIn (c) ->  cont (EChannelIn (c)) genv mem
  | EChannelOut (c) ->  cont (EChannelOut (c)) genv mem
  | EClosure (a, b) ->  cont (EClosure(a,b)) genv mem
  | ECont (a) ->  cont (ECont (a)) genv mem
  | EFile (f) ->  cont (EFile (f)) genv mem
  | EHostEntry (h) ->  cont (EHostEntry (h)) genv mem
  | EInetAddr (i) ->  cont (EInetAddr (i)) genv mem
  | ERegexp (r) ->  cont (ERegexp (r)) genv mem
  | EShutdownCommand (s) ->  cont (EShutdownCommand (s)) genv mem
  | ESockAddr (s) ->  cont (ESockAddr (s)) genv mem
  | ESockBoolOption (s) ->  cont (ESockBoolOption (s)) genv mem
  | ESockDomain (a) ->  cont (ESockDomain (a)) genv mem
  | ESslCertificate (a) ->  cont (ESslCertificate (a)) genv mem
  | ESslCipher (a) ->  cont (ESslCipher (a)) genv mem
  | ESslContext (a) ->  cont (ESslContext (a)) genv mem
  | ESslContextType (a) ->  cont (ESslContextType (a)) genv mem
  | ESslProtocol (a) ->  cont (ESslProtocol (a)) genv mem
  | ESslSocket (a) ->  cont (ESslSocket (a)) genv mem
  | EThread (a) ->  cont (EThread (a)) genv mem
  | EUnit (a) ->  cont (EUnit (a)) genv mem

