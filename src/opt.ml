type opt = (string * string option) list

let rec get_opt_value (opt:opt) (o:string) : string option =
  List.assoc o opt
