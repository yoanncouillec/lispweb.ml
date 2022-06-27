open Expr

(***************)
(* 2nd attempt *)
(***************)

type ty =
  | TyVar of string
  | TyBool
  | TyInt
  | TyString
  | TyNil
  | TyArrow of ty * ty
  | TyPair of ty * ty
  | TyList of ty
  | TyQuote

let  rec occurs (x : string) (t : ty) : bool =
  match t with
  | TyVar y -> x = y
  | TyArrow (ty1, ty2) -> (occurs x ty1) || (occurs x ty2)
  | TyPair (ty1, ty2) -> (occurs x ty1) || (occurs x ty2)
  | TyList (ty1) -> (occurs x ty1)
  | _ -> false

let rec substitute (s : ty) (x : string) (t : ty) : ty =
  match t with
  | TyVar y -> if x = y then s else t
  | TyArrow (ty1, ty2) -> TyArrow(substitute s x ty1, substitute s x ty2)
  | TyPair (ty1, ty2) -> TyArrow(substitute s x ty1, substitute s x ty2)
  | TyList (ty1) -> TyList(substitute s x ty1)
  | _ -> t

let rec unify (s : ty) (t : ty) =
  match (s, t) with
  | (TyVar x, TyVar y) -> if x = y then [] else [(x, t)]
  | (TyVar x, _) -> if occurs x t then failwith "not unifiable: circularity" else [(x, t)]
  | (_, TyVar y) -> if occurs y s then failwith "not unifiable: circularity" else [(y, s)]
  | (TyArrow (ty1, ty2), TyArrow(ty3, ty4)) -> (unify ty1 ty3) @ (unify ty2 ty4)
  | (TyPair (ty1, ty2), TyPair(ty3, ty4)) -> (unify ty1 ty3) @ (unify ty2 ty4)
  | (TyList (ty1), TyList(ty2)) -> unify ty1 ty2
  | TyBool, TyBool -> []
  | TyInt, TyInt -> []
  | TyString, TyString -> []
  | TyNil, TyNil -> []
  | TyQuote, TyQuote -> []
  | _ -> failwith "not unifiable: head symbol conflict"

let rec type_of_expr env e =

  match e with
  | EInt _ -> TyInt, env

(***************)
(* 3th attempt *)
(***************)

type typ = 
| TInt
| TVar of string 
| TArrow of typ * typ
| TList of typ

type env = (string * typ) list

let rec string_of_typ = function
  | TInt -> "int"
  | TVar x -> x
  | TArrow (x,y) -> "(" ^ (string_of_typ x) ^ " -> " ^ (string_of_typ y) ^ ")"
  | TList ty1 -> (string_of_typ ty1)^" list"

let rec substitute (env : env) (ty : typ) : typ = match ty with
  | TInt -> TInt
  | TVar x  -> (try List.assoc x env with Not_found -> TVar x)
  | TArrow(ty1, ty2) -> TArrow (substitute env ty1, substitute env ty2)
  | TList(ty1) -> TList(substitute env ty1)
  | _ -> failwith ("ERROR|substitute|not implemented|"^(string_of_typ ty))
  
let compsubst (env1 : env) (env2 : env) = 
  (List.map (function (x, ty1) -> (x, substitute env1 ty1)) env2) @ env1;;

let rec occur (x : string) (ty : typ) : bool = match ty with
  | TInt -> false
  | TVar y -> y = x
  | TArrow(ty1, ty2) -> (occur x ty1) || (occur x ty2)
  | TList (ty1) -> occur x ty1

let rec unify (ty1 : typ) (ty2 : typ) : env = match ty1, ty2 with

  | (TVar x, TVar y) -> if x = y then [] else [(x, ty2)]
  | (TVar x, _) -> if occur x ty2 then failwith "unify: circularity" else [(x, ty2)]
  | (_, TVar y) -> if occur y ty1 then failwith "unify: circularity" else [(y, ty1)]

  | TArrow (ty1, ty2), TArrow (ty3, ty4) -> 
     let env = unify ty1 ty3 in
     compsubst (unify (substitute env ty2) (substitute env ty4)) env

  | TList (ty1), TList (ty2) ->
     let env = unify ty1 ty2 in
     env

  | _ -> failwith "unify: error "

