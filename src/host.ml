open Expr

module Pervasives = struct

  let string_of_int = function
    | EList(((EInt(n,_))::[]),p) -> 
       EString(Stdlib.string_of_int n,p)
    | _ -> failwith "string_of_int: error"

  let string_of_val = function
    | EList(e::[],p) -> 
       EString(Expr.string_of_expr e,p)
    | _ -> failwith "string_of_val: error"

  let int_of_string = function
    | EList(((EString(n,_))::[]),p) -> 
       EInt(Stdlib.int_of_string n,p)
    | _ -> failwith "error"

  (******)
  (* IO *)
  (******)

  let stdin = function
    | EList([],p) -> 
       EChannelIn(Stdlib.stdin,p)
    | _ -> failwith "error"

  let stdout = function
    | EList([],p) -> 
       EChannelOut(Stdlib.stdout,p)
    | _ -> failwith "error"

  let stderr = function
    | EList([],p) -> 
       EChannelOut(Stdlib.stderr,p)
    | _ -> failwith "error"

  (* Output functions on standard output *)
		    
  let print_char = function
    | EList(((EChar(c,_))::[]),p) ->
       EUnit (Stdlib.print_char c,p)
    | _ -> failwith "print_char"

  let print_string = function
    | EList(((EString(s,_))::[]),p) ->
       EUnit (Stdlib.print_string s,p)
    | _ -> failwith "print_string"

  let print_endline = function
    | EList(e::[],p) ->
       EUnit (Stdlib.print_endline (string_of_expr e),p)
    | _ as e -> failwith ("error print_endline: "^(string_of_expr e))

  let print_newline = function
    | EList([],p) ->
       EUnit (Stdlib.print_newline(),p)
    | _ -> failwith "print_newline"

  (* Input functions on standard input *)

  let read_line = function
    | EList([],p) ->
       EString (Stdlib.read_line(),p)
    | _ -> failwith "read_line"

  let read_int = function
    | EList([],p) ->
       EInt (Stdlib.read_int(),p)
    | _ -> failwith "read_int"

  (* General output functions *)

  let open_out = function
    | EList(((EString(s,_))::[]),p) ->
       EChannelOut (Stdlib.open_out s,p)
    | _ -> failwith "open_out"
		    
  let open_out_bin = function
    | EList(((EString(s,_))::[]),p) ->
       EChannelOut (Stdlib.open_out_bin s,p)
    | _ -> failwith "open_out_bin"

  let flush = function
    | EList(((EChannelOut(oc,_))::[]),p) ->
       EUnit (Stdlib.flush oc,p)
    | _ -> failwith "flush"

  let output_char = function
    | EList(((EChannelOut(oc,_))::(EChar(c,_))::[]),p) ->
       EUnit (Stdlib.output_char oc c,p)
    | _ -> failwith "output_char"

  let output_string = function
    | EList(((EChannelOut(oc,_))::(EString(s,_))::[]),p) ->
       EUnit (Stdlib.output_string oc s,p)
    | _ -> failwith "output_string"

  let close_out = function
    | EList(((EChannelOut(oc,_))::[]),p) ->
       EUnit (Stdlib.close_out oc,p)
    | _ -> failwith "close_out"
		    
  (* General input functions *)		    

  let open_in = function
    | EList(((EString(s,_))::[]),p) ->
       EChannelIn (Stdlib.open_in s,p)
    | _ -> failwith "open_in"

  let open_in_bin = function
    | EList(((EString(s,_))::[]),p) ->
       EChannelIn (Stdlib.open_in_bin s,p)
    | _ -> failwith "open_in_bin"

  let input_char = function
    | EList(((EChannelIn(ic,_))::[]),p) ->
       EChar(Stdlib.input_char ic,p);
    | _ -> failwith "input_char"
		    
  let input_line = function
    | EList(((EChannelIn(ic,_))::[]),p) ->
       EString(Stdlib.input_line ic,p);
    | _ as params -> failwith ("input_line expecting a EChannelIn. Got "^(string_of_expr params))
		    
  let close_in = function
    | EList(((EChannelIn(c,_))::[]),p) ->
       EUnit (Stdlib.close_in c,p)
    | _ -> failwith "close_in"

end
		
