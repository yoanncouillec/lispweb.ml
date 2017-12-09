exception Error

type token = 
  | TRUE
  | THROW
  | SET
  | RPAREN
  | RETURNFROM
  | QUOTE
  | PLUS
  | NOT
  | MULT
  | MINUS
  | LPAREN
  | LIST
  | LETSTAR
  | LETREC
  | LET
  | LAMBDA
  | IF
  | HOSTCALL
  | FALSE
  | ER_STRING of (
# 2 "parser.mly"
      (string)
# 27 "parser.ml"
)
  | ER_INT of (
# 1 "parser.mly"
      (int)
# 32 "parser.ml"
)
  | ER_IDENT of (
# 2 "parser.mly"
      (string)
# 37 "parser.ml"
)
  | ER_CHAR of (
# 2 "parser.mly"
      (string)
# 42 "parser.ml"
)
  | EQUAL
  | EOF
  | DEFINE
  | CONS
  | CDR
  | CATCH
  | CAR
  | CALLCC
  | BLOCK
  | BEGIN

and _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  mutable _menhir_token: token;
  mutable _menhir_startp: Lexing.position;
  mutable _menhir_endp: Lexing.position;
  mutable _menhir_shifted: int
}

and _menhir_state = 
  | MenhirState121
  | MenhirState118
  | MenhirState115
  | MenhirState111
  | MenhirState107
  | MenhirState104
  | MenhirState100
  | MenhirState97
  | MenhirState96
  | MenhirState93
  | MenhirState89
  | MenhirState88
  | MenhirState84
  | MenhirState80
  | MenhirState79
  | MenhirState78
  | MenhirState75
  | MenhirState72
  | MenhirState69
  | MenhirState68
  | MenhirState64
  | MenhirState62
  | MenhirState57
  | MenhirState55
  | MenhirState50
  | MenhirState47
  | MenhirState45
  | MenhirState43
  | MenhirState40
  | MenhirState36
  | MenhirState33
  | MenhirState32
  | MenhirState29
  | MenhirState28
  | MenhirState25
  | MenhirState22
  | MenhirState21
  | MenhirState18
  | MenhirState14
  | MenhirState5
  | MenhirState3
  | MenhirState2
  | MenhirState0

let _eRR =
  Error

let rec _menhir_goto_idents : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_idents -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState72 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv671 * _menhir_state * (
# 2 "parser.mly"
      (string)
# 121 "parser.ml"
        )) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv669 * _menhir_state * (
# 2 "parser.mly"
      (string)
# 127 "parser.ml"
        )) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _1), _, _2) = _menhir_stack in
        let _v : 'tv_idents = 
# 59 "parser.mly"
                  ( _1::_2 )
# 133 "parser.ml"
         in
        _menhir_goto_idents _menhir_env _menhir_stack _menhir_s _v) : 'freshtv670)) : 'freshtv672)
    | MenhirState68 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv681 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv679 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv675 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv673 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState75
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState75
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState75
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState75
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState75) : 'freshtv674)) : 'freshtv676)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv677 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv678)) : 'freshtv680)) : 'freshtv682)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf Pervasives.stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_bindings : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_bindings -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState47 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv657 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 197 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv655 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 203 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _2), _, _3), _, _5) = _menhir_stack in
        let _v : 'tv_bindings = 
# 63 "parser.mly"
                                             ( (_2, _3)::_5 )
# 209 "parser.ml"
         in
        _menhir_goto_bindings _menhir_env _menhir_stack _menhir_s _v) : 'freshtv656)) : 'freshtv658)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv667 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv665 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv661 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv659 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50) : 'freshtv660)) : 'freshtv662)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv663 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv664)) : 'freshtv666)) : 'freshtv668)
    | _ ->
        _menhir_fail ()

and _menhir_goto_expressions : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expressions -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState36 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv583 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv581 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv577 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv575 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 41 "parser.mly"
                                 ( Expr.EList(_3) )
