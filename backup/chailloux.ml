open Expr

(***************)
(* 3th attempt *)
(***************)

type ty = 
| TInt
| TVar of string 
| TArrow of ty * ty
| TList of ty

type env = (string * ty) list

let rec string_of_ty = function
  | TInt -> "int"
  | TVar x -> x
  | TArrow (x,y) -> "(" ^ (string_of_ty x) ^ " -> " ^ (string_of_ty y) ^ ")"
  | TList ty1 -> (string_of_ty ty1)^" list"

let rec substitute (env : env) (ty : ty) : ty = match ty with
  | TInt -> TInt
  | TVar x  -> (try List.assoc x env with Not_found -> TVar x)
  | TArrow(ty1, ty2) -> TArrow (substitute env ty1, substitute env ty2)
  | TList(ty1) -> TList(substitute env ty1)
  
let compsubst (env1 : env) (env2 : env) = 
  (List.map (function (x, ty1) -> (x, substitute env1 ty1)) env2) @ env1;;

let rec occur (x : string) (ty : ty) : bool = match ty with
  | TInt -> false
  | TVar y -> y = x
  | TArrow(ty1, ty2) -> (occur x ty1) || (occur x ty2)
  | TList (ty1) -> occur x ty1

let rec unify (ty1 : ty) (ty2 : ty) : env = match ty1, ty2 with

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


let type_of (e: expr) : ty = 
  let rec type_of_aux (env : env) (e : expr) : (ty * env) =
    print_endline("type_of: "^(string_of_expr e));
    match e with
      
    | EInt n -> TInt, env

    | EVar x -> List.assoc x env , env

    | ELambda (x::[], _, body) -> 
       let type_argument = new_variable() in
       let env_etendu = (x, type_argument)::env in
       let type_body, env_body = type_of_aux env_etendu body in
       TArrow (type_argument, type_body), env_body

    | EApp(fonction, argument::[], _) ->
       let type_argument, env1 = type_of_aux env argument in
       let type_fonction, env2 = type_of_aux (List.map (function (x, ty_x) -> (x, substitute env1 ty_x)) env) fonction in
       let type_resultat = new_variable() in 
       let env3 = unify (substitute env2 type_fonction) (TArrow (type_argument, type_resultat))  in
       type_resultat, compsubst env3 (compsubst env2 env1)

    | EBegin (e::[]) -> type_of_aux env e

    | ECons (e1, e2) ->
       let type_e1, env1 = type_of_aux env e1 in
       let type_e2, env2 = type_of_aux (List.map (function (x, ty_x) -> (x, substitute env1 ty_x)) env) e2 in
       let env3 = unify (substitute env2 (TList type_e1)) type_e2 in
       type_e2, env3

    | ECar(e1) ->
       let type_e1, env1 = type_of_aux env e1 in
       let type_element = new_variable() in
       let env2 = unify (TList type_element) type_e1 in
       type_element, env2

    | EList([]) -> TList (new_variable()), env

    | _  -> failwith ("not implemented: "^(string_of_expr e))
  in
  let ty, _ = type_of_aux [] e in
  ty
