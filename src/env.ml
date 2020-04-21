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
				       