# 282 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv576)) : 'freshtv578)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv579 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv580)) : 'freshtv582)) : 'freshtv584)
    | MenhirState40 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv587 * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv585 * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _1), _, _2) = _menhir_stack in
        let _v : 'tv_expressions = 
# 18 "parser.mly"
                         ( _1 :: _2 )
# 301 "parser.ml"
         in
        _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv586)) : 'freshtv588)
    | MenhirState50 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv597 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv595 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv591 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv589 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _4), _, _6) = _menhir_stack in
            let _v : 'tv_expression = 
# 46 "parser.mly"
                                                           ( List.fold_left (fun a b -> Expr.ELet (fst b, snd b, a)) (Expr.ELet (fst (List.hd (List.rev _4)), snd (List.hd (List.rev _4)), Expr.EBegin _6)) (List.tl (List.rev _4)) )
# 323 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv590)) : 'freshtv592)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv593 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv594)) : 'freshtv596)) : 'freshtv598)
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv607 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 338 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv605 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 346 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv601 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 355 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv599 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 362 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _), _4), _, _5), _, _7) = _menhir_stack in
            let _v : 'tv_expression = 
# 45 "parser.mly"
                                                                  ( Expr.ELet (_4, _5, Expr.EList _7) )
# 368 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv600)) : 'freshtv602)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv603 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 378 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv604)) : 'freshtv606)) : 'freshtv608)
    | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv617 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 387 "parser.ml"
        )) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv615 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 395 "parser.ml"
        )) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv611 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 404 "parser.ml"
            )) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv609 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 411 "parser.ml"
            )) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 53 "parser.mly"
                                              ( Expr.EHostCall (_3,Expr.EList _4) )
# 417 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv610)) : 'freshtv612)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv613 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 427 "parser.ml"
            )) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv614)) : 'freshtv616)) : 'freshtv618)
    | MenhirState118 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv627 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv625 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv621 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv619 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 51 "parser.mly"
                                  ( Expr.EBegin (_3) )
# 450 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv620)) : 'freshtv622)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv623 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv624)) : 'freshtv626)) : 'freshtv628)
    | MenhirState121 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv637 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv635 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv631 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv629 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, _2), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 55 "parser.mly"
                                       ( List.fold_left (fun a b -> Expr.EApp(a,b)) (Expr.EApp (_2, List.hd _3)) (List.tl _3))
# 479 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv630)) : 'freshtv632)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv633 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv634)) : 'freshtv636)) : 'freshtv638)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv653 * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv651 * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv647 * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv645 * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, e) = _menhir_stack in
            let _v : (
# 9 "parser.mly"
      (Expr.expr)
# 507 "parser.ml"
            ) = 
# 14 "parser.mly"
                      ( Expr.EBegin e )
# 511 "parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv643) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 9 "parser.mly"
      (Expr.expr)
# 519 "parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv641) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 9 "parser.mly"
      (Expr.expr)
# 527 "parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv639) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_1 : (
# 9 "parser.mly"
      (Expr.expr)
# 535 "parser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv640)) : 'freshtv642)) : 'freshtv644)) : 'freshtv646)) : 'freshtv648)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv649 * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv650)) : 'freshtv652)) : 'freshtv654)
    | _ ->
        _menhir_fail ()

and _menhir_run44 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv573 * _menhir_state) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | ER_IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv569 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "parser.mly"
      (string)
# 562 "parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv567 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 570 "parser.ml"
        )) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState45
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45) : 'freshtv568)) : 'freshtv570)
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv571 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv572)) : 'freshtv574)

and _menhir_run72 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "parser.mly"
      (string)
# 605 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _tok = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv565 * _menhir_state * (
# 2 "parser.mly"
      (string)
# 614 "parser.ml"
    )) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | ER_IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _v
    | RPAREN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv563 * _menhir_state * (
# 2 "parser.mly"
      (string)
# 625 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _1) = _menhir_stack in
        let _v : 'tv_idents = 
# 58 "parser.mly"
           ( [_1] )
# 631 "parser.ml"
         in
        _menhir_goto_idents _menhir_env _menhir_stack _menhir_s _v) : 'freshtv564)
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState72) : 'freshtv566)

