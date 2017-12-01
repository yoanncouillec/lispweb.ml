open Expr

type value = 
  | VUnit
  | VInt of int
  | VBool of bool
  | VString of string
  | VChar of char
  | VClosure of env * string * expr
  | VCont of cont
  | VList of value list
  | VQuote of expr
  | VFile of Unix.file_descr
  | VInetAddr of Unix.inet_addr
  | VSockAddr of Unix.sockaddr
  | VShutdownCommand of Unix.shutdown_command
		
 and env = (string * value ref) list

 and mem = (value ref * value) list
			       
 and cont = value  -> env -> mem -> value
