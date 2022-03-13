open Lispw
   
let expr_pp ppf e = Fmt.pf ppf "%s" (Expr.string_of_expr e)
let expr_equal a b = (a = b)
let expr_testable = Alcotest.testable expr_pp expr_equal

let parse s =
  match (Parse.expr_of_scheme_string s) with
  | Some e -> e
  | None -> failwith "could not parse"
                  
let test_int () = Alcotest.(check expr_testable) "int" (Eval.eval (Expr.EInt 12) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 12)
let test_float () = Alcotest.(check expr_testable) "float" (Eval.eval (Expr.EFloat 12.) [] [] [] [] (fun v _ _ -> v)) (Expr.EFloat 12.)
let test_string () = Alcotest.(check expr_testable) "string" (Eval.eval (Expr.EString "foo") [] [] [] [] (fun v _ _ -> v)) (Expr.EString "foo")
let test_plus () = Alcotest.(check expr_testable) "plus" (Eval.eval (Expr.EBinary (OPlus, (Expr.EInt 12), (Expr.EInt 13))) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 25)
let test_and () = Alcotest.(check expr_testable) "and" (Eval.eval (Expr.EAnd (Expr.EBool true, Expr.EBool false)) [] [] [] [] (fun v _ _ -> v)) (Expr.EBool false)
let test_and_true () = Alcotest.(check expr_testable) "and" (Eval.eval (Expr.EAnd (Expr.EBool true, Expr.EBool true)) [] [] [] [] (fun v _ _ -> v)) (Expr.EBool true)
let test_not () = Alcotest.(check expr_testable) "not" (Eval.eval (Expr.ENot (Expr.EBool true)) [] [] [] [] (fun v _ _ -> v)) (Expr.EBool false)
let test_if () = Alcotest.(check expr_testable) "if" (Eval.eval (Expr.EIf (Expr.EBool true, Expr.EInt 1, Expr.EInt 2)) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 1)
let test_if_false () = Alcotest.(check expr_testable) "if" (Eval.eval (Expr.EIf (Expr.EBool false, Expr.EInt 1, Expr.EInt 2)) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 2)
let test_parse_let () = Alcotest.(check expr_testable) "Parse let" (Eval.eval (parse "(let (x 12) x)") [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 12)
                  
let () =
  print_endline (Unix.getcwd());
  Alcotest.run "Test Lisp Web" [
      "eval", [
        Alcotest.test_case "Int" `Quick test_int;
        Alcotest.test_case "Float" `Quick test_float;
        Alcotest.test_case "String" `Quick test_string;        
        Alcotest.test_case "Plus" `Quick test_plus;
        Alcotest.test_case "And" `Quick test_and;
        Alcotest.test_case "And True" `Quick test_and_true;
        Alcotest.test_case "Not" `Quick test_not;
        Alcotest.test_case "If" `Quick test_if;
        Alcotest.test_case "If False" `Quick test_if_false;
        Alcotest.test_case "Parse Let" `Quick test_parse_let;        
      ];
    ]


