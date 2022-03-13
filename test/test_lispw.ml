open Lispw

let expr_pp ppf e = Fmt.pf ppf "%s" (Expr.string_of_expr e)
let expr_equal a b = (a = b)
let expr_testable = Alcotest.testable expr_pp expr_equal

let test_int () = Alcotest.(check expr_testable) "same expression" (Eval.eval (Expr.EInt 12) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 12)
let test_plus () = Alcotest.(check expr_testable) "plus" (Eval.eval (Expr.EBinary (OPlus, (Expr.EInt 12), (Expr.EInt 13))) [] [] [] [] (fun v _ _ -> v)) (Expr.EInt 25)
let test_and () = Alcotest.(check expr_testable) "and" (Eval.eval (Expr.EAnd (Expr.EBool true, Expr.EBool false)) [] [] [] [] (fun v _ _ -> v)) (Expr.EBool false)
let test_and_true () = Alcotest.(check expr_testable) "and" (Eval.eval (Expr.EAnd (Expr.EBool true, Expr.EBool true)) [] [] [] [] (fun v _ _ -> v)) (Expr.EBool true)

let () =
  Alcotest.run "Test Lisp Web" [
      "eval", [
        Alcotest.test_case "Test Int" `Quick test_int;
        Alcotest.test_case "Test Plus" `Quick test_plus;
        Alcotest.test_case "Test And" `Quick test_and;
        Alcotest.test_case "Test And True" `Quick test_and_true;                        
      ];
    ]


