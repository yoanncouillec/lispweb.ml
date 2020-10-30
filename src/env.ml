open Expr

type env_addr = 
  | EnvAddr of expr ref
  | EnvNotFound of string

let extend_env id r env = (id, r)::env

let rec get_env id env =
    match env with
    | [] -> EnvNotFound id
    | (id', r)::rest ->
       if id = id' then EnvAddr r else get_env id rest
				       
let start_with s2 s1 =
  (String.length s2 >= String.length s1)
  &&
    (String.compare
       (String.sub s2 0 (String.length s1))
       s1 == 0)

let rec env_start_with s env accu =
  match env with
  | [] -> accu
  | (id, _)::rest ->
     if start_with id s then
       env_start_with s rest (id::accu)
     else
       accu

