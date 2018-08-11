open Expr

type value = 
  | VUnit of unit
  | VInt of int
  | VBool of bool
  | VString of string
  | VChar of char
  | VClosure of env * expr
  | VCont of cont
  | VList of value list
  | VExpr of expr
  | VFile of Unix.file_descr
  | VInetAddr of Unix.inet_addr
  | VSockAddr of Unix.sockaddr
  | VShutdownCommand of Unix.shutdown_command
  | VChannelIn of in_channel
  | VChannelOut of out_channel
  | VThread of Thread.t
  | VSslProtocol of Ssl.protocol
  | VSslSocket of Ssl.socket
  | VSslCertificate of Ssl.certificate
		
 and env = (string * value ref) list

 and mem = (value ref * value) list
			       
 and cont = value  -> env -> mem -> value
