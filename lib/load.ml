open Expr

let load_scheme_string s = 
  EEval (EHostCall ("Parse.parse_scheme", EList([EString s])))

let load_scheme_file f = 
  load_scheme_string (Core.In_channel.read_all f)