and _menhir_goto_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState5 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv303 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 648 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv301 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 656 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv297 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 665 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv295 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 672 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 33 "parser.mly"
                                          ( Expr.EThrow(_3,_4) )
# 678 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv296)) : 'freshtv298)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv299 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 688 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv300)) : 'freshtv302)) : 'freshtv304)
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv313 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 697 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv311 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 705 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv307 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 714 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv305 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 721 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 49 "parser.mly"
                                        ( Expr.ESet(_3, _4) )
# 727 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv306)) : 'freshtv308)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv309 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 737 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv310)) : 'freshtv312)) : 'freshtv314)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv323 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 746 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv321 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 754 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv317 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 763 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv315 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 770 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 35 "parser.mly"
                                               ( Expr.EReturnFrom(_3,_4) )
# 776 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv316)) : 'freshtv318)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv319 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 786 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv320)) : 'freshtv322)) : 'freshtv324)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv327 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv325 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState22
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState22
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState22
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState22
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState22) : 'freshtv326)) : 'freshtv328)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv337 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv335 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv331 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv329 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 29 "parser.mly"
                                           ( Expr.EBinary(Expr.OPlus,_3,_4) )
# 838 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv330)) : 'freshtv332)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv333 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv334)) : 'freshtv336)) : 'freshtv338)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv347 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv345 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv341 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv339 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 28 "parser.mly"
                               ( Expr.ENot (_3) )
# 867 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv340)) : 'freshtv342)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv343 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv344)) : 'freshtv346)) : 'freshtv348)
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv351 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv349 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState29) : 'freshtv350)) : 'freshtv352)
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv361 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv359 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv355 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv353 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 31 "parser.mly"
                                           ( Expr.EBinary(Expr.OMult,_3,_4) )
# 925 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv354)) : 'freshtv356)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv357 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv358)) : 'freshtv360)) : 'freshtv362)
    | MenhirState32 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv365 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv363 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState33
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33) : 'freshtv364)) : 'freshtv366)
    | MenhirState33 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv375 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv373 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv369 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv367 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 30 "parser.mly"
                                            ( Expr.EBinary(Expr.OMinus,_3,_4) )
# 983 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv368)) : 'freshtv370)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv371 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv372)) : 'freshtv374)) : 'freshtv376)
    | MenhirState0 | MenhirState121 | MenhirState118 | MenhirState84 | MenhirState64 | MenhirState50 | MenhirState40 | MenhirState36 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv381 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv379 * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState40
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState40
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState40
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState40
        | EOF | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv377 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _1) = _menhir_stack in
            let _v : 'tv_expressions = 
# 17 "parser.mly"
             ( [_1] )
# 1025 "parser.ml"
             in
            _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv378)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState40) : 'freshtv380)) : 'freshtv382)
    | MenhirState45 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv393 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1037 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv391 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1045 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv387 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1054 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv385 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1061 "parser.ml"
            )) * _menhir_state * 'tv_expression) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | LPAREN ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState47
            | RPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv383 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1072 "parser.ml"
                )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s), _2), _, _3) = _menhir_stack in
                let _v : 'tv_bindings = 
# 62 "parser.mly"
                                    ( [(_2, _3)] )
# 1078 "parser.ml"
                 in
                _menhir_goto_bindings _menhir_env _menhir_stack _menhir_s _v) : 'freshtv384)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState47) : 'freshtv386)) : 'freshtv388)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv389 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1092 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv390)) : 'freshtv392)) : 'freshtv394)
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv403 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1101 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv401 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1109 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv397 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1118 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv395 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1125 "parser.ml"
            )) * _menhir_state * 'tv_expression) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState57) : 'freshtv396)) : 'freshtv398)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv399 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1156 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv400)) : 'freshtv402)) : 'freshtv404)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv413 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1165 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv411 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1173 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv407 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1182 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv405 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1189 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _), _4), _, _5), _, _7) = _menhir_stack in
            let _v : 'tv_expression = 
