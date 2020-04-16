open Value

module Pervasives = struct

  let string_of_int = function
    | VList(VInt(n)::[]) -> 
       VString(Pervasives.string_of_int n)
    | _ -> failwith "string_of_int: error"

  let string_of_val = function
    | VList(v::[]) -> 
       VString(Value.string_of_value v)
    | _ -> failwith "string_of_val: error"

  let int_of_string = function
    | VList(VString(n)::[]) -> 
       VInt(Pervasives.int_of_string n)
    | _ -> failwith "error"

  (******)
  (* IO *)
  (******)

  let stdin = function
    | VList([]) -> 
       VChannelIn(Pervasives.stdin)
    | _ -> failwith "error"

  let stdout = function
    | VList([]) -> 
       VChannelOut(Pervasives.stdout)
    | _ -> failwith "error"

  let stderr = function
    | VList([]) -> 
       VChannelOut(Pervasives.stderr)
    | _ -> failwith "error"

  (* Output functions on standard output *)
		    
  let print_char = function
    | VList(VChar(c)::[]) ->
       VUnit (Pervasives.print_char c)
    | _ -> failwith "print_char"

  let print_string = function
    | VList(VString(s)::[]) ->
       VUnit (Pervasives.print_string s)
    | _ -> failwith "print_string"

  let print_endline = function
    | VList(v::[]) ->
       VUnit (Pervasives.print_endline (string_of_value v))
    | _ as v -> failwith ("error print_endline: "^(string_of_value v))

  let print_newline = function
    | VList([]) ->
       VUnit (Pervasives.print_newline())
    | _ -> failwith "print_newline"

  (* Input functions on standard input *)

  let read_line = function
    | VList([]) ->
       VString (Pervasives.read_line())
    | _ -> failwith "read_line"

  let read_int = function
    | VList([]) ->
       VInt (Pervasives.read_int())
    | _ -> failwith "read_int"

  (* General output functions *)

  let open_out = function
    | VList(VString(s)::[]) ->
       VChannelOut (Pervasives.open_out s)
    | _ -> failwith "open_out"
		    
  let open_out_bin = function
    | VList(VString(s)::[]) ->
       VChannelOut (Pervasives.open_out_bin s)
    | _ -> failwith "open_out_bin"

  let flush = function
    | VList(VChannelOut(oc)::[]) ->
       VUnit (Pervasives.flush oc)
    | _ -> failwith "flush"

  let output_char = function
    | VList(VChannelOut(oc)::VChar(c)::[]) ->
       VUnit (Pervasives.output_char oc c)
    | _ -> failwith "output_char"

  let output_string = function
    | VList(VChannelOut(oc)::VString(s)::[]) ->
       VUnit (Pervasives.output_string oc s)
    | _ -> failwith "output_string"

  let close_out = function
    | VList(VChannelOut(oc)::[]) ->
       VUnit (Pervasives.close_out oc)
    | _ -> failwith "close_out"
		    
  (* General input functions *)		    

  let open_in = function
    | VList(VString(s)::[]) ->
       VChannelIn (Pervasives.open_in s)
    | _ -> failwith "open_in"

  let open_in_bin = function
    | VList(VString(s)::[]) ->
       VChannelIn (Pervasives.open_in_bin s)
    | _ -> failwith "open_in_bin"

  let input_char = function
    | VList(VChannelIn(ic)::[]) ->
       VChar(Pervasives.input_char ic);
    | _ -> failwith "input_char"
		    
  let input_line = function
    | VList(VChannelIn(ic)::[]) ->
       VString(Pervasives.input_line ic);
    | _ as params -> failwith ("input_line expecting a VChannelIn. Got "^(string_of_value params))
		    
  let close_in = function
    | VList(VChannelIn(c)::[]) ->
       VUnit (Pervasives.close_in c)
    | _ -> failwith "close_in"

end
		
