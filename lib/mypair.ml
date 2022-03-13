type mypair = int * int

let make_pair x y = (x,y)
let first (x,_) = x
let second (_,y) = y
