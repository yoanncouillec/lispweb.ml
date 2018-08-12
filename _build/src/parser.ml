exception Error

type token = 
  | TRUE
  | THROW
  | SET
  | RPAREN
  | RETURNFROM
  | PLUS
  | NOT
  | MULT
  | MINUS
  | LPAREN
  | LOAD
  | LIST
  | LETSTAR
  | LETREC
  | LET
  | LAMBDA
  | IF
  | HOSTCALL
  | FALSE
  | EVAL
  | ER_STRING of (string)
  | ER_INT of (int)
  | ER_IDENT of (string)
  | ER_CHAR_ESC of (string)
  | ER_CHAR of (string)
  | EQUAL
  | EOF
  | DEFINE
  | CUNQUOTE
  | CQUOTE
  | CQUASIQUOTE
  | CONS
  | CDR
  | CATCH
  | CAR
  | CALLCC
  | BLOCK
  | BEGIN
  | AND

and _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  mutable _menhir_token: token;
  mutable _menhir_startp: Lexing.position;
  mutable _menhir_endp: Lexing.position;
  mutable _menhir_shifted: int
}

and _menhir_state = 
  | MenhirState137
  | MenhirState134
  | MenhirState133
  | MenhirState130
  | MenhirState127
  | MenhirState123
  | MenhirState119
  | MenhirState116
  | MenhirState112
  | MenhirState109
  | MenhirState108
  | MenhirState105
  | MenhirState101
  | MenhirState100
  | MenhirState97
  | MenhirState93
  | MenhirState89
  | MenhirState88
  | MenhirState87
  | MenhirState84
  | MenhirState81
  | MenhirState78
  | MenhirState77
  | MenhirState73
  | MenhirState71
  | MenhirState66
  | MenhirState64
  | MenhirState59
  | MenhirState56
  | MenhirState54
  | MenhirState52
  | MenhirState49
  | MenhirState45
  | MenhirState42
  | MenhirState39
  | MenhirState38
  | MenhirState35
  | MenhirState34
  | MenhirState31
  | MenhirState28
  | MenhirState27
  | MenhirState24
  | MenhirState20
  | MenhirState13
  | MenhirState12
  | MenhirState11
  | MenhirState4
  | MenhirState2
  | MenhirState0

let _eRR =
  Error

let rec _menhir_goto_idents : _menhir_env -> 'ttv_tail -> _menhir_state -> (string list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _1), _, _2) = _menhir_stack in
        let _v : (string list) =                   ( _1::_2 ) in
        _menhir_goto_idents _menhir_env _menhir_stack _menhir_s _v
    | MenhirState77 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf Pervasives.stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_bindings : _menhir_env -> 'ttv_tail -> _menhir_state -> ((string * Expr.expr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((_menhir_stack, _menhir_s), _2), _, _3), _, _5) = _menhir_stack in
        let _v : ((string * Expr.expr) list) =                                              ( (_2, _3)::_5 ) in
        _menhir_goto_bindings _menhir_env _menhir_stack _menhir_s _v
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState59 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState59 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState59 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState59 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState59 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState59
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState59)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_expressions : _menhir_env -> 'ttv_tail -> _menhir_state -> (Expr.expr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                  ( Expr.EList(_3) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _1), _, _2) = _menhir_stack in
        let _v : (Expr.expr list) =                          ( _1 :: _2 ) in
        _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _4), _, _6) = _menhir_stack in
            let _v : (Expr.expr) =                                                            ( List.fold_left (fun a b -> Expr.ELet (fst b, snd b, a)) (Expr.ELet (fst (List.hd (List.rev _4)), snd (List.hd (List.rev _4)), Expr.EBegin _6)) (List.tl (List.rev _4)) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s), _), _4), _, _5), _, _7) = _menhir_stack in
            let _v : (Expr.expr) =                                                                   ( Expr.ELet (_4, _5, Expr.EList _7) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _), _, _5) = _menhir_stack in
            let _v : (Expr.expr) =                                                  ( Expr.EThunk (Expr.EBegin _5) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _4), _, _6) = _menhir_stack in
            let _v : (Expr.expr) =                                                         ( List.fold_left (fun a b -> Expr.ELambda(b,a)) (Expr.ELambda (List.hd ((List.rev _4)), (Expr.EBegin _6))) (List.tl (List.rev _4)) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                               ( Expr.EHostCall (_3,Expr.EList _4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState130 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                   ( Expr.EBegin (_3) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState137 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, _2), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                        ( List.fold_left (fun a b -> Expr.EApp(a,b)) (Expr.EApp (_2, List.hd _3)) (List.tl _3)) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, e) = _menhir_stack in
            let _v : (Expr.expr) =                       ( Expr.EBegin e ) in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _1 = _v in
            Obj.magic _1
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run53 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | ER_IDENT _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState54
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState54)
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run81 : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | ER_IDENT _v ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
    | RPAREN ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _1) = _menhir_stack in
        let _v : (string list) =            ( [_1] ) in
        _menhir_goto_idents _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81

