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


let type_of e = 
  let rec type_of_aux env e =
  match e with
  | EInt _ -> TyInt, env
  | _ -> failwith ("ERROR|type_of|not implemented yet|"^(string_of_expr e))
  in
  let ty, _ = type_of_aux [] e in
  ty

let rec string_of_ty ty = match ty with
  | TyVar s -> s
  | _ -> failwith ("ERROR|string_of_ty|not implemented yet|"^(string_of_ty ty))
