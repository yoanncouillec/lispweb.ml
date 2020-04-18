open Expr

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
  | VRegexp _ -> "#REGEXP"
  | VHostEntry _ -> "Unix.host_entry"