and _menhir_goto_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> (Expr.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
        let _v : (Expr.expr) =                          ( Expr.EQuasiQuote (_2) ) in
        _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
        let _v : (Expr.expr) =                     ( Expr.EQuote (_2) ) in
        _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
        let _v : (Expr.expr) =                       ( Expr.EUnQuote (_2) ) in
        _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                           ( Expr.EThrow(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                         ( Expr.ESet(_3, _4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                                ( Expr.EReturnFrom(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28)
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                            ( Expr.EBinary(Expr.OPlus,_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState31 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                ( Expr.ENot (_3) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState34 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState35
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35)
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                            ( Expr.EBinary(Expr.OMult,_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState38 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState39
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState39)
    | MenhirState39 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                             ( Expr.EBinary(Expr.OMinus,_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                 ( Expr.ELoad _3 ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 | MenhirState137 | MenhirState130 | MenhirState93 | MenhirState84 | MenhirState78 | MenhirState73 | MenhirState59 | MenhirState49 | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | EOF | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _1) = _menhir_stack in
            let _v : (Expr.expr list) =              ( [_1] ) in
            _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState49)
    | MenhirState54 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | LPAREN ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState56
            | RPAREN ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _2), _, _3) = _menhir_stack in
                let _v : ((string * Expr.expr) list) =                                     ( [(_2, _3)] ) in
                _menhir_goto_bindings _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState56)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState66 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState66 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState66 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState66 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState66 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState66
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState66)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState66 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s), _), _4), _, _5), _, _7) = _menhir_stack in
            let _v : (Expr.expr) =                                                                     ( Expr.ELet (_4, Expr.EInt 0, Expr.ELet (_4^"-rec-tmp", _5, Expr.EBegin([Expr.ESet(_4,Expr.EVar (_4^"-rec-tmp"));_7]))) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState73
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState73)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState88)
    | MenhirState88 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89)
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s), _), _, _3), _, _4), _, _5) = _menhir_stack in
            let _v : (Expr.expr) =                                                     ( Expr.EIf (_3, _4, _5) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState97 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                 ( Expr.EEval _3 ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState100 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState101
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState101)
    | MenhirState101 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                             ( Expr.EEqual (_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState105 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                            ( Expr.EDefine (_3, _4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState109
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState109)
    | MenhirState109 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                            ( Expr.ECons(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                 ( Expr.ECdr(_3) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState116 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                           ( Expr.ECatch(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState119 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : (Expr.expr) =                                ( Expr.ECar(_3) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState123 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                            ( Expr.ECallcc(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState127 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                           ( Expr.EBlock(_3,_4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState134 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState134 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState134 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState134 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState134 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState134
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState134)
    | MenhirState134 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : (Expr.expr) =                                           ( Expr.EAnd (_3, _4) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState137 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState137 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState137 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState137 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState137 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState137 in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
            let _v : (Expr.expr) =                            ( Expr.EThunkApp _2 ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState137
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState137)
    | _ ->
        _menhir_fail ()

and _menhir_discard : _menhir_env -> token =
  fun _menhir_env ->
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = _menhir_env._menhir_lexer lexbuf in
    _menhir_env._menhir_token <- _tok;
    _menhir_env._menhir_startp <- lexbuf.Lexing.lex_start_p;
    _menhir_env._menhir_endp <- lexbuf.Lexing.lex_curr_p;
    let shifted = Pervasives.(+) _menhir_env._menhir_shifted 1 in
    if Pervasives.(>=) shifted 0 then
      _menhir_env._menhir_shifted <- shifted;
    _tok

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState137 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState134 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState130 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState127 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState123 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState119 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState116 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState109 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState105 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState101 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState100 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState97 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState93 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState88 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState77 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState66 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState54 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState39 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState38 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState34 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState31 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Expr.expr) =        ( Expr.EBool (true) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | AND ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState133
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState133)
    | BEGIN ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState130 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState130 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState130 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState130 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState130 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState130
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState130)
    | BLOCK ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState127 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState127 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState127 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState127 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState127 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState127
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState127)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | CALLCC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState123 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState123 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState123 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState123 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState123 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState123
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState123)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | CAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState119 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState119 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState119 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState119 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState119 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState119
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState119)
    | CATCH ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState116 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState116 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState116 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState116 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState116 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState116
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState116)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | CDR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState112
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112)
    | CONS ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108)
    | CQUASIQUOTE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | CQUOTE ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | CUNQUOTE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | DEFINE ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState105
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState105)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | EQUAL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100)
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_CHAR_ESC _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_INT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | EVAL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState97)
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | HOSTCALL ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | RPAREN ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_s = MenhirState93 in
                let _ = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _3) = _menhir_stack in
                let _v : (Expr.expr) =                                   ( Expr.EHostCall (_3,Expr.EList []) ) in
                _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState93)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | IF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState87
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState87)
    | LAMBDA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | LPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | ER_IDENT _v ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState77 _v
            | RPAREN ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_s = MenhirState77 in
                let _menhir_stack = (_menhir_stack, _menhir_s) in
                let _tok = _menhir_discard _menhir_env in
                (match _tok with
                | CQUASIQUOTE ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | CQUOTE ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | CUNQUOTE ->
                    _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
                | ER_CHAR_ESC _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
                | ER_IDENT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
                | ER_INT _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
                | ER_STRING _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
                | FALSE ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | LPAREN ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState78
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState78)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState77)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LET ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | LPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | ER_IDENT _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                (match _tok with
                | CQUASIQUOTE ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | CQUOTE ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | CUNQUOTE ->
                    _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
                | ER_CHAR_ESC _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
                | ER_IDENT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
                | ER_INT _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
                | ER_STRING _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
                | FALSE ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | LPAREN ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState71
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LETREC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | LPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | ER_IDENT _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                (match _tok with
                | CQUASIQUOTE ->
                    _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | CQUOTE ->
                    _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | CUNQUOTE ->
                    _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
                | ER_CHAR_ESC _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
                | ER_IDENT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
                | ER_INT _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
                | ER_STRING _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
                | FALSE ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | LPAREN ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState64
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LETSTAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | LPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | LPAREN ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | LIST ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState45 in
            let _ = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            let _v : (Expr.expr) =                      ( Expr.EList([]) ) in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45)
    | LOAD ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42)
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | MINUS ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState38
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState38)
    | MULT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState34)
    | NOT ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState31
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31)
    | PLUS ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | CQUASIQUOTE ->
            _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | CQUOTE ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | CUNQUOTE ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | ER_CHAR_ESC _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | ER_IDENT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | ER_INT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | ER_STRING _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState27
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27)
    | RETURNFROM ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState24
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState24)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | SET ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState20
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState20)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | THROW ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState2 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        (match _tok with
        | ER_IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            (match _tok with
            | CQUASIQUOTE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | CQUOTE ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | CUNQUOTE ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | ER_CHAR_ESC _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | ER_IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | ER_INT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | ER_STRING _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState4
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState4)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Expr.expr) =         ( Expr.EBool (false) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = _v in
    let _v : (Expr.expr) =             ( Expr.EString (String.sub (_1) 1 ((String.length _1) - 2)) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> (int) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let n = _v in
    let _v : (Expr.expr) =              ( Expr.EInt (n) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = _v in
    let _v : (Expr.expr) =            ( Expr.EVar (_1) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = _v in
    let _v : (Expr.expr) =               ( Expr.EChar (match _1 with "'\\n'" -> '\n' | "'\\r'" -> '\r' | _ -> failwith "ER_CHAR_ESC") ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> (string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = _v in
    let _v : (Expr.expr) =           ( Expr.EChar (String.get _1 1) ) in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run11 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | CQUASIQUOTE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | CQUOTE ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | CUNQUOTE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | ER_CHAR_ESC _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | ER_IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | ER_INT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | ER_STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11

and _menhir_run12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | CQUASIQUOTE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | CQUOTE ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | CUNQUOTE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | ER_CHAR_ESC _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | ER_IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | ER_INT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | ER_STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12

and _menhir_run13 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    match _tok with
    | CQUASIQUOTE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | CQUOTE ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | CUNQUOTE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | ER_CHAR_ESC _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | ER_IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | ER_INT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | ER_STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13

and start : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Expr.expr) =
  fun lexer lexbuf ->
    let _menhir_env = let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_startp = lexbuf.Lexing.lex_start_p;
      _menhir_endp = lexbuf.Lexing.lex_curr_p;
      _menhir_shifted = 4611686018427387903;
      } in
    Obj.magic (let _menhir_stack = () in
    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CQUASIQUOTE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | CQUOTE ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | CUNQUOTE ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_CHAR_ESC _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_INT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_STRING _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)



