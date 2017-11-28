open Value

let flag_of_string_value = function
  | VString "O_CREAT" -> Unix.O_CREAT
  | VString "O_RDWR" -> Unix.O_RDWR
  | _ -> failwith "flag_of_string_value: not managed"

let unix_openfile = function
  | VList(VString(name)::VList(flags)::VString(perm)::[]) -> 
     (VFile (Unix.openfile
	       name 
	       (List.map flag_of_string_value flags)
	       (int_of_string perm)))
  | _ -> failwith "unix_openfile"

let unix_close = function
  | VList(VFile(fd)::[]) -> 
     Unix.close fd;
     VUnit
  | _ -> failwith "unix_close"
		  
let string_make = function
  |  VList(VInt(n)::VChar(c)::[]) ->
      VString(String.make n c)
  | _ -> failwith "string_make"
		  
let unix_read = function
  | VList(VFile(fd)::VString(buff)::VInt(ofs)::VInt(len)::[]) -> 
     VInt(Unix.read fd buff ofs len)
  | _ -> failwith "unix_read"

let unix_write = function
  | VList(VFile(fd)::VString(buff)::VInt(ofs)::VInt(len)::[]) -> 
     VInt(Unix.write fd buff ofs len)
  | _ -> failwith "unix_write"

let functions = 
  [
    ("Unix.openfile", unix_openfile);
    ("Unix.close", unix_close);
    ("Unix.read", unix_read);
    ("Unix.write", unix_write);
    ("String.make", string_make)
  ]