let c = ref 0
let reset () = c := 0
let gensym s = incr c ; s ^ (string_of_int !c)
let gensym s = incr c ; "'"^(String.make 1 (char_of_int(int_of_char 'a' + !c - 1)))
let new_variable () = TVar(incr c ; "'"^(String.make 1 (char_of_int(int_of_char 'a' + !c - 1))))

let rec type_of (env : env) (e : expr) : (typ * env) =
  print_endline("type_of: "^(string_of_expr e));
  match e with
    
  | EInt n -> TInt, env

  | EVar x -> List.assoc x env , env

  | ELambda (x::[], _, body) -> 
     let type_argument = new_variable() in
     let env_etendu = (x, type_argument)::env in
     let type_body, env_body = type_of env_etendu body in
     TArrow (type_argument, type_body), env_body

  | EApp(fonction, argument::[], _) ->
     let type_argument, env1 = type_of env argument in
     let type_fonction, env2 = type_of (List.map (function (x, ty_x) -> (x, substitute env1 ty_x)) env) fonction in
     let type_resultat = new_variable() in 
     let env3 = unify (substitute env2 type_fonction) (TArrow (type_argument, type_resultat))  in
     type_resultat, compsubst env3 (compsubst env2 env1)

  | EBegin (e::[]) -> type_of env e

  | ECons (e1, e2) ->
     let type_e1, env1 = type_of env e1 in
     let type_e2, env2 = type_of (List.map (function (x, ty_x) -> (x, substitute env1 ty_x)) env) e2 in
     let env3 = unify (substitute env2 (TList type_e1)) type_e2 in
     type_e2, env3

  | ECar(e1) ->
     let type_e1, env1 = type_of env e1 in
     let type_element = new_variable() in
     let env2 = unify (TList type_element) type_e1 in
     type_element, env2

  | EList([]) -> TList (new_variable()), env

  | _  -> failwith ("not implemented: "^(string_of_expr e))

(***************)
(* 1st attempt *)
(***************)

type type_simple =
  | TVariable of variable_de_type
  | Terme of string * type_simple array

and variable_de_type =
  { mutable niveau: int;
    mutable valeur: valeur_dune_variable }

and valeur_dune_variable =
  | Inconnue
  | Connue of type_simple

exception Erreur of string
exception Conflit of type_simple * type_simple
exception Circularite of type_simple * type_simple

let type_int = Terme("int", [||])
and type_bool = Terme("bool", [||])
and type_string = Terme("string", [||])
and type_nil = Terme("unit", [||])
and type_fleche t1 t2 = Terme("->", [|t1;t2|])
and type_produit t1 t2 = Terme("*", [|t1;t2|])
and type_liste t = Terme("list", [|t|])
and type_quote = Terme("quote", [||])

type schema_de_types =
  { parametres: variable_de_type list;
    corps: type_simple }

type environnement = (string * schema_de_types) list

let schema_trivial ty = {parametres = [] ; corps = ty}

let niveau_de_liaison = ref 0
let debut_de_definition () = incr niveau_de_liaison
and fin_de_definition () = decr niveau_de_liaison
let nouvelle_inconnue () = TVariable{niveau = !niveau_de_liaison; valeur = Inconnue}

let noms_des_variables = ref ([] : (variable_de_type * string) list)
and compteur_de_variables = ref 0

let imprime_var var =
  "'"^
  try
    List.assq var !noms_des_variables
  with Not_found ->
        let nom =
          String.make 1
            (char_of_int(int_of_char 'a' + !compteur_de_variables)) in
        incr compteur_de_variables;
        noms_des_variables := (var, nom) :: !noms_des_variables;
        nom

let rec valeur_de = function
  | TVariable({valeur = Connue ty1} as var) ->
     let valeur_de_ty1 = valeur_de ty1 in
     var.valeur <- Connue valeur_de_ty1;
     valeur_de_ty1
  | ty -> ty

let rec string_of_type ty =
  (match valeur_de ty with
   | TVariable var -> imprime_var var
   | Terme(constructeur, arguments) ->
      match Array.length arguments with
      | 0 -> constructeur
      | 1 -> (string_of_type arguments.(0))^" "^constructeur
      | 2 -> "("^(string_of_type arguments.(0))^" "^constructeur^" "^(string_of_type arguments.(1))^")"
      | _ -> failwith "not implemented")

