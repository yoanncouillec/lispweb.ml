open Expr

module Pervasives = struct

  let string_of_int = function
    | EList(((EInt(n))::[])) -> 
       EString(Stdlib.string_of_int n)
    | _ -> failwith "string_of_int: error"

  let string_of_val = function
    | EList(e::[]) -> 
       EString(Expr.string_of_expr e)
    | _ -> failwith "string_of_val: error"

  let int_of_string = function
    | EList(((EString(n))::[])) -> 
       EInt(Stdlib.int_of_string n)
    | _ -> failwith "error"

  (******)
  (* IO *)
  (******)

  let stdin = function
    | EList([]) -> 
       EChannelIn(Stdlib.stdin)
    | _ -> failwith "error"

  let stdout = function
    | EList([]) -> 
       EChannelOut(Stdlib.stdout)
    | _ -> failwith "error"

  let stderr = function
    | EList([]) -> 
       EChannelOut(Stdlib.stderr)
    | _ -> failwith "error"

  (* Output functions on standard output *)
		    
  let print_char = function
    | EList(((EChar(c))::[])) ->
       EUnit (Stdlib.print_char c)
    | _ -> failwith "print_char"

  let print_string = function
    | EList(((EString(s))::[])) ->
       EUnit (Stdlib.print_string s)
    | _ -> failwith "print_string"

  let print_endline = function
    | EList(e::[]) ->
       EUnit (Stdlib.print_endline (string_of_expr e))
    | _ as e -> failwith ("error print_endline: "^(string_of_expr e))

  let print_newline = function
    | EList([]) ->
       EUnit (Stdlib.print_newline())
    | _ -> failwith "print_newline"

  (* Input functions on standard input *)

  let read_line = function
    | EList([]) ->
       EString (Stdlib.read_line())
    | _ -> failwith "read_line"

  let read_int = function
    | EList([]) ->
       EInt (Stdlib.read_int())
    | _ -> failwith "read_int"

  (* General output functions *)

  let open_out = function
    | EList(((EString(s))::[])) ->
       EChannelOut (Stdlib.open_out s)
    | _ -> failwith "open_out"
		    
  let open_out_bin = function
    | EList(((EString(s))::[])) ->
       EChannelOut (Stdlib.open_out_bin s)
    | _ -> failwith "open_out_bin"

  let flush = function
    | EList(((EChannelOut(oc))::[])) ->
       EUnit (Stdlib.flush oc)
    | _ -> failwith "flush"

  let output_char = function
    | EList(((EChannelOut(oc))::(EChar(c))::[])) ->
       EUnit (Stdlib.output_char oc c)
    | _ -> failwith "output_char"

  let output_string = function
    | EList(((EChannelOut(oc))::(EString(s))::[])) ->
       EUnit (Stdlib.output_string oc s)
    | _ -> failwith "output_string"

  let close_out = function
    | EList(((EChannelOut(oc))::[])) ->
       EUnit (Stdlib.close_out oc)
    | _ -> failwith "close_out"
		    
  (* General input functions *)		    

  let open_in = function
    | EList(((EString(s))::[])) ->
       EChannelIn (Stdlib.open_in s)
    | _ -> failwith "open_in"

  let open_in_bin = function
    | EList(((EString(s))::[])) ->
       EChannelIn (Stdlib.open_in_bin s)
    | _ -> failwith "open_in_bin"

  let input_char = function
    | EList(((EChannelIn(ic))::[])) ->
       EChar(Stdlib.input_char ic);
    | _ -> failwith "input_char"
		    
  let input_line = function
    | EList(((EChannelIn(ic))::[])) ->
       (try
          EString(Stdlib.input_line ic);
        with End_of_file ->
              EString "end-of-file")
    | _ as params ->
       EString("wrong-parameters")
		    
  let close_in = function
    | EList(((EChannelIn(c))::[])) ->
       EUnit (Stdlib.close_in c)
    | _ -> failwith "close_in"

end
		