module LUnix = struct
  
  let stdin = function
    | EList(([]),p) -> 
       EFile(Unix.stdin,p)
    | _ -> failwith "unix_stdin"
		    
  let stdout = function
    | EList(([]),p) -> 
       EFile(Unix.stdout,p)
    | _ -> failwith "unix_stdout"
		    
  let stderr = function
    | EList(([]),p) -> 
       EFile(Unix.stderr,p)
    | _ -> failwith "unix_stderr"

  let flag_of_string_value = function
    | EString ("O_RDONLY",_) -> Unix.O_RDONLY
    | EString ("O_WRONLY",_) -> Unix.O_WRONLY
    | EString ("O_CREAT",_) -> Unix.O_CREAT
    | EString ("O_RDWR",_) -> Unix.O_RDWR
    | _ -> failwith "flag_of_string_value: not managed"
		    
  let openfile f =
    match f with
    | EList(((EString(name,_))::(EList(flags,_))::(EString(perm,_))::[]),p) ->
       (EFile (Unix.openfile
		 name 
		 (List.map flag_of_string_value flags)
		 (int_of_string perm),
               p))
    | _ -> failwith "unix_openfile"
		    
  let close = function
    | EList(((EFile(fd,_))::[]),p) -> 
       EUnit (Unix.close fd,p)
    | _ -> failwith "unix_close"
		    
  let read = function
    | EList(((EFile(fd,_))::(EBytes(buff,_))::(EInt(ofs,_))::(EInt(len,_))::[]),p) -> 
       EInt(Unix.read fd buff ofs len,p)
      | _ -> failwith "unix_read"
		    
  let write = function
    | EList(((EFile(fd,_))::(EBytes(b,_))::(EInt(ofs,_))::(EInt(len,_))::[]),p) -> 
       EInt(Unix.write fd b ofs len,p)
    | _ -> failwith "unix_write"

  let write_substring e = match e with
    | EList(((EFile(fd,_))::(EString(s,_))::(EInt(ofs,_))::(EInt(len,_))::[]),p) -> 
       EInt(Unix.write_substring fd s ofs len,p)
    | _ -> failwith ("unix_write_substring"^(string_of_expr e))
		    		    
  let in_channel_of_descr = function
    | EList(((EFile(fd,_))::[]),p) ->
       EChannelIn(Unix.in_channel_of_descr fd,p);
    | _ -> failwith "in_channel_of_descr"
		    
  let out_channel_of_descr = function
    | EList(((EFile(fd,_))::[]),p) ->
       EChannelOut(Unix.out_channel_of_descr fd,p);
    | _ -> failwith "out_channel_of_descr"

  let domain_of_sockaddr = function
    | EList ((ESockAddr(sockaddr,_)::[]),p) ->
       ESockDomain(Unix.domain_of_sockaddr sockaddr,p)
    | _ -> failwith "domain of sockaddr: wrong arguments"
		    
  let domain_of_string = function
    | "PF_UNIX" -> Unix.PF_UNIX
    | "PF_INET" -> Unix.PF_INET
    | "PF_INET6" -> Unix.PF_INET6
    | _ -> failwith "domain_of_string"
		    
  let string_of_domain = function
    | EList(((ESockDomain(domain,_))::[]),p) ->
       EString 
         ((match domain with
           | Unix.PF_UNIX -> "PF_UNIX"
           | Unix.PF_INET -> "PF_INET"
           | Unix.PF_INET6 -> "PF_INET6"),p)
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
      EList(((ESockAddr(sockaddr,_))::[]),p) ->
       (match sockaddr with
        | Unix.ADDR_INET (n, _) -> EInetAddr(n,p)
        | Unix.ADDR_UNIX _ -> EInetAddr(Unix.inet_addr_any,p))
    | _ -> failwith "wrong arguments"

  let inet_addr_any = function
    | EList(([]),p) ->
       EInetAddr(Unix.inet_addr_any,p)
    | _ -> failwith "unix_inet_addr_any"
		    
  let inet_addr_loopback = function
    | EList(([]),p) ->
       EInetAddr(Unix.inet_addr_loopback,p)
    | _ -> failwith "unix_inet_addr_loopback"
		    
  let inet6_addr_any = function
    | EList(([]),p) ->
       EInetAddr(Unix.inet6_addr_any,p)
    | _ -> failwith "unix_inet6_addr_any"
		    
  let inet6_addr_loopback = function
    | EList(([]),p) ->
       EInetAddr(Unix.inet6_addr_loopback,p)
    | _ -> failwith "unix_inet6_addr_loopback"
		    
  let addr_unix = function
    | EList(((EString(name,_))::[]),p) ->
       ESockAddr(Unix.ADDR_UNIX name,p)
    | _ -> failwith "unix_addr_unix"
		    
  let addr_inet = function
    | EList(((EInetAddr(addr,_))::(EInt(port,_))::[]),p) ->
       ESockAddr(Unix.ADDR_INET(addr, port),p)
    | _ -> failwith "unix_addr_inet"
	
  let socket = function
    | EList(((EString(domain,_))::(EString(stype,_))::(EInt(protocol,_))::[]),p) ->
       (EFile (Unix.socket (domain_of_string domain) (socket_type_of_string stype) protocol,p))
    | _ as e -> failwith ("unix_socket: arguments are wrong: "^(string_of_expr e))
		    
  let connect = function
    | EList(((EFile(fd,_))::(ESockAddr(saddr,_))::[]),p) ->
       EUnit (Unix.connect fd saddr,p)
    | _ -> failwith "unix_connect"
		    
  let bind e = match e with
    | EList(((EFile(fd,_))::(ESockAddr(saddr,_))::[]),p) ->
       EUnit (Unix.bind fd saddr,p)
    | _ -> failwith ("unix_bind:"^(string_of_expr e))
		    
  let accept = function
    | EList(((EFile(fd,_))::[]),p) ->
       let (fd,saddr) = Unix.accept fd in
       EList((EFile(fd,p))::(ESockAddr(saddr,p)::[]),p)
    | _ -> failwith "unix_accept"
		    
  let listen = function
    | EList(((EFile(fd,_))::(EInt(n,_))::[]),p) ->
       EUnit (Unix.listen fd n,p)
    | _ -> failwith "unix_listen"
		    
  let shutdown = function
    | EList(((EFile(fd,_))::(EString(sc,_))::[]),p) ->
       EUnit (Unix.shutdown fd (shutdown_command_of_string sc),p)
    | _ -> failwith "unix_shutdown"

  let setsockopt = function
    | EList(((EFile(fd,_))::(EString(sbo,_))::(EBool(b,_))::[]),p) ->
       EUnit (Unix.setsockopt fd (socket_bool_option_of_string sbo) b,p)
    | _ -> failwith "unix_shutdown"