let imprime_type ty =
  noms_des_variables := [];
  compteur_de_variables := 0;
  string_of_type ty

let imprime_schema schema =
  noms_des_variables := [];
  compteur_de_variables := 0;
  if schema.parametres <> [] then
    begin
      "pour tout "^
        (List.fold_left
           (fun accu var -> accu^" "^(imprime_var var))
           ""
           schema.parametres)^
          ", "
    end
  else "";
  string_of_type schema.corps

let generalisation ty =
  let parametres = ref [] in
  let rec trouve_parametres ty =
    match valeur_de ty with
    | TVariable var ->
       if var.niveau > !niveau_de_liaison && (not (List.memq var !parametres))
       then parametres := var :: !parametres
    | Terme(constr, arguments) ->
       Array.iter trouve_parametres arguments in
  trouve_parametres ty;
  {parametres = !parametres ; corps = ty}

let specialisation schema =
  match schema.parametres with
  | [] -> schema.corps
  | parametres ->
     let nouvelles_inconnues =
       List.map (fun var -> (var, nouvelle_inconnue())) parametres in
     let rec copie ty =
       match valeur_de ty with
         TVariable var as ty ->
          begin try
              List.assq var nouvelles_inconnues
            with Not_found ->
              ty
          end
       | Terme(constr, arguments) ->
          Terme(constr, Array.map copie arguments) in
     copie schema.corps

let test_doccurence var ty =
  let rec test t =
    match valeur_de t with
      TVariable var' ->
       if var == var' then raise (Circularite(TVariable var, ty))
      | Terme (constructeur, arguments) ->
         Array.iter test arguments
  in test ty

let rec rectifie_niveaux niveau_max ty =
  match valeur_de ty with
    TVariable var ->
     if var.niveau > niveau_max then var.niveau <- niveau_max
    | Terme(constructeur, arguments) ->
       Array.iter (rectifie_niveaux niveau_max) arguments

let rec unifie ty1 ty2 e2 =
  let valeur1 = valeur_de ty1
  and valeur2 = valeur_de ty2 in
  if valeur1 == valeur2 then () else
    match (valeur1, valeur2) with
    | (TVariable var), ty ->
       test_doccurence var ty;
       rectifie_niveaux var.niveau ty;
       var.valeur <- Connue ty
    | ty, TVariable var ->
       test_doccurence var ty;
       rectifie_niveaux var.niveau ty;
       var.valeur <- Connue ty
    | Terme (constr1, arguments1), Terme(constr2, arguments2) ->
       if constr1 <> constr2 then
         (failwith ("expression "^(Expr.string_of_expr e2)^"has type " ^(imprime_type ty2)^
                      " but an expression was expected of type "^(imprime_type ty1)))
       else
         for i = 0 to (Array.length arguments1) - 1 do
           unifie arguments1.(i) arguments2.(i) e2
         done