module LUnix = struct
  
  let stdin = function
    | EList(([])) -> 
       EFile(Unix.stdin)
    | _ -> failwith "unix_stdin"
		    
  let stdout = function
    | EList(([])) -> 
       EFile(Unix.stdout)
    | _ -> failwith "unix_stdout"
		    
  let stderr = function
    | EList(([])) -> 
       EFile(Unix.stderr)
    | _ -> failwith "unix_stderr"

  let flag_of_string_value = function
    | EString ("O_RDONLY") -> Unix.O_RDONLY
    | EString ("O_WRONLY") -> Unix.O_WRONLY
    | EString ("O_CREAT") -> Unix.O_CREAT
    | EString ("O_RDWR") -> Unix.O_RDWR
    | _ -> failwith "flag_of_string_value: not managed"

  exception Wrong_arguments
  
  let openfile f =
      match f with
      | EList(((EString(name))::(EList(flags))::(EString(perm))::[])) ->
         (try
            (EFile (Unix.openfile
		      name 
		      (List.map flag_of_string_value flags)
		      (int_of_string perm)))
          with Unix.Unix_error(Unix.ENOENT, "open", name) as e ->
                EString "no-such-file")
      | _ as args ->
         print_endline (string_of_expr args);
         EString "wrong-arguments"
  
  let close = function
    | EList(((EFile(fd))::[])) -> 
       EUnit (Unix.close fd)
    | _ -> failwith "unix_close"
		    
  let read = function
    | EList(((EFile(fd))::(EBytes(buff))::(EInt(ofs))::(EInt(len))::[])) -> 
       EInt(Unix.read fd buff ofs len)
      | _ -> failwith "unix_read"
		    
  let write = function
    | EList(((EFile(fd))::(EBytes(b))::(EInt(ofs))::(EInt(len))::[])) -> 
       EInt(Unix.write fd b ofs len)
    | _ -> failwith "unix_write"

  let write_substring e = match e with
    | EList(((EFile(fd))::(EString(s))::(EInt(ofs))::(EInt(len))::[])) -> 
       EInt(Unix.write_substring fd s ofs len)
    | _ -> failwith ("unix_write_substring"^(string_of_expr e))
		    		    
  let in_channel_of_descr = function
    | EList(((EFile(fd))::[])) ->
       EChannelIn(Unix.in_channel_of_descr fd);
    | _ -> failwith "in_channel_of_descr"
		    
  let out_channel_of_descr = function
    | EList(((EFile(fd))::[])) ->
       EChannelOut(Unix.out_channel_of_descr fd);
    | _ -> failwith "out_channel_of_descr"

  let domain_of_sockaddr = function
    | EList ((ESockAddr(sockaddr)::[])) ->
       ESockDomain(Unix.domain_of_sockaddr sockaddr)
    | _ -> failwith "domain of sockaddr: wrong arguments"
		    
  let domain_of_string = function
    | "PF_UNIX" -> Unix.PF_UNIX
    | "PF_INET" -> Unix.PF_INET
    | "PF_INET6" -> Unix.PF_INET6
    | _ -> failwith "domain_of_string"
		    
  let string_of_domain = function
    | EList(((ESockDomain(domain))::[])) ->
       EString 
         ((match domain with
           | Unix.PF_UNIX -> "PF_UNIX"
           | Unix.PF_INET -> "PF_INET"
           | Unix.PF_INET6 -> "PF_INET6"))
    | _ -> failwith "string_of_domain"
		    
  let socket_type_of_string = function
    | "SOCK_STREAM" -> Unix.SOCK_STREAM
    | "SOCK_DGRAM" -> Unix.SOCK_DGRAM
    | "SOCK_RAW" -> Unix.SOCK_RAW
    | "SOCK_SEQPACKET" -> Unix.SOCK_SEQPACKET
    | _ -> failwith "domain_of_string"
		    
  let shutdown_command_of_string = function
    | "SHUTDOWN_SEND" -> Unix.SHUTDOWN_SEND
    | "SHUTDOWN_RECEIVE" -> Unix.SHUTDOWN_RECEIVE
    | "SHUTDOWN_ALL" -> Unix.SHUTDOWN_ALL
    | _ -> failwith "domain_of_string"
		    
  let socket_bool_option_of_string = function
    | "SO_REUSEADDR" -> Unix.SO_REUSEADDR
    | _ -> failwith "to be implemented"
		    
  let inet_addr_of_sockaddr = function
      EList(((ESockAddr(sockaddr))::[])) ->
       (match sockaddr with
        | Unix.ADDR_INET (n, _) -> EInetAddr(n)
        | Unix.ADDR_UNIX _ -> EInetAddr(Unix.inet_addr_any))
    | _ -> failwith "wrong arguments"

  let inet_addr_any = function
    | EList(([])) ->
       EInetAddr(Unix.inet_addr_any)
    | _ -> failwith "unix_inet_addr_any"
		    
  let inet_addr_loopback = function
    | EList(([])) ->
       EInetAddr(Unix.inet_addr_loopback)
    | _ -> failwith "unix_inet_addr_loopback"
		    
  let inet6_addr_any = function
    | EList(([])) ->
       EInetAddr(Unix.inet6_addr_any)
    | _ -> failwith "unix_inet6_addr_any"
		    
  let inet6_addr_loopback = function
    | EList(([])) ->
       EInetAddr(Unix.inet6_addr_loopback)
    | _ -> failwith "unix_inet6_addr_loopback"
		    
  let addr_unix = function
    | EList(((EString(name))::[])) ->
       ESockAddr(Unix.ADDR_UNIX name)
    | _ -> failwith "unix_addr_unix"
		    
  let addr_inet e = match e with
    | EList(((EInetAddr(addr))::(EInt(port))::[])) ->
       ESockAddr(Unix.ADDR_INET(addr, port))
    | _ -> failwith ("unix_addr_inet: "^(string_of_expr e))
	
  let socket = function
    | EList(((EString(domain))::(EString(stype))::(EInt(protocol))::[])) ->
       (EFile (Unix.socket (domain_of_string domain) (socket_type_of_string stype) protocol))
    | _ as e -> failwith ("unix_socket: arguments are wrong: "^(string_of_expr e))
		    
  let connect = function
    | EList(((EFile(fd))::(ESockAddr(saddr))::[])) ->
       EUnit (Unix.connect fd saddr)
    | _ -> failwith "unix_connect"
		    
  let bind e = match e with
    | EList(((EFile(fd))::(ESockAddr(saddr))::[])) ->
       EUnit (Unix.bind fd saddr)
    | _ -> failwith ("unix_bind:"^(string_of_expr e))
		    
  let accept = function
    | EList(((EFile(fd))::[])) ->
       let (fd,saddr) = Unix.accept fd in
       EList((EFile(fd))::(ESockAddr(saddr)::[]))
    | _ -> failwith "unix_accept"
		    
  let listen = function
    | EList(((EFile(fd))::(EInt(n))::[])) ->
       EUnit (Unix.listen fd n)
    | _ -> failwith "unix_listen"
		    
  let shutdown = function
    | EList(((EFile(fd))::(EString(sc))::[])) ->
       EUnit (Unix.shutdown fd (shutdown_command_of_string sc))
    | _ -> failwith "unix_shutdown"

  let setsockopt = function
    | EList(((EFile(fd))::(EString(sbo))::(EBool(_,b))::[])) ->
       EUnit (Unix.setsockopt fd (socket_bool_option_of_string sbo) b)
    | _ -> failwith "unix_shutdown"