# 48 "parser.mly"
                                                                    ( Expr.ELet (_4, Expr.EInt 0, Expr.ELet (_4^"-rec-tmp", _5, Expr.EBegin([Expr.ESet(_4,Expr.EVar (_4^"-rec-tmp"));_7]))) )
# 1195 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv406)) : 'freshtv408)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv409 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1205 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv410)) : 'freshtv412)) : 'freshtv414)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv423 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1214 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv421 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1222 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv417 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1231 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv415 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1238 "parser.ml"
            )) * _menhir_state * 'tv_expression) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64) : 'freshtv416)) : 'freshtv418)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv419 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1269 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv420)) : 'freshtv422)) : 'freshtv424)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv433 * _menhir_state) * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv431 * _menhir_state) * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv427 * _menhir_state) * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv425 * _menhir_state) * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _), _, _5) = _menhir_stack in
            let _v : 'tv_expression = 
# 43 "parser.mly"
                                                ( Expr.EThunk _5 )
# 1292 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv426)) : 'freshtv428)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv429 * _menhir_state) * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv430)) : 'freshtv432)) : 'freshtv434)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv443 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv441 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv437 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv435 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _4), _, _6) = _menhir_stack in
            let _v : 'tv_expression = 
# 44 "parser.mly"
                                                       ( List.fold_left (fun a b -> Expr.ELambda(b,a)) (Expr.ELambda (List.hd ((List.rev _4)), _6)) (List.tl (List.rev _4)) )
# 1321 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv436)) : 'freshtv438)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv439 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv440)) : 'freshtv442)) : 'freshtv444)
    | MenhirState78 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv447 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv445 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState79
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState79
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState79
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState79
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState79) : 'freshtv446)) : 'freshtv448)
    | MenhirState79 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv451 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv449 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState80 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState80
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState80
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState80
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState80
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState80) : 'freshtv450)) : 'freshtv452)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv461 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv459 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv455 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv453 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _), _, _3), _, _4), _, _5) = _menhir_stack in
            let _v : 'tv_expression = 
# 42 "parser.mly"
                                                    ( Expr.EIf (_3, _4, _5) )
# 1408 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv454)) : 'freshtv456)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv457 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv458)) : 'freshtv460)) : 'freshtv462)
    | MenhirState88 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv465 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv463 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState89
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89) : 'freshtv464)) : 'freshtv466)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv475 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv473 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv469 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv467 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 50 "parser.mly"
                                            ( Expr.EEqual (_3,_4) )
# 1466 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv468)) : 'freshtv470)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv471 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv472)) : 'freshtv474)) : 'freshtv476)
    | MenhirState93 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv485 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1481 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv483 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1489 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv479 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1498 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv477 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1505 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 47 "parser.mly"
                                           ( Expr.EDefine (_3, _4) )
# 1511 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv478)) : 'freshtv480)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv481 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1521 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv482)) : 'freshtv484)) : 'freshtv486)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv489 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv487 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState97 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState97
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState97) : 'freshtv488)) : 'freshtv490)
    | MenhirState97 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv499 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv497 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv493 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv491 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 39 "parser.mly"
                                           ( Expr.ECons(_3,_4) )
# 1573 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv492)) : 'freshtv494)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv495 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv496)) : 'freshtv498)) : 'freshtv500)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv509 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv507 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv503 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv501 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 38 "parser.mly"
                                ( Expr.ECdr(_3) )
# 1602 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv502)) : 'freshtv504)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv505 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv506)) : 'freshtv508)) : 'freshtv510)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv519 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1617 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv517 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1625 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv513 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1634 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv511 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1641 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 32 "parser.mly"
                                          ( Expr.ECatch(_3,_4) )
# 1647 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv512)) : 'freshtv514)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv515 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1657 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv516)) : 'freshtv518)) : 'freshtv520)
    | MenhirState107 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv529 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv527 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv523 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv521 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 37 "parser.mly"
                               ( Expr.ECar(_3) )
