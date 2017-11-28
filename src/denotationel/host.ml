open Value

let flag_of_string_value = function
  | VString "O_CREAT" -> Unix.O_CREAT
  | VString "O_RDWR" -> Unix.O_RDWR
  | _ -> failwith "flag_of_string_value: not managed"

let unix_openfile_exec = function
  | VList(VString(name)::VList(flags)::VString(perm)::[]) -> 
     (VFile (Unix.openfile
	       name 
	       (List.map flag_of_string_value flags)
	       (int_of_string perm)))
  | _ -> failwith "unix_openfile_exec"

let functions = 
  [("Unix.openfile", unix_openfile_exec)]

let string_of_vhost = function
  | VFile _ -> "#FILE"