let rec type_exp env e = 
  (*(print_endline (">>>"^(string_of_expr e)^"<<<"));*)
  match e with

  | EQuote e1 ->
     type_quote, env
    
  | EThrow (s, e1) ->
     let _, env' = type_exp env e1 in
     let type_throw = nouvelle_inconnue() in
     type_throw, env'
    
  | EList ([]) -> type_liste (nouvelle_inconnue()), env
    
  | EIf (e1, e2, e3) ->
     let type_e1, env2 = type_exp env e1 in
     unifie type_bool type_e1 e1;
     let type_e2, env3 = type_exp env2 e2 in
     let type_e3, env4 = type_exp env3 e3 in
     unifie type_e2 type_e3 e3;
     type_e3, env4
     
  | EEqual (e1, e2) ->
     let type_e1, env' = type_exp env e1 in
     let type_e2, env'' = type_exp env' e2 in
     unifie type_e1 type_e2 e2;
     type_bool, env''

  | ENot e ->
     let type_e, env' = type_exp env e in
     unifie type_bool type_e e;
     type_bool, env'

  | EImport s ->
     let prefix = (match Sys.getenv_opt "LISPWEBLIB" with
                   | Some v -> v
                   | None -> "./") in
     let path = prefix^s in
     (match Parse.expr_of_filename "lisp" path with
      | Some e2 -> type_exp env e2
      | _ -> failwith "type_exp|EImport|cannot parse")

  | EVar id ->
     begin
       try
         specialisation (List.assoc id env), env
       with Not_found ->
         raise(Erreur("Unbound value "^id))
     end

  | EBool b -> type_bool, env

  | EInt n -> type_int, env

  | EUnit () -> type_nil, env

  | ECons(e1, e2) ->
     let type_e1, _ = type_exp env e1 in
     let type_e2, _ = type_exp env e2 in
     unifie (type_liste type_e1) type_e2 e2;
     type_e2, env

  | ECar(e1) ->
     let type_e1, env2 = type_exp env e1 in
     let type_element = nouvelle_inconnue() in
     unifie (type_liste type_element) type_e1 e1;
     (type_liste type_element) , env

  | ECdr(e1) ->
     let type_e1, env2 = type_exp env e1 in
     let type_element = nouvelle_inconnue() in
     unifie (type_liste type_element) type_e1 e1;
     (type_liste type_element) , env

  | EBegin (e::[]) -> type_exp env e

  | EBegin (e::rest) ->
     let type_e, env' = type_exp env e in
     let type_rest, env'' = type_exp env' (EBegin rest) in
     type_rest, env''

  | EHostCall (_, _) -> type_nil, env

  | EEval e -> type_exp env e

  | ELet((nom,expr)::[], body, _) ->
     let _, env' = type_def env false nom expr in
     type_exp env' body

  | EDefine(nom, expr) ->
     type_def env true nom expr

  | EString (_) -> type_string, env

  | EBinary(OPlus, e1, e2) | EBinary(OMinus, e1,e2) ->
     let type_e1, _ = type_exp env e1 in
     let type_e2, _ = type_exp env e2 in
     unifie type_int type_e1 e1;
     unifie type_int type_e2 e2;
     type_int, env

  | ELambda (id::id'::rest, [], expr) ->
     let type_argument = nouvelle_inconnue() in
     let env_etendu = (id, schema_trivial type_argument) :: env in
     let type_rest, env_rest = type_exp env_etendu (ELambda (id'::rest, [], expr)) in
     type_fleche type_argument type_rest, env_rest

  | ELambda (id::[], [], expr) ->
     let type_argument = nouvelle_inconnue()
     and type_resultat = nouvelle_inconnue() in
     let env_etendu = (id, schema_trivial type_argument) :: env in
     let type_expr, _ = type_exp env_etendu expr in
     unifie type_resultat type_expr expr;
     type_fleche type_argument type_resultat, env_etendu

  | ELambda ([], [], expr) ->
     let type_argument = type_nil
     and type_resultat = nouvelle_inconnue() in
     let type_expr, _ = type_exp env expr in
     unifie type_resultat type_expr expr;
     type_fleche type_argument type_resultat, env

  | EApp (fonction, argument::[], []) ->
     let type_fonction, _ = type_exp env fonction in
     let type_argument, _ = type_exp env argument in
     let type_resultat = nouvelle_inconnue() in
     unifie type_fonction (type_fleche type_argument type_resultat) fonction;
     type_resultat, env

  | EApp (fonction, argument::[], []) ->
     let type_fonction, _ = type_exp env fonction in
     let type_argument, _ = type_exp env argument in
     let type_resultat = nouvelle_inconnue() in
     unifie type_fonction (type_fleche type_argument type_resultat) fonction;
     type_resultat, env

  | _ as e -> failwith ("ERROR|type_exp|not implemented|"^(string_of_expr e))
     
     
and type_def env recursive nom expr =
  debut_de_definition();
  let type_expr, _ =
    match recursive with
      false -> type_exp env expr
    | true ->
       let type_provisoire = nouvelle_inconnue() in
       let type_expr, _ =
         type_exp ((nom, schema_trivial type_provisoire) :: env)
           expr in
       unifie type_provisoire type_expr expr;
       type_expr, env in
  fin_de_definition();
  type_expr, (nom, generalisation type_expr) :: env