# 1680 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv522)) : 'freshtv524)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv525 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv526)) : 'freshtv528)) : 'freshtv530)
    | MenhirState111 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv539 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1695 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv537 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1703 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv533 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1712 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv531 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1719 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 36 "parser.mly"
                                           ( Expr.ECallcc(_3,_4) )
# 1725 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv532)) : 'freshtv534)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv535 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1735 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv536)) : 'freshtv538)) : 'freshtv540)
    | MenhirState115 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv549 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1744 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv547 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1752 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv543 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1761 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv541 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1768 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 34 "parser.mly"
                                          ( Expr.EBlock(_3,_4) )
# 1774 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv542)) : 'freshtv544)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv545 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1784 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv546)) : 'freshtv548)) : 'freshtv550)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv557 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv555 * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState121 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState121 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState121 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState121 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState121
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState121
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState121
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv553 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState121 in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv551 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            ((let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
            let _v : 'tv_expression = 
# 54 "parser.mly"
                           ( Expr.EThunkApp _2 )
# 1823 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv552)) : 'freshtv554)
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState121
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState121) : 'freshtv556)) : 'freshtv558)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv561 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv559 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _, _2) = _menhir_stack in
        let _v : 'tv_expression = 
# 25 "parser.mly"
                   ( Expr.EQuote (_2) )
# 1841 "parser.ml"
         in
        _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv560)) : 'freshtv562)
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
    | MenhirState121 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv209 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv210)
    | MenhirState118 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv211 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv212)
    | MenhirState115 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv213 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1877 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv214)
    | MenhirState111 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv215 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1886 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv216)
    | MenhirState107 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv217 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv218)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv219 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1900 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv220)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv221 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv222)
    | MenhirState97 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv223 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv224)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv225 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv226)
    | MenhirState93 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv227 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1924 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv228)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv229 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv230)
    | MenhirState88 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv231 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv232)
    | MenhirState84 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv233 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1943 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv234)
    | MenhirState80 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv235 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv236)
    | MenhirState79 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv237 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv238)
    | MenhirState78 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv239 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv240)
    | MenhirState75 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv241 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_idents) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv242)
    | MenhirState72 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv243 * _menhir_state * (
# 2 "parser.mly"
      (string)
# 1972 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv244)
    | MenhirState69 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv245 * _menhir_state) * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv246)
    | MenhirState68 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv247 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv248)
    | MenhirState64 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv249 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1991 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv250)
    | MenhirState62 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv251 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2000 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv252)
    | MenhirState57 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv253 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2009 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv254)
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv255 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2018 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv256)
    | MenhirState50 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv257 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_bindings) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv258)
    | MenhirState47 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv259 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2032 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv260)
    | MenhirState45 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv261 * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2041 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv262)
    | MenhirState43 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv263 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv264)
    | MenhirState40 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv265 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv266)
    | MenhirState36 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv267 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv268)
    | MenhirState33 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv269 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv270)
    | MenhirState32 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv271 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv272)
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv273 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv274)
    | MenhirState28 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv275 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv276)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv277 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv278)
    | MenhirState22 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv279 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv280)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv281 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv282)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv283 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2100 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv284)
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv285 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2109 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv286)
    | MenhirState5 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv287 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2118 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv288)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv289 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv290)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv291 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv292)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv293) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv294)

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv207) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _v : 'tv_expression = 
# 26 "parser.mly"
       ( Expr.EBool (true) )