module LUnix = struct
  
  let stdin = function
    | VList([]) -> 
       VFile(Unix.stdin)
    | _ -> failwith "unix_stdin"
		    
  let stdout = function
    | VList([]) -> 
       VFile(Unix.stdout)
    | _ -> failwith "unix_stdout"
		    
  let stderr = function
    | VList([]) -> 
       VFile(Unix.stderr)
    | _ -> failwith "unix_stderr"

  let flag_of_string_value = function
    | VString "O_RDONLY" -> Unix.O_RDONLY
    | VString "O_WRONLY" -> Unix.O_WRONLY
    | VString "O_CREAT" -> Unix.O_CREAT
    | VString "O_RDWR" -> Unix.O_RDWR
    | _ -> failwith "flag_of_string_value: not managed"
		    
  let openfile = function
    | VList(VString(name)::VList(flags)::VString(perm)::[]) -> 
       (VFile (Unix.openfile
		 name 
		 (List.map flag_of_string_value flags)
		 (int_of_string perm)))
    | _ -> failwith "unix_openfile"
		    
  let close = function
    | VList(VFile(fd)::[]) -> 
       VUnit (Unix.close fd)
    | _ -> failwith "unix_close"
		    
  let read = function
    | VList(VFile(fd)::rest) ->
       (match rest with
	| VBytes(buff)::rest ->
	   (match rest with
	    | VInt(ofs)::rest->
	       (match rest with 
		| VInt(len)::rest -> 
		   (match rest with 
		    | [] -> VInt(Unix.read fd buff ofs len)
		    | _ -> failwith "unix_read: wrong number of arguments: 4 expected")
		| _ -> failwith "unix_read: 4th argument must be an integer")
	    | _ -> failwith ("unix_read: 3th argument must be an integer: "^(string_of_value (List.hd rest))))
	| _ -> failwith "unix_read: 2nd argument must be a string")
    | _ -> failwith "unix_read: 1st argument must be a file descriptor"
		    
  let write_bytes = function
    | VList(VFile(fd)::VBytes(b)::VInt(ofs)::VInt(len)::[]) -> 
       VInt(Unix.write fd b ofs len)
    | _ -> failwith "unix_write_bytes"

  let write_substring = function
    | VList(VFile(fd)::VString(s)::VInt(ofs)::VInt(len)::[]) -> 
       VInt(Unix.write_substring fd s ofs len)
    | _ -> failwith "unix_write_substring"
		    		    
  let in_channel_of_descr = function
    | VList(VFile(fd)::[]) ->
       VChannelIn(Unix.in_channel_of_descr fd);
    | _ -> failwith "in_channel_of_descr"
		    
  let out_channel_of_descr = function
    | VList(VFile(fd)::[]) ->
       VChannelOut(Unix.out_channel_of_descr fd);
    | _ -> failwith "out_channel_of_descr"

  let domain_of_sockaddr = function
    | VList (VSockAddr(sockaddr)::[]) ->
       VSockDomain(Unix.domain_of_sockaddr sockaddr)
    | _ -> failwith "domain of sockaddr: wrong arguments"
		    
  let domain_of_string = function
    | "PF_UNIX" -> Unix.PF_UNIX
    | "PF_INET" -> Unix.PF_INET
    | "PF_INET6" -> Unix.PF_INET6
    | _ -> failwith "domain_of_string"
		    
  let string_of_domain = function
    | VList(VSockDomain(domain)::[]) ->
       VString 
         (match domain with
          | Unix.PF_UNIX -> "PF_UNIX"
          | Unix.PF_INET -> "PF_INET"
          | Unix.PF_INET6 -> "PF_INET6")
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
      VList(VSockAddr(sockaddr)::[]) ->
       (match sockaddr with
        | Unix.ADDR_INET (n, _) -> VInetAddr(n)
        | Unix.ADDR_UNIX _ -> VInetAddr(Unix.inet_addr_any))
    | _ -> failwith "wrong arguments"

  let inet_addr_any = function
    | VList([]) ->
       VInetAddr(Unix.inet_addr_any)
    | _ -> failwith "unix_inet_addr_any"
		    
  let inet_addr_loopback = function
    | VList([]) ->
       VInetAddr(Unix.inet_addr_loopback)
    | _ -> failwith "unix_inet_addr_loopback"
		    
  let inet6_addr_any = function
    | VList([]) ->
       VInetAddr(Unix.inet6_addr_any)
    | _ -> failwith "unix_inet6_addr_any"
		    
  let inet6_addr_loopback = function
    | VList([]) ->
       VInetAddr(Unix.inet6_addr_loopback)
    | _ -> failwith "unix_inet6_addr_loopback"
		    
  let addr_unix = function
    | VList(VString(name)::[]) ->
       VSockAddr(Unix.ADDR_UNIX name)
    | _ -> failwith "unix_addr_unix"
		    
  let addr_inet = function
    | VList(VInetAddr(addr)::VInt(port)::[]) ->
       VSockAddr(Unix.ADDR_INET(addr, port))
    | _ -> failwith "unix_addr_inet"
	
  let socket = function
    | VList(VString(domain)::VString(stype)::VInt(protocol)::[]) ->
       (VFile (Unix.socket (domain_of_string domain) (socket_type_of_string stype) protocol))
    | _ as v -> failwith ("unix_socket: arguments are wrong: "^(string_of_value v))
		    
  let connect = function
    | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
       VUnit (Unix.connect fd saddr)
    | _ -> failwith "unix_connect"
		    
  let bind = function
    | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
       VUnit (Unix.bind fd saddr)
    | _ -> failwith "unix_bind"
		    
  let accept = function
    | VList(VFile(fd)::[]) ->
       let (fd,saddr) = Unix.accept fd in
       VList(VFile(fd)::VSockAddr(saddr)::[])
    | _ -> failwith "unix_accept"
		    
  let listen = function
    | VList(VFile(fd)::VInt(n)::[]) ->
       VUnit (Unix.listen fd n)
    | _ -> failwith "unix_listen"
		    
  let shutdown = function
    | VList(VFile(fd)::VString(sc)::[]) ->
       VUnit (Unix.shutdown fd (shutdown_command_of_string sc))
    | _ -> failwith "unix_shutdown"

  let setsockopt = function
    | VList(VFile(fd)::VString(sbo)::VBool(b)::[]) ->
       VUnit (Unix.setsockopt fd (socket_bool_option_of_string sbo) b)
    | _ -> failwith "unix_shutdown"

