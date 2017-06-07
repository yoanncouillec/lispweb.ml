exception Div_by_zero

type expr_arith = 
  | EConst of int
  | EAdd of expr_arith * expr_arith
  | ESub of expr_arith * expr_arith
  | EMul of expr_arith * expr_arith
  | EDiv of expr_arith * expr_arith
  | EMod of expr_arith * expr_arith

type instr = 
  | IConst of int
  | IAdd
  | ISub
  | IMul
  | IDiv
  | IMod

type machine = int list * instr list

let rec compile = function
  | EConst n -> [IConst n]
  | EAdd (e1, e2) -> (compile e1) @ (compile e2) @ [IAdd]
  | ESub (e1, e2) -> (compile e1) @ (compile e2) @ [ISub]
  | EMul (e1, e2) -> (compile e1) @ (compile e2) @ [IMul]
  | EDiv (e1, e2) -> (compile e1) @ (compile e2) @ [IDiv]
  | EMod (e1, e2) -> (compile e1) @ (compile e2) @ [IMod]

let rec eval (stack, instructions) =
  match instructions with
    | [] -> List.hd stack
    | (IConst n) :: rest -> eval (n :: stack, rest)
    | _ as instr :: rest ->
	match stack with
	  | n2 :: n1 :: stack ->
	      begin
		match instr with
		  | IAdd -> eval ((n1 + n2) :: stack, rest)
		  | ISub -> eval ((n1 - n2) :: stack, rest)
                  | IMul -> eval ((n1 * n2) :: stack, rest)
                  | IDiv -> 
                    if n2 = 0 then raise Div_by_zero
                    else eval ((n1 / n2) :: stack, rest)
                  | IMod ->
                    if n2 = 0 then raise Div_by_zero
                    else eval ((n1 mod n2) :: stack, rest)
		  | _ -> failwith "Should not append"
	      end
	  | _ -> failwith "Should not append"

let expansion = function 
  | IConst n -> "pushq $" ^ (string_of_int n) ^ "\n"
  | IAdd -> "popq %rax\naddq (%rsp), %rax\n"
  | ISub -> "popq %rax\nsubq (%rsp), %rax\n"
  | IMul -> "popq %rax\nmulq (%rsp), %rax\n"
  | IDiv -> "popq %rax\ndivq (%rsp), %rax\n"
  | IMod -> "popq %rax\nmodq (%rsp), %rax\n"

let rec string_of_expr_arith = function
  | EConst n -> string_of_int n
  | EAdd (e1, e2) -> "(" ^ (string_of_expr_arith e1) ^ " + " ^ 
      (string_of_expr_arith e2) ^ ")"
  | ESub (e1, e2) -> "(" ^ (string_of_expr_arith e1) ^ " - " ^ 
    (string_of_expr_arith e2) ^ ")"
  | EMul (e1, e2) -> "(" ^ (string_of_expr_arith e1) ^ " * " ^ 
    (string_of_expr_arith e2) ^ ")"
  | EDiv (e1, e2) -> "(" ^ (string_of_expr_arith e1) ^ " / " ^ 
    (string_of_expr_arith e2) ^ ")"
  | EMod (e1, e2) -> "(" ^ (string_of_expr_arith e1) ^ " % " ^ 
    (string_of_expr_arith e2) ^ ")"

let string_of_instr = function
  | IConst n -> "CONST(" ^ (string_of_int n) ^ ")"
  | IAdd -> "ADD"
  | ISub -> "SUB"
  | IMul -> "MUL"
  | IDiv -> "DIV"
  | IMod -> "MOD"

let output_instr channel = function
  | IConst n -> output_byte channel 0 ; output_binary_int channel n
  | IAdd -> output_byte channel 1
  | ISub -> output_byte channel 2
  | IMul -> output_byte channel 3
  | IDiv -> output_byte channel 4
  | IMod -> output_byte channel 5

let input_instr channel = 
  match input_byte channel with
    | 0 -> IConst (input_binary_int channel)
    | 1 -> IAdd
    | 2 -> ISub
    | 3 -> IMul
    | 4 -> IDiv
    | 5 -> IMod
    | _ -> failwith "Unknown opcode"