# 2146 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv208)

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv205 * _menhir_state) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_IDENT _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_INT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_STRING _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | FALSE ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | LPAREN ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2) : 'freshtv206)

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv203 * _menhir_state) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | BEGIN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv17 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv15 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState118 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState118 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState118 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState118 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState118
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState118
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState118
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState118
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState118) : 'freshtv16)) : 'freshtv18)
    | BLOCK ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv25 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv21 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 2233 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv19 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2241 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState115 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState115 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState115 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState115 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState115
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState115
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState115
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState115
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState115) : 'freshtv20)) : 'freshtv22)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv23 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)) : 'freshtv26)) : 'freshtv28)
    | CALLCC ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv35 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv31 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 2288 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv29 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2296 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState111
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState111
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState111
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState111
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState111) : 'freshtv30)) : 'freshtv32)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv33 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)) : 'freshtv36)) : 'freshtv38)
    | CAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv41 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv39 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState107 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState107 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState107 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState107 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState107
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState107
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState107
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState107
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState107) : 'freshtv40)) : 'freshtv42)
    | CATCH ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv51 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv49 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv45 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 2373 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv43 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2381 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState104
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState104
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState104
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState104
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState104) : 'freshtv44)) : 'freshtv46)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv47 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv48)) : 'freshtv50)) : 'freshtv52)
    | CDR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv55 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv53 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState100
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100) : 'freshtv54)) : 'freshtv56)
    | CONS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv59 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv57 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState96
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState96
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState96
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState96
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96) : 'freshtv58)) : 'freshtv60)
    | DEFINE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv69 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv67 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv63 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 2488 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv61 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2496 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState93 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState93
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState93) : 'freshtv62)) : 'freshtv64)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv65 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)) : 'freshtv68)) : 'freshtv70)
    | EQUAL ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv73 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv71 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState88 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState88
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState88) : 'freshtv72)) : 'freshtv74)
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | ER_IDENT _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | ER_INT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | ER_STRING _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | FALSE ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | HOSTCALL ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv87 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv85 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv81 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 2583 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv79 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2591 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | RPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv77 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2614 "parser.ml"
                )) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = MenhirState84 in
                ((let _ = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv75 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2622 "parser.ml"
                )) = Obj.magic _menhir_stack in
                let (_ : _menhir_state) = _menhir_s in
                ((let (((_menhir_stack, _menhir_s), _), _3) = _menhir_stack in
                let _v : 'tv_expression = 
# 52 "parser.mly"
                                  ( Expr.EHostCall (_3,Expr.EList []) )
# 2629 "parser.ml"
                 in
                _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv76)) : 'freshtv78)
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState84
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84) : 'freshtv80)) : 'freshtv82)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv83 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv84)) : 'freshtv86)) : 'freshtv88)
    | IF ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv91 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv89 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState78 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState78
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState78
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState78
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState78
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState78) : 'freshtv90)) : 'freshtv92)
    | LAMBDA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv105 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv103 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv99 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv97 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _v
            | RPAREN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv95 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = MenhirState68 in
                ((let _menhir_stack = (_menhir_stack, _menhir_s) in
                let _tok = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv93 * _menhir_state) * _menhir_state) * _menhir_state) = _menhir_stack in
                let (_tok : token) = _tok in
                ((match _tok with
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
                | ER_IDENT _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
                | ER_INT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
                | ER_STRING _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
                | FALSE ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState69
                | LPAREN ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState69
                | QUOTE ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState69
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState69
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState69) : 'freshtv94)) : 'freshtv96)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState68) : 'freshtv98)) : 'freshtv100)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv101 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv102)) : 'freshtv104)) : 'freshtv106)
    | LET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv121 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv119 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv115 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv113 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv109 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "parser.mly"
      (string)
# 2760 "parser.ml"
                )) = _v in
                ((let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv107 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2768 "parser.ml"
                )) = _menhir_stack in
                let (_tok : token) = _tok in
                ((match _tok with
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
                | ER_IDENT _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
                | ER_INT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
                | ER_STRING _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState62 _v
                | FALSE ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState62
                | LPAREN ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState62
                | QUOTE ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState62
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState62
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62) : 'freshtv108)) : 'freshtv110)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv111 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv112)) : 'freshtv114)) : 'freshtv116)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv117 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv118)) : 'freshtv120)) : 'freshtv122)
    | LETREC ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv137 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv135 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv131 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv129 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv125 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "parser.mly"
      (string)
