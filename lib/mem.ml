let extend_mem r e mem = (r, e)::mem

let rec get_mem r mem =
    match mem with
    | [] -> failwith "get_mem: binding not found"
    | (r', e)::rest ->
       if r == r' then e else get_mem r rest
