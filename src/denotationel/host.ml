open Value

module File = struct
  
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
		    
  let unix_read = function
    | VList(VFile(fd)::VString(buff)::VInt(ofs)::VInt(len)::[]) -> 
       VInt(Unix.read fd buff ofs len)
    | _ -> failwith "unix_read"
		    
  let unix_write = function
    | VList(VFile(fd)::VString(buff)::VInt(ofs)::VInt(len)::[]) -> 
       VInt(Unix.write fd buff ofs len)
    | _ -> failwith "unix_write"
		    
  let unix_stdin = function
    | VList([]) -> 
       VFile(Unix.stdin)
    | _ -> failwith "unix_stdin"
		    
  let unix_stdout = function
    | VList([]) -> 
       VFile(Unix.stdout)
    | _ -> failwith "unix_stdout"
		    
  let unix_stderr = function
    | VList([]) -> 
       VFile(Unix.stderr)
    | _ -> failwith "unix_stderr"
		    
end

module Channel = struct
  
  let in_channel_of_descr = function
    | VList(VFile(fd)::[]) ->
       VInChannel(Unix.in_channel_of_descr fd);
    | _ -> failwith "in_channel_of_descr"
		    
  let out_channel_of_descr = function
    | VList(VFile(fd)::[]) ->
       VOutChannel(Unix.out_channel_of_descr fd);
    | _ -> failwith "out_channel_of_descr"
		    
  let input_line = function
    | VList(VInChannel(ic)::[]) ->
       VString(input_line ic);
    | _ -> failwith "input_line"
		    
  let output_string = function
    | VList(VOutChannel(oc)::VString(s)::[]) ->
       output_string oc s ;
       VUnit
    | _ -> failwith "output_string"
		    
  let flush = function
    | VList(VOutChannel(oc)::[]) ->
       flush oc ;
       VUnit
    | _ -> failwith "flush"
		    
  let close_out = function
    | VList(VOutChannel(oc)::[]) ->
       close_out oc ;
       VUnit
    | _ -> failwith "close_out"
		    
end

module Socket = struct
  
  let domain_of_string = function
    | "PF_UNIX" -> Unix.PF_UNIX
    | "PF_INET" -> Unix.PF_INET
    | "PF_INET6" -> Unix.PF_INET6
    | _ -> failwith "domain_of_string"
		    
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
    | _ -> failwith "unix_socket: arguments are wrong"
		    
  let connect = function
    | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
       Unix.connect fd saddr;
       VUnit
    | _ -> failwith "unix_connect"
		    
  let bind = function
    | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
       Unix.bind fd saddr;
       VUnit
    | _ -> failwith "unix_bind"
		    
  let accept = function
    | VList(VFile(fd)::[]) ->
       let (fd,saddr) = Unix.accept fd in
       VList(VFile(fd)::VSockAddr(saddr)::[])
    | _ -> failwith "unix_accept"
		    
  let listen = function
    | VList(VFile(fd)::VInt(n)::[]) ->
       Unix.listen fd n ;
       VUnit
    | _ -> failwith "unix_listen"
		    
  let shutdown = function
    | VList(VFile(fd)::VString(sc)::[]) ->
       Unix.shutdown fd (shutdown_command_of_string sc);
       VUnit
    | _ -> failwith "unix_shutdown"
		    
end
		
module String = struct
  
  let make = function
    |  VList(VInt(n)::VChar(c)::[]) ->
	VString(String.make n c)
    | _ -> failwith "string_make"		    
		    
  let length = function
    |  VList(VString(s)::[]) ->
	VInt(String.length s)
    | _ -> failwith "string_length"
		    
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

let functions = 
  [
    ("Unix.openfile", File.unix_openfile);
    ("Unix.close", File.unix_close);
    ("Unix.read", File.unix_read);
    ("Unix.write", File.unix_write);
    ("Unix.stdin", File.unix_stdin);
    ("Unix.stdout", File.unix_stdout);
    ("Unix.stderr", File.unix_stderr);

    ("Unix.in_channel_of_descr", Channel.in_channel_of_descr);
    ("Unix.out_channel_of_descr", Channel.out_channel_of_descr);
    ("Pervasives.input_line", Channel.input_line);
    ("Pervasives.output_string", Channel.output_string);
    ("Pervasives.flush", Channel.flush);
    ("Pervasives.close_out", Channel.close_out);

    ("Unix.inet_addr_any", Socket.inet_addr_any);
    ("Unix.inet_addr_loopback", Socket.inet_addr_loopback);
    ("Unix.inet6_addr_any", Socket.inet6_addr_any);
    ("Unix.inet6_addr_loopback", Socket.inet6_addr_loopback);
    ("Unix.addr_unix", Socket.addr_unix);
    ("Unix.addr_inet", Socket.addr_inet);
    ("Unix.socket", Socket.socket);
    ("Unix.connect", Socket.connect);
    ("Unix.bind", Socket.bind);
    ("Unix.accept", Socket.accept);
    ("Unix.listen", Socket.listen);
    ("Unix.shutdown", Socket.shutdown);

    ("String.make", String.make);
    ("String.length", String.length);
    ("String.get", String.get);
    ("String.sub", String.sub);
    ("String.concat", String.concat)
  ]
