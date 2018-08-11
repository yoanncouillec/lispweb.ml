(**
  * Like telnet ... but with ssl!
  *
  * @author Samuel Mimram
  *)

(* $Id$ *)

open Unix

let host = ref ""
let port = ref 9876
let parano = ref false


let usage = "usage: stelnet host [-p port]"


let _ =
  Arg.parse
    [
      "-p", Arg.Int (fun i -> port := i), "\tPort";
      "-w", Arg.Set parano, "\tParanoiac mode";
    ]
    (fun s -> host := s) usage;
  if !host = "" then (Printf.printf "%s\n\n" usage; exit 1);
  Ssl_threads.init ();
  Ssl.init ();
  let he =
    (
      try
        gethostbyname !host
      with
      | Not_found -> failwith "Host not found"
    )
  in
  let sockaddr = ADDR_INET(he.h_addr_list.(0), !port) in
  let ssl =
    if not !parano then
      Ssl.open_connection Ssl.SSLv23 sockaddr
    else
      (
        let ctx = Ssl.create_context Ssl.SSLv23 Ssl.Client_context in
          Ssl.set_verify ctx [Ssl.Verify_peer] (Some Ssl.client_verify_callback);
          Ssl.set_verify_depth ctx 3;
          Ssl.open_connection_with_context ctx sockaddr
      )
  in
  let cert = Ssl.get_certificate ssl in
  let cipher = Ssl.get_cipher ssl in
  let bufsize = 1024 in
  let buf = Bytes.create bufsize in
  let loop = ref true in
    Printf.printf "SSL connection ok.\n%!";
    Printf.printf "Certificate issuer:  %s\nsubject: %s\n%!" (Ssl.get_issuer cert) (Ssl.get_subject cert);
    Printf.printf "Cipher: %s (%s)\n%s\n%!" (Ssl.get_cipher_name cipher) (Ssl.get_cipher_version cipher) (Ssl.get_cipher_description cipher);
    Printf.printf "Type 'exit' to quit.\n\n%!";
    ignore
      (
        Thread.create
          (fun () ->
             let buf = Bytes.create bufsize in
               while !loop
               do
                 let r = Ssl.read ssl buf 0 bufsize in
                   Printf.printf "%s%!" (String.sub buf 0 r)
               done
          ) ()
      );
    while !loop
    do
      let r = Unix.read Unix.stdin buf 0 bufsize in
        if String.sub buf 0 4 = "exit" then
          loop := false;
        ignore (Ssl.write ssl buf 0 r);
    done;
    Ssl.shutdown ssl
