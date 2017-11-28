open Value

let extend_mem r v mem = (r, v)::mem

let rec get_mem r mem =
    match mem with
    | [] -> failwith "get_mem: binding not found"
    | (r', v)::rest ->
       if r == r' then v else get_mem r rest