open Value

let extend_env id r env = (id, r)::env

let rec get_env id env =
    match env with
    | [] -> failwith ("get_env: binding not found: "^id)
    | (id', r)::rest ->
       if id = id' then r else get_env id rest
				       
