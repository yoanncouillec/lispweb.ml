open Expr

type env_addr = 
  | EnvAddr of expr ref
  | EnvNotFound of string

type top_cont = 
  | EnvTopContNotFound
  | EnvTopContFound of cont

let extend_env id r env =
  match id with Some s -> print_endline("extend_env("^s^")");
  (id, r)::env

let rec string_of_env2 = function
  | [] -> ""
  | (Some s,_)::rest -> "["^s^"->_]"^(string_of_env2 rest)

let rec get_env id env =
  print_endline("get_env("^id^", "^(string_of_env2 env)^")");
    match env with
    | [] -> EnvNotFound id
    | (Some(id'), r)::rest ->
       if id = id' then EnvAddr r else get_env id rest
    | (None,_)::rest ->  get_env id rest

let rec get_env_top_cont env mem =
  match env with
  | [] -> EnvTopContNotFound
  | (_,addr)::rest->
     match Mem.get_mem addr mem with
     | ECont(cont) -> EnvTopContFound cont
     | _ -> get_env_top_cont rest mem

let start_with s2 s1 =
  (String.length s2 >= String.length s1)
  &&
    (String.compare
       (String.sub s2 0 (String.length s1))
       s1 == 0)

let rec get_env_start_with s env accu =
  match env with
  | [] -> accu
  | (Some(id), _)::rest ->
     if start_with id s then
       get_env_start_with s rest (id::accu)
     else
       get_env_start_with s rest accu
  | (None,_)::rest -> get_env_start_with s rest accu

let rec string_of_env mem = function
  | [] -> ""
  | (Some s,addr)::rest -> "("^s^","^(string_of_expr (Mem.get_mem addr mem))^")"

