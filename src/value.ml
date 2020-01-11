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
  | VSockDomain of Unix.socket_domain
  | VSockBoolOption of Unix.socket_bool_option
  | VShutdownCommand of Unix.shutdown_command
  | VChannelIn of in_channel
  | VChannelOut of out_channel
  | VThread of Thread.t
  | VSslProtocol of Ssl.protocol
  | VSslSocket of Ssl.socket
  | VSslCertificate of Ssl.certificate
  | VSslCipher of Ssl.cipher
  | VSslContextType of Ssl.context_type
  | VSslContext of Ssl.context
  | VBytes of Bytes.t
  | VHostEntry of Unix.host_entry	
	
 and env = (string * value ref) list

 and mem = (value ref * value) list
			       
 and cont = value  -> env -> mem -> value

let rec string_of_value = function
  | VUnit _ -> "()"
  | VInt n -> string_of_int n
  | VBool b -> string_of_bool b
  (*| VString s -> "\"" ^ s ^ "\""*)
  | VString s -> s
  | VChar c -> "'" ^ (String.make 1 c) ^ "'"
  | VClosure (_, e)-> "#CLOSURE"^(string_of_expr e)^")"
  | VCont _ -> "#CONT"
  | VList vs ->
     "(list"^(List.fold_left (fun acc e -> acc^" "^(string_of_value e)) "" vs)^")"
  | VExpr e -> "'" ^ (string_of_expr e)
  | VFile _ -> "#FILE"
  | VInetAddr _ -> "#INETADDR"
  | VSockAddr _ -> "#SOCKADDR"
  | VSockDomain _ -> "#SOCKDOMAIN"
  | VSockBoolOption _ -> "#SOCK_BOOL_OPTION"
  | VShutdownCommand _ -> "#SHUTDOWNCOMMAND"
  | VChannelIn _ -> "#INCHANNEL"
  | VChannelOut _ -> "#OUTCHANNEL"
  | VThread _ -> "Thread.t"
  | VSslProtocol _ -> "Ssl.protocol"
  | VSslSocket _ -> "Ssl.socket"
  | VSslCertificate _ -> "Ssl.certificate"
  | VSslCipher _ -> "Ssl.cipher"
  | VSslContextType _ -> "Ssl.context_type"
  | VSslContext _ -> "Ssl.context"
  | VBytes _ -> "#BYTES"
  | VHostEntry _ -> "Unix.host_entry"