end

module Bytes = struct

  let bytes_of_string = function
    |  EList(((EString(s,_))::[]),p) ->
	EBytes(Bytes.of_string s,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_to_string = function
    |  EList(((EBytes(b,_))::[]),p) ->
	EString(Bytes.to_string b,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_create = function
    |  EList(((EInt(n,_))::[]),p) ->
	EBytes(Bytes.create n,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_make = function
    |  EList(((EInt(n,_))::(EChar(c,_))::[]),p) ->
	EBytes(Bytes.make n c,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_to_string = function
    |  EList(((EBytes(b,_))::[]),p) ->
	EString(Bytes.to_string b,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_length = function
    |  EList(((EBytes(b,_))::[]),p) ->
	EInt(Bytes.length b,p)
    | _ -> failwith "wrong arguments"		    
  
  let bytes_get = function
    |  EList(((EBytes(b,_))::(EInt(n,_))::[]),p) ->
	EChar(Bytes.get b n,p)
    | _ -> failwith "wrong arguments"		    
  
end

module HString = struct
  
  let make = function
    |  EList(((EInt(n,_))::(EChar(c,_))::[]),p) ->
	EString(String.make n c,p)
    | _ -> failwith "string_make"		    
		    
  let length = function
    |  EList(((EString(s,_))::[]),p) ->
	EInt(String.length s,p)
    | _ as e -> failwith ("string_length: wrong arguments: "^(string_of_expr e))
		    
  let get = function
    |  EList(((EString(s,_))::(EInt(n,_))::[]),p) ->
	EChar(String.get s n,p)
    | _ -> failwith "string_get"
		    		    
  let sub = function
    |  EList(((EString(s,_))::(EInt(ofs,_))::(EInt(len,_))::[]),p) ->
	EString(String.sub s ofs len,p)
    | _ -> failwith "string_sub"
		    		    
  let concat = function
    |  EList(((EString(s,_))::(EList(l,_))::[]),p) ->
	EString(String.concat s (List.map (function EString (s',_) -> s'|_ -> failwith "Should be a string") l),p)
    | _ -> failwith "string_concat"
		    		    
end

module Str = struct

  let regexp = function
    | EList(((EString(s,_))::[]),p) ->
       ERegexp(Str.regexp(s),p)
    | _ -> failwith "regexp"

  let global_replace = function
    | EList(((ERegexp(old,_))::(EString(niou,_))::(EString(s,_))::[]),p) ->
       EString(Str.global_replace old niou s,p)
    | _ -> failwith "global_replace"
  
end

module Char = struct
  
  let char_to_string = function
    | EList(((EChar(c,_))::[]),p) ->
       EString(Char.escaped c,p)
    | _ -> failwith "char_to_string"
end
                
module Ssl = struct
  
  let init = function
    | EList(([]),p) ->
       EUnit((Ssl_threads.init();Ssl.init()),p)
    | _ -> failwith "Ssl.init"

  let protocol_v23 = function
    | EList(([]),p) ->
       ESslProtocol(Ssl.SSLv23,p)
    | _ -> failwith "wrong arguments"

  let context_type_server = function
    | EList(([]),p) ->
       ESslContextType(Ssl.Server_context,p)
    | _ -> failwith "wrong arguments"

  let open_connection = function
    | EList(((ESslProtocol(protocol,_))::(ESockAddr(sockaddr,_))::[]),p) ->
       ESslSocket(Ssl.open_connection protocol sockaddr,p)
    | _ -> failwith "wrong arguments"

  let get_certificate = function
    | EList(((ESslSocket(socket,_))::[]),p) ->
       ESslCertificate(Ssl.get_certificate socket,p)
    | _ -> failwith "wrong arguments"

  let get_cipher = function
    | EList(((ESslSocket(socket,_))::[]),p) ->
       ESslCipher(Ssl.get_cipher socket,p)
    | _ -> failwith "wrong arguments"

  let get_issuer = function
    | EList(((ESslCertificate(cert,_))::[]),p) ->
       EString(Ssl.get_issuer cert,p)
    | _ -> failwith "wrong arguments"

  let get_subject = function
    | EList(((ESslCertificate(cert,_))::[]),p) ->
       EString(Ssl.get_subject cert,p)
    | _ -> failwith "wrong arguments"

  let get_cipher_name = function
    | EList(((ESslCipher(cipher,_))::[]),p) ->
       EString(Ssl.get_cipher_name cipher,p)
    | _ -> failwith "wrong arguments"

  let get_cipher_version = function
    | EList(((ESslCipher(cipher,_))::[]),p) ->
       EString(Ssl.get_cipher_version cipher,p)
    | _ -> failwith "wrong arguments"

  let get_cipher_description = function
    | EList(((ESslCipher(cipher,_))::[]),p) ->
       EString(Ssl.get_cipher_description cipher,p)
    | _ -> failwith "wrong arguments"

  let write = function
    | EList(((ESslSocket(socket,_))::(EBytes(bytes,_))::(EInt(offset,_))::(EInt(length,_))::[]),p) ->
       EInt(Ssl.write socket bytes offset length,p)
    | _ -> failwith "wrong arguments"

  let read = function
    | EList(((ESslSocket(socket,_))::(EBytes(bytes,_))::(EInt(offset,_))::(EInt(length,_))::[]),p) ->
       let r = Ssl.read socket bytes offset length in
       EInt(r,p)
    | _ -> failwith "wrong arguments"

  let shutdown = function
    | EList(((ESslSocket(socket,_))::[]),p) ->
       EUnit(Ssl.shutdown socket,p)
    | _ -> failwith "wrong arguments"

  let create_context = function
    | EList(((ESslProtocol(protocol,_))::(ESslContextType(contextType,_))::[]),p) ->
       ESslContext(Ssl.create_context protocol contextType,p)
    | _ -> failwith "wrong arguments"

  let embed_socket = function
    | EList(((EFile(fd,_))::(ESslContext(ctx,_))::[]),p) ->
       ESslSocket(Ssl.embed_socket fd ctx,p)
    | _ -> failwith "wrong arguments"

  let accept e = match e with
    | EList(((ESslSocket(sock,_))::[]),p) ->
       EUnit(Ssl.accept sock,p)
    | _ -> failwith ("Ssl.accept: wrong arguments: "^(string_of_expr e))

  let use_certificate = function
    | EList(((ESslContext(context,_))::(EString(cert,_))::(EString(privkey,_))::[]),p) ->
       EUnit(Ssl.use_certificate context cert privkey,p)
    | _ -> failwith "wrong arguments"

  let set_password = function
    | EList(((ESslContext(ctx,_))::(EString(pwd,_))::[]),p) ->
       EUnit(Ssl.set_password_callback ctx (fun _ -> print_endline pwd ; pwd),p)
    | _ -> failwith "wrong arguments"

end

module Misc = struct

  let inet_addr_of_host_entry = function
    | EList(((EHostEntry(hostentry,_))::[]),p) ->
       EInetAddr(hostentry.h_addr_list.(0),p)
    | _ -> failwith "wrong arguments"

  let gethostbyname = function
    | EList(((EString(hostname,_))::[]),p) ->
       EHostEntry(Unix.gethostbyname hostname,p)
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
    | EList(((EThread(t,_))::[]),p) ->
       EUnit(Thread.join(t),p)
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