end

module Bytes = struct

  let bytes_of_string = function
    |  VList(VString(s)::[]) ->
	VBytes(Bytes.of_string s)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_to_string = function
    |  VList(VBytes(b)::[]) ->
	VString(Bytes.to_string b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_create = function
    |  VList(VInt(n)::[]) ->
	VBytes(Bytes.create n)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_make = function
    |  VList(VInt(n)::VChar(c)::[]) ->
	VBytes(Bytes.make n c)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_to_string = function
    |  VList(VBytes(b)::[]) ->
	VString(Bytes.to_string b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_length = function
    |  VList(VBytes(b)::[]) ->
	VInt(Bytes.length b)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_get = function
    |  VList(VBytes(b)::VInt(n)::[]) ->
	VChar(Bytes.get b n)
    | _ -> failwith "wrong arguments"		    
  
end

module String = struct
  
  let make = function
    |  VList(VInt(n)::VChar(c)::[]) ->
	VString(String.make n c)
    | _ -> failwith "string_make"		    
		    
  let length = function
    |  VList(VString(s)::[]) ->
	VInt(String.length s)
    | _ as v -> failwith ("string_length: wrong arguments: "^(string_of_value v))
		    
  let get = function
    |  VList(VString(s)::VInt(n)::[]) ->
	VChar(String.get s n)
    | _ -> failwith "string_get"
		    		    
  let sub = function
    |  VList(VString(s)::VInt(ofs)::VInt(len)::[]) ->
	VString(String.sub s ofs len)
    | _ -> failwith "string_sub"
		    		    
  let concat = function
    |  VList(VString(s)::VList(l)::[]) ->
	VString(String.concat s (List.map (function VString s' -> s'|_ -> failwith "Should be a string") l))
    | _ -> failwith "string_concat"
		    		    
end

module Str = struct

  let regexp = function
    | VList(VString(s)::[]) ->
       VRegexp(Str.regexp(s))
    | _ -> failwith "regexp"

  let global_replace = function
    | VList(VRegexp(old)::VString(niou)::VString(s)::[]) ->
       VString(Str.global_replace old niou s)
    | _ -> failwith "global_replace"
  
end

module Char = struct
  
  let char_to_string = function
    | VList(VChar(c)::[]) ->
       VString(Char.escaped c)
    | _ -> failwith "char_to_string"
end
                
module Ssl = struct
  
  let init = function
    | VList([]) ->
       VUnit(Ssl_threads.init();Ssl.init())
    | _ -> failwith "Ssl.init"

  let protocol_v23 = function
    | VList([]) ->
       VSslProtocol(Ssl.SSLv23)
    | _ -> failwith "wrong arguments"

  let context_type_server = function
    | VList([]) ->
       VSslContextType(Ssl.Server_context)
    | _ -> failwith "wrong arguments"

  let open_connection = function
    | VList(VSslProtocol(protocol)::VSockAddr(sockaddr)::[]) ->
       VSslSocket(Ssl.open_connection protocol sockaddr)
    | _ -> failwith "wrong arguments"

  let get_certificate = function
    | VList(VSslSocket(socket)::[]) ->
       VSslCertificate(Ssl.get_certificate socket)
    | _ -> failwith "wrong arguments"

  let get_cipher = function
    | VList(VSslSocket(socket)::[]) ->
       VSslCipher(Ssl.get_cipher socket)
    | _ -> failwith "wrong arguments"

  let get_issuer = function
    | VList(VSslCertificate(cert)::[]) ->
       VString(Ssl.get_issuer cert)
    | _ -> failwith "wrong arguments"

  let get_subject = function
    | VList(VSslCertificate(cert)::[]) ->
       VString(Ssl.get_subject cert)
    | _ -> failwith "wrong arguments"

  let get_cipher_name = function
    | VList(VSslCipher(cipher)::[]) ->
       VString(Ssl.get_cipher_name cipher)
    | _ -> failwith "wrong arguments"

  let get_cipher_version = function
    | VList(VSslCipher(cipher)::[]) ->
       VString(Ssl.get_cipher_version cipher)
    | _ -> failwith "wrong arguments"

  let get_cipher_description = function
    | VList(VSslCipher(cipher)::[]) ->
       VString(Ssl.get_cipher_description cipher)
    | _ -> failwith "wrong arguments"

  let write = function
    | VList(VSslSocket(socket)::VBytes(bytes)::VInt(offset)::VInt(length)::[]) ->
       VInt(Ssl.write socket bytes offset length)
    | _ -> failwith "wrong arguments"

  let read = function
    | VList(VSslSocket(socket)::VBytes(bytes)::VInt(offset)::VInt(length)::[]) ->
       let r = Ssl.read socket bytes offset length in
       VInt(r)
    | _ -> failwith "wrong arguments"

  let shutdown = function
    | VList(VSslSocket(socket)::[]) ->
       VUnit(Ssl.shutdown socket)
    | _ -> failwith "wrong arguments"

  let create_context = function
    | VList(VSslProtocol(protocol)::VSslContextType(contextType)::[]) ->
       VSslContext(Ssl.create_context protocol contextType)
    | _ -> failwith "wrong arguments"

  let embed_socket = function
    | VList(VFile(fd)::VSslContext(ctx)::[]) ->
       VSslSocket(Ssl.embed_socket fd ctx)
    | _ -> failwith "wrong arguments"

  let accept = function
    | VList(VSslSocket(sock)::[]) ->
       VUnit(Ssl.accept sock)
    | _ -> failwith "wrong arguments"

  let use_certificate = function
    | VList(VSslContext(context)::VString(cert)::VString(privkey)::[]) ->
       VUnit(Ssl.use_certificate context cert privkey)
    | _ -> failwith "wrong arguments"

  let set_password = function
    | VList(VSslContext(ctx)::VString(pwd)::[]) ->
       VUnit(Ssl.set_password_callback ctx (fun _ -> print_endline pwd ; pwd))
    | _ -> failwith "wrong arguments"

end

module Misc = struct

  let inet_addr_of_host_entry = function
    | VList(VHostEntry(hostentry)::[]) ->
       VInetAddr(hostentry.h_addr_list.(0))
    | _ -> failwith "wrong arguments"

  let gethostbyname = function
    | VList(VString(hostname)::[]) ->
       VHostEntry(Unix.gethostbyname hostname)
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
 *                VThread(Thread.create)))
 * end *)

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
    ("Unix.write_bytes", LUnix.write_bytes);
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

    ("String.make", String.make);
    ("String.length", String.length);
    ("String.get", String.get);
    ("String.sub", String.sub);
    ("String.concat", String.concat);

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

    ("Misc.inet_addr_of_host_entry", Misc.inet_addr_of_host_entry);
    ("Misc.gethostbyname", Misc.gethostbyname)

  ]