# 2830 "parser.ml"
                )) = _v in
                ((let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv123 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 2838 "parser.ml"
                )) = _menhir_stack in
                let (_tok : token) = _tok in
                ((match _tok with
                | ER_CHAR _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
                | ER_IDENT _v ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
                | ER_INT _v ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
                | ER_STRING _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
                | FALSE ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState55
                | LPAREN ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState55
                | QUOTE ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState55
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState55
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState55) : 'freshtv124)) : 'freshtv126)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv127 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv128)) : 'freshtv130)) : 'freshtv132)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv133 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv134)) : 'freshtv136)) : 'freshtv138)
    | LETSTAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv147 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv145 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv141 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv139 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | LPAREN ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43) : 'freshtv140)) : 'freshtv142)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv143 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv144)) : 'freshtv146)) : 'freshtv148)
    | LIST ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv155 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv153 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv151 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState36 in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv149 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            let _v : 'tv_expression = 
# 40 "parser.mly"
                     ( Expr.EList([]) )
# 2943 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv150)) : 'freshtv152)
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState36) : 'freshtv154)) : 'freshtv156)
    | LPAREN ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | MINUS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv159 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv157 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState32
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState32
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState32
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState32
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32) : 'freshtv158)) : 'freshtv160)
    | MULT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv163 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv161 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState28
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28) : 'freshtv162)) : 'freshtv164)
    | NOT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv167 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv165 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState25
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState25
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState25
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState25
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25) : 'freshtv166)) : 'freshtv168)
    | PLUS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv171 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv169 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_CHAR _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
        | ER_IDENT _v ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
        | ER_INT _v ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
        | ER_STRING _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
        | FALSE ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | LPAREN ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21) : 'freshtv170)) : 'freshtv172)
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | RETURNFROM ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv181 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv179 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv175 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 3092 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv173 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 3100 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18) : 'freshtv174)) : 'freshtv176)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv177 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv178)) : 'freshtv180)) : 'freshtv182)
    | SET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv191 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv189 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv185 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 3147 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv183 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 3155 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14) : 'freshtv184)) : 'freshtv186)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv187 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv188)) : 'freshtv190)) : 'freshtv192)
    | THROW ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv201 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState3 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv199 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv195 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 3202 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv193 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 3210 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_CHAR _v ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
            | ER_IDENT _v ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
            | ER_INT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
            | ER_STRING _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
            | FALSE ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | LPAREN ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState5
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5) : 'freshtv194)) : 'freshtv196)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv197 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv198)) : 'freshtv200)) : 'freshtv202)
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3) : 'freshtv204)

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv13) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _v : 'tv_expression = 
# 27 "parser.mly"
        ( Expr.EBool (false) )
# 3257 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv14)

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "parser.mly"
      (string)
# 3264 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv11) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_1 : (
# 2 "parser.mly"
      (string)
# 3274 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 22 "parser.mly"
            ( Expr.EString (String.sub (_1) 1 ((String.length _1) - 2)) )
# 3279 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv12)

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 1 "parser.mly"
      (int)
# 3286 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv9) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (n : (
# 1 "parser.mly"
      (int)
# 3296 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 21 "parser.mly"
             ( Expr.EInt (n) )
# 3301 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv10)

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "parser.mly"
      (string)
# 3308 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv7) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_1 : (
# 2 "parser.mly"
      (string)
# 3318 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 24 "parser.mly"
           ( Expr.EVar (_1) )
# 3323 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv8)

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "parser.mly"
      (string)
# 3330 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_1 : (
# 2 "parser.mly"
      (string)
# 3340 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 23 "parser.mly"
          ( Expr.EChar (String.get _1 1) )
# 3345 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv6)

and start : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 9 "parser.mly"
      (Expr.expr)
# 3352 "parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = lexer lexbuf in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_startp = lexbuf.Lexing.lex_start_p;
        _menhir_endp = lexbuf.Lexing.lex_curr_p;
        _menhir_shifted = 4611686018427387903;
        }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv3) = () in
    ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
    let _tok = _menhir_env._menhir_token in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | ER_CHAR _v ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_IDENT _v ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_INT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_STRING _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | FALSE ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LPAREN ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2)) : 'freshtv4))



