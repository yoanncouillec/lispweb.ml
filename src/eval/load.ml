let load_scheme_string s = 
  Expr.EEval (Expr.EHostCall ("Parse.parse_scheme", Expr.EList([EString s])))

let load_scheme_file f = 
  load_scheme_string (Core.In_channel.read_all f)