end

module Bytes = struct

  let bytes_of_string e = match e with
    |  EList(((EString(s))::[])) ->
	EBytes(Bytes.of_string s)
    | _ -> failwith ("Bytes.bytes_of_string: wrong arguments: "^(string_of_expr e))
  
  let bytes_to_string = function
    |  EList(((EBytes(b))::[])) ->
	EString(Bytes.to_string b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_create = function
    |  EList(((EInt(n))::[])) ->
	EBytes(Bytes.create n)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_make = function
    |  EList(((EInt(n))::(EChar(c))::[])) ->
	EBytes(Bytes.make n c)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_to_string = function
    |  EList(((EBytes(b))::[])) ->
	EString(Bytes.to_string b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_length = function
    |  EList(((EBytes(b))::[])) ->
	EInt(Bytes.length b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_get = function
    |  EList(((EBytes(b))::(EInt(n))::[])) ->
	EChar(Bytes.get b n)
    | _ -> failwith "wrong arguments"		    
  
end

module HString = struct
  
  let make = function
    |  EList(((EInt(n))::(EChar(c))::[])) ->
	EString(String.make n c)
    | _ -> failwith "string_make"		    
		    
  let length = function
    |  EList(((EString(s))::[])) ->
	EInt(String.length s)
    | _ as e -> failwith ("string_length: wrong arguments: "^(string_of_expr e))
		    
  let get = function
    |  EList(((EString(s))::(EInt(n))::[])) ->
	EChar(String.get s n)
    | _ -> failwith "string_get"
		    		    
  let sub = function
    |  EList(((EString(s))::(EInt(ofs))::(EInt(len))::[])) ->
	EString(String.sub s ofs len)
    | _ -> failwith "string_sub"
		    		    
  let concat = function
    |  EList(((EString(s))::(EList(l))::[])) ->
	EString(String.concat s (List.map (function EString (s') -> s'|_ -> failwith "Should be a string") l))
    | _ -> failwith "string_concat"
		    		    
end

module Str = struct

  let regexp = function
    | EList(((EString(s))::[])) ->
       ERegexp(Str.regexp(s))
    | _ -> failwith "regexp"

  let global_replace = function
    | EList(((ERegexp(old))::(EString(niou))::(EString(s))::[])) ->
       EString(Str.global_replace old niou s)
    | _ -> failwith "global_replace"
  
end

module Char = struct
  
  let char_to_string = function
    | EList(((EChar(c))::[])) ->
       EString(Char.escaped c)
    | _ -> failwith "char_to_string"
end
                
module Ssl = struct
  
  let init = function
    | EList(([])) ->
       EUnit((Ssl_threads.init();Ssl.init()))
    | _ -> failwith "Ssl.init"

  let protocol_v23 = function
    | EList(([])) ->
       ESslProtocol(Ssl.SSLv23)
    | _ -> failwith "wrong arguments"

  let context_type_server = function
    | EList(([])) ->
       ESslContextType(Ssl.Server_context)
    | _ -> failwith "wrong arguments"

  let open_connection = function
    | EList(((ESslProtocol(protocol))::(ESockAddr(sockaddr))::[])) ->
       ESslSocket(Ssl.open_connection protocol sockaddr)
    | _ -> failwith "wrong arguments"

  let get_certificate = function
    | EList(((ESslSocket(socket))::[])) ->
       ESslCertificate(Ssl.get_certificate socket)
    | _ -> failwith "wrong arguments"

  let get_cipher = function
    | EList(((ESslSocket(socket))::[])) ->
       ESslCipher(Ssl.get_cipher socket)
    | _ -> failwith "wrong arguments"

  let get_issuer = function
    | EList(((ESslCertificate(cert))::[])) ->
       EString(Ssl.get_issuer cert)
    | _ -> failwith "wrong arguments"

  let get_subject = function
    | EList(((ESslCertificate(cert))::[])) ->
       EString(Ssl.get_subject cert)
    | _ -> failwith "wrong arguments"

  let get_cipher_name = function
    | EList(((ESslCipher(cipher))::[])) ->
       EString(Ssl.get_cipher_name cipher)
    | _ -> failwith "wrong arguments"

  let get_cipher_version = function
    | EList(((ESslCipher(cipher))::[])) ->
       EString(Ssl.get_cipher_version cipher)
    | _ -> failwith "wrong arguments"

  let get_cipher_description = function
    | EList(((ESslCipher(cipher))::[])) ->
       EString(Ssl.get_cipher_description cipher)
    | _ -> failwith "wrong arguments"

  let write = function
    | EList(((ESslSocket(socket))::(EBytes(bytes))::(EInt(offset))::(EInt(length))::[])) ->
       EInt(Ssl.write socket bytes offset length)
    | _ -> failwith "wrong arguments"

  let read = function
    | EList(((ESslSocket(socket))::(EBytes(bytes))::(EInt(offset))::(EInt(length))::[])) ->
       let r = Ssl.read socket bytes offset length in
       EInt(r)
    | _ -> failwith "SSL.read: wrong arguments"

  let shutdown = function
    | EList(((ESslSocket(socket))::[])) ->
       EUnit(Ssl.shutdown socket)
    | _ -> failwith "wrong arguments"

  let create_context = function
    | EList(((ESslProtocol(protocol))::(ESslContextType(contextType))::[])) ->
       ESslContext(Ssl.create_context protocol contextType)
    | _ -> failwith "wrong arguments"

  let embed_socket = function
    | EList(((EFile(fd))::(ESslContext(ctx))::[])) ->
       ESslSocket(Ssl.embed_socket fd ctx)
    | _ -> failwith "wrong arguments"

  let accept e = match e with
    | EList(((ESslSocket(sock))::[])) ->
       EUnit(Ssl.accept sock)
    | _ -> failwith ("Ssl.accept: wrong arguments: "^(string_of_expr e))

  let use_certificate = function
    | EList(((ESslContext(context))::(EString(cert))::(EString(privkey))::[])) ->
       EUnit(Ssl.use_certificate context cert privkey)
    | _ -> failwith "wrong arguments"

  let set_password = function
    | EList(((ESslContext(ctx))::(EString(pwd))::[])) ->
       EUnit(Ssl.set_password_callback ctx (fun _ -> print_endline pwd ; pwd))
    | _ -> failwith "wrong arguments"

end

module Misc = struct

  let inet_addr_of_host_entry = function
    | EList(((EHostEntry(hostentry))::[])) ->
       EInetAddr(hostentry.h_addr_list.(0))
    | _ -> failwith "wrong arguments"

  let gethostbyname = function
    | EList(((EString(hostname))::[])) ->
       EHostEntry(Unix.gethostbyname hostname)
    | _ -> failwith "wrong arguments"
	    
end
                
(* module Thread = struct
 *   
 *   let create = function
 *     | VList(args) ->
 *        (match List.length args with
 *         | 2 ->
 *            (match List.nth args 0 with
 *             | VClosure(env,expr) ->
 *                let arg = List.nth args 1 in
 *                VThread(Thread.create
 * end *)

module HThread = struct

  let join = function
    | EList(((EThread(t))::[])) ->
       EUnit(Thread.join(t))
    | _ -> failwith "Thread.join: wrong arguments"
end

let functions = 
  [
    ("Pervasives.string_of_int", Pervasives.string_of_int);
    ("Pervasives.string_of_val", Pervasives.string_of_val);
    ("Pervasives.int_of_string", Pervasives.int_of_string);

    ("Pervasives.stdin", Pervasives.stdin);
    ("Pervasives.stdout", Pervasives.stdout);
    ("Pervasives.stderr", Pervasives.stderr);

    ("Pervasives.print_char", Pervasives.print_char);
    ("Pervasives.print_string", Pervasives.print_string);
    ("Pervasives.print_endline", Pervasives.print_endline);
    ("Pervasives.print_newline", Pervasives.print_newline);

    ("Pervasives.read_line", Pervasives.read_line);
    ("Pervasives.read_int", Pervasives.read_int);

    ("Pervasives.open_out", Pervasives.open_out);
    ("Pervasives.open_out_bin", Pervasives.open_out_bin);
    ("Pervasives.flush", Pervasives.flush);
    ("Pervasives.output_char", Pervasives.output_char);
    ("Pervasives.output_string", Pervasives.output_string);
    ("Pervasives.close_out", Pervasives.close_out);

    ("Pervasives.open_in", Pervasives.open_in);
    ("Pervasives.open_in_bin", Pervasives.open_in_bin);
    ("Pervasives.input_char", Pervasives.input_char);
    ("Pervasives.input_line", Pervasives.input_line);
    ("Pervasives.close_in", Pervasives.close_in);

    ("Unix.openfile", LUnix.openfile);
    ("Unix.close", LUnix.close);
    ("Unix.read", LUnix.read);
    ("Unix.write", LUnix.write);
    ("Unix.write_substring", LUnix.write_substring);
    ("Unix.stdin", LUnix.stdin);
    ("Unix.stdout", LUnix.stdout);
    ("Unix.stderr", LUnix.stderr);
    ("Unix.in_channel_of_descr", LUnix.in_channel_of_descr);
    ("Unix.out_channel_of_descr", LUnix.out_channel_of_descr);
    ("Unix.domain_of_sockaddr", LUnix.domain_of_sockaddr);
    ("Unix.string_of_domain", LUnix.string_of_domain);
    ("Unix.inet_addr_any", LUnix.inet_addr_any);
    ("Unix.inet_addr_loopback", LUnix.inet_addr_loopback);
    ("Unix.inet6_addr_any", LUnix.inet6_addr_any);
    ("Unix.inet6_addr_loopback", LUnix.inet6_addr_loopback);
    ("Unix.addr_unix", LUnix.addr_unix);
    ("Unix.addr_inet", LUnix.addr_inet);
    ("Unix.socket", LUnix.socket);
    ("Unix.connect", LUnix.connect);
    ("Unix.bind", LUnix.bind);
    ("Unix.accept", LUnix.accept);
    ("Unix.listen", LUnix.listen);
    ("Unix.shutdown", LUnix.shutdown);
    ("Unix.setsockopt", LUnix.setsockopt);
    ("Unix.inet_addr_of_sockaddr", LUnix.inet_addr_of_sockaddr);

    ("Bytes.of_string", Bytes.bytes_of_string);
    ("Bytes.to_string", Bytes.bytes_to_string);
    ("Bytes.create", Bytes.bytes_create);
    ("Bytes.make", Bytes.bytes_make);
    ("Bytes.to_string", Bytes.bytes_to_string);
    ("Bytes.length", Bytes.bytes_length);
    ("Bytes.get", Bytes.bytes_get);

    ("String.make", HString.make);
    ("String.length", HString.length);
    ("String.get", HString.get);
    ("String.sub", HString.sub);
    ("String.concat", HString.concat);

    ("Str.regexp", Str.regexp);
    ("Str.global_replace", Str.global_replace);

    ("Char.char_to_string", Char.char_to_string);

    ("Ssl.init", Ssl.init);
    ("Ssl.protocol_v23", Ssl.protocol_v23);
    ("Ssl.context_type_server", Ssl.context_type_server);
    ("Ssl.open_connection", Ssl.open_connection);
    ("Ssl.get_certificate", Ssl.get_certificate);
    ("Ssl.get_cipher", Ssl.get_cipher);
    ("Ssl.get_issuer", Ssl.get_issuer);
    ("Ssl.get_subject", Ssl.get_subject);
    ("Ssl.get_cipher_name", Ssl.get_cipher_name);
    ("Ssl.get_cipher_version", Ssl.get_cipher_version);
    ("Ssl.get_cipher_description", Ssl.get_cipher_description);
    ("Ssl.write", Ssl.write);
    ("Ssl.read", Ssl.read);
    ("Ssl.shutdown", Ssl.shutdown);
    ("Ssl.create_context", Ssl.create_context);
    ("Ssl.use_certificate", Ssl.use_certificate);
    ("Ssl.set_password", Ssl.set_password);
    ("Ssl.embed_socket", Ssl.embed_socket);
    ("Ssl.accept", Ssl.accept);

    ("Thread.join", HThread.join);

    ("Misc.inet_addr_of_host_entry", Misc.inet_addr_of_host_entry);
    ("Misc.gethostbyname", Misc.gethostbyname)

  ]
