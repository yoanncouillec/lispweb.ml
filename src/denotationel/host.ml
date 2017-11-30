open Value

module Unix = struct
  
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
		    
  let unix_stdout = function
    | VList([]) -> 
       VFile(Unix.stdout)
    | _ -> failwith "unix_stdout"

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

    let unix_inet_addr_any = function
      | VList([]) ->
	 VInetAddr(Unix.inet_addr_any)
      | _ -> failwith "unix_inet_addr_any"
		      
    let unix_inet_addr_loopback = function
      | VList([]) ->
	 VInetAddr(Unix.inet_addr_loopback)
      | _ -> failwith "unix_inet_addr_loopback"
		      
    let unix_inet6_addr_any = function
      | VList([]) ->
	 VInetAddr(Unix.inet6_addr_any)
      | _ -> failwith "unix_inet6_addr_any"
		      
    let unix_inet6_addr_loopback = function
      | VList([]) ->
	 VInetAddr(Unix.inet6_addr_loopback)
      | _ -> failwith "unix_inet6_addr_loopback"
		      
    let unix_addr_unix = function
      | VList(VString(name)::[]) ->
	 VSockAddr(Unix.ADDR_UNIX name)
      | _ -> failwith "unix_addr_unix"
		      
    let unix_addr_inet = function
      | VList(VInetAddr(addr)::VInt(port)::[]) ->
	 VSockAddr(Unix.ADDR_INET(addr, port))
      | _ -> failwith "unix_addr_inet"
		      
    let unix_socket = function
      | VList(VString(domain)::VString(stype)::VInt(protocol)::[]) ->
	 (VFile (Unix.socket (domain_of_string domain) (socket_type_of_string stype) protocol))
      | _ -> failwith "unix_socket"

    let unix_connect = function
      | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
	 Unix.connect fd saddr;
	 VUnit
      | _ -> failwith "unix_connect"

    let unix_bind = function
      | VList(VFile(fd)::VSockAddr(saddr)::[]) ->
	 Unix.bind fd saddr;
	 VUnit
      | _ -> failwith "unix_bind"

    let unix_accept = function
      | VList(VFile(fd)::[]) ->
	 let (fd,saddr) = Unix.accept fd in
	 VList(VFile(fd)::VSockAddr(saddr)::[])
      | _ -> failwith "unix_accept"

    let unix_listen = function
      | VList(VFile(fd)::VInt(n)::[]) ->
	 Unix.listen fd n ;
	 VUnit
      | _ -> failwith "unix_accept"

    let unix_shutdown = function
      | VList(VFile(fd)::VShutdownCommand(sc)::[]) ->
	 Unix.shutdown fd sc;
	 VUnit
      | _ -> failwith "unix_accept"

  end

end
		
module String = struct
  
  let string_make = function
    |  VList(VInt(n)::VChar(c)::[]) ->
	VString(String.make n c)
    | _ -> failwith "string_make"		    
		    
  let string_length = function
    |  VList(VString(s)::[]) ->
	VInt(String.length s)
    | _ -> failwith "string_length"		    
		    
end
		  
let functions = 
  [
    ("Unix.openfile", Unix.unix_openfile);
    ("Unix.close", Unix.unix_close);
    ("Unix.read", Unix.unix_read);
    ("Unix.write", Unix.unix_write);
    ("Unix.stdout", Unix.unix_stdout);

    ("Unix.inet_addr_any", Unix.Socket.unix_inet_addr_any);
    ("Unix.inet_addr_loopback", Unix.Socket.unix_inet_addr_loopback);
    ("Unix.inet6_addr_any", Unix.Socket.unix_inet6_addr_any);
    ("Unix.inet6_addr_loopback", Unix.Socket.unix_inet6_addr_loopback);
    ("Unix.addr_unix", Unix.Socket.unix_addr_unix);
    ("Unix.addr_inet", Unix.Socket.unix_addr_inet);
    ("Unix.socket", Unix.Socket.unix_socket);
    ("Unix.connect", Unix.Socket.unix_connect);
    ("Unix.bind", Unix.Socket.unix_bind);
    ("Unix.accept", Unix.Socket.unix_accept);
    ("Unix.listen", Unix.Socket.unix_listen);
    ("Unix.shutdown", Unix.Socket.unix_shutdown);

    ("String.make", String.string_make);
    ("String.length", String.string_length)
  ]
