exception Error

type token = 
  | TRUE
  | THROW
  | RPAREN
  | LPAREN
  | LIST
  | LET
  | LAMBDA
  | IF
  | FALSE
  | ER_INT of (
# 1 "parser.mly"
      (int)
# 17 "parser.ml"
)
  | ER_IDENT of (
# 2 "parser.mly"
      (string)
# 22 "parser.ml"
)
  | EQUAL
  | EOF
  | CONS
  | CDR
  | CATCH
  | CAR
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
  | MenhirState55
  | MenhirState52
  | MenhirState49
  | MenhirState46
  | MenhirState42
  | MenhirState39
  | MenhirState38
  | MenhirState35
  | MenhirState34
  | MenhirState31
  | MenhirState30
  | MenhirState29
  | MenhirState26
  | MenhirState20
  | MenhirState18
  | MenhirState14
  | MenhirState10
  | MenhirState4
  | MenhirState2
  | MenhirState0

let _eRR =
  Error

let rec _menhir_goto_expressions : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expressions -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv305 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv303 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv299 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv297 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 29 "parser.mly"
                                 ( Deno.EList(_3) )
# 89 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv298)) : 'freshtv300)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv301 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv302)) : 'freshtv304)) : 'freshtv306)
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv309 * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv307 * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _1), _, _2) = _menhir_stack in
        let _v : 'tv_expressions = 
# 16 "parser.mly"
                         ( _1 :: _2 )
# 108 "parser.ml"
         in
        _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv308)) : 'freshtv310)
    | MenhirState52 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv319 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv317 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv313 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv311 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 34 "parser.mly"
                                  ( Deno.EBegin (_3) )
# 130 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv312)) : 'freshtv314)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv315 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expressions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv316)) : 'freshtv318)) : 'freshtv320)
    | _ ->
        let (() : unit) = () in
        ((Printf.fprintf Pervasives.stderr "Internal failure -- please contact the parser generator's developers.\n%!";
        assert false) : 'freshtv321)

and _menhir_goto_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_expression -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState4 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv153 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 154 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv151 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 162 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv147 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 171 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv145 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 178 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 24 "parser.mly"
                                          ( Deno.EThrow(_3,_4) )
# 184 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv146)) : 'freshtv148)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv149 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 194 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv150)) : 'freshtv152)) : 'freshtv154)
    | MenhirState52 | MenhirState14 | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv159 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv157 * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState14
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState14
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState14
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv155 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _1) = _menhir_stack in
            let _v : 'tv_expressions = 
# 15 "parser.mly"
             ( [_1] )
# 224 "parser.ml"
             in
            _menhir_goto_expressions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv156)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14) : 'freshtv158)) : 'freshtv160)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv169 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 236 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv167 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 244 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv163 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 253 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv161 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 260 "parser.ml"
            )) * _menhir_state * 'tv_expression) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
            | ER_INT _v ->
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
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState20) : 'freshtv162)) : 'freshtv164)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv165 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 285 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv166)) : 'freshtv168)) : 'freshtv170)
    | MenhirState20 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv179 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 294 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv177 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 302 "parser.ml"
        )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv173 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 311 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv171 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 318 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _), _4), _, _5), _, _7) = _menhir_stack in
            let _v : 'tv_expression = 
# 32 "parser.mly"
                                                                 ( Deno.ELet (_4, _5, _7) )
# 324 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv172)) : 'freshtv174)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv175 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 334 "parser.ml"
            )) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv176)) : 'freshtv178)) : 'freshtv180)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv189 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 343 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv187 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 351 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv183 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 360 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv181 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 367 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _4), _, _6) = _menhir_stack in
            let _v : 'tv_expression = 
# 31 "parser.mly"
                                                         ( Deno.ELambda (_4, _6) )
# 373 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv182)) : 'freshtv184)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv185 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 383 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv186)) : 'freshtv188)) : 'freshtv190)
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv193 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv191 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState30
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState30
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState30
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState30) : 'freshtv192)) : 'freshtv194)
    | MenhirState30 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv197 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv195 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31) : 'freshtv196)) : 'freshtv198)
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv207 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv205 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv201 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv199 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((((_menhir_stack, _menhir_s), _), _, _3), _, _4), _, _5) = _menhir_stack in
            let _v : 'tv_expression = 
# 30 "parser.mly"
                                                    ( Deno.EIf (_3, _4, _5) )
# 452 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv200)) : 'freshtv202)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv203 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv204)) : 'freshtv206)) : 'freshtv208)
    | MenhirState34 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv211 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv209 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35) : 'freshtv210)) : 'freshtv212)
    | MenhirState35 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv221 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv219 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv215 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv213 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 33 "parser.mly"
                                            ( Deno.EEqual (_3,_4) )
# 504 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv214)) : 'freshtv216)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv217 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv218)) : 'freshtv220)) : 'freshtv222)
    | MenhirState38 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv225 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv223 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState39) : 'freshtv224)) : 'freshtv226)
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv235 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv233 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv229 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv227 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _, _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 27 "parser.mly"
                                           ( Deno.ECons(_3,_4) )
# 556 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv228)) : 'freshtv230)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv231 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv232)) : 'freshtv234)) : 'freshtv236)
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv245 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv243 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv239 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv237 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 26 "parser.mly"
                                ( Deno.ECdr(_3) )
# 585 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv238)) : 'freshtv240)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv241 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv242)) : 'freshtv244)) : 'freshtv246)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv255 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 600 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv253 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 608 "parser.ml"
        )) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv249 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 617 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv247 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 624 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), _), _3), _, _4) = _menhir_stack in
            let _v : 'tv_expression = 
# 23 "parser.mly"
                                          ( Deno.ECatch(_3,_4) )
# 630 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv248)) : 'freshtv250)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv251 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 640 "parser.ml"
            )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv252)) : 'freshtv254)) : 'freshtv256)
    | MenhirState49 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv265 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv263 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv259 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv257 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 25 "parser.mly"
                               ( Deno.ECar(_3) )
# 663 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv258)) : 'freshtv260)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv261 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv262)) : 'freshtv264)) : 'freshtv266)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv269 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv267 * _menhir_state) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState55) : 'freshtv268)) : 'freshtv270)
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv279 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv277 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv273 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv271 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, _2), _, _3) = _menhir_stack in
            let _v : 'tv_expression = 
# 35 "parser.mly"
                                      ( Deno.EApp (_2, _3) )
# 715 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv272)) : 'freshtv274)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv275 * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv276)) : 'freshtv278)) : 'freshtv280)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv295 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        let _tok = _menhir_env._menhir_token in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv293 * _menhir_state * 'tv_expression) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv289 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv287 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, e) = _menhir_stack in
            let _v : (
# 7 "parser.mly"
      (Deno.expr)
# 743 "parser.ml"
            ) = 
# 12 "parser.mly"
                     ( e )
# 747 "parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv285) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 7 "parser.mly"
      (Deno.expr)
# 755 "parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv283) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 7 "parser.mly"
      (Deno.expr)
# 763 "parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv281) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_1 : (
# 7 "parser.mly"
      (Deno.expr)
# 771 "parser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv282)) : 'freshtv284)) : 'freshtv286)) : 'freshtv288)) : 'freshtv290)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv291 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv292)) : 'freshtv294)) : 'freshtv296)

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
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv105 * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv106)
    | MenhirState52 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv107 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv108)
    | MenhirState49 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv109 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv111 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 817 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv112)
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv113 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv115 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv116)
    | MenhirState38 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv117 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv118)
    | MenhirState35 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv119 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv120)
    | MenhirState34 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv121 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv122)
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv123 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv124)
    | MenhirState30 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv125 * _menhir_state) * _menhir_state) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv126)
    | MenhirState29 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv127 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv128)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv129 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 866 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv130)
    | MenhirState20 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv131 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 875 "parser.ml"
        )) * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv132)
    | MenhirState18 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv133 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 884 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv134)
    | MenhirState14 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv135 * _menhir_state * 'tv_expression) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv136)
    | MenhirState10 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv137 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv138)
    | MenhirState4 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv139 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 903 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv140)
    | MenhirState2 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv141 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv142)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv143) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv144)

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv103) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _v : 'tv_expression = 
# 21 "parser.mly"
       ( Deno.EBool (true) )
# 926 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv104)

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _tok = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv101 * _menhir_state) = _menhir_stack in
    let (_tok : token) = _tok in
    ((match _tok with
    | BEGIN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv13 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv11 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState52
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState52
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState52
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52) : 'freshtv12)) : 'freshtv14)
    | CAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv17 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv15 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState49
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState49) : 'freshtv16)) : 'freshtv18)
    | CATCH ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
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
# 1002 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv19 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1010 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState46 _v
            | ER_INT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState46 _v
            | FALSE ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState46
            | LPAREN ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState46
            | TRUE ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState46
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46) : 'freshtv20)) : 'freshtv22)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv23 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)) : 'freshtv26)) : 'freshtv28)
    | CDR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv31 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv29 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42) : 'freshtv30)) : 'freshtv32)
    | CONS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv33 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState38 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState38) : 'freshtv34)) : 'freshtv36)
    | EQUAL ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv37 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | ER_INT _v ->
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
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState34) : 'freshtv38)) : 'freshtv40)
    | ER_IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | ER_INT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | FALSE ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | IF ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv43 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv41 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState29
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState29) : 'freshtv42)) : 'freshtv44)
    | LAMBDA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv65 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv63 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv59 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv57 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv53 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "parser.mly"
      (string)
# 1161 "parser.ml"
                )) = _v in
                ((let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv51 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1169 "parser.ml"
                )) = _menhir_stack in
                let (_tok : token) = _tok in
                ((match _tok with
                | RPAREN ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (('freshtv47 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1178 "parser.ml"
                    )) = Obj.magic _menhir_stack in
                    ((let _tok = _menhir_discard _menhir_env in
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (('freshtv45 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1185 "parser.ml"
                    )) = _menhir_stack in
                    let (_tok : token) = _tok in
                    ((match _tok with
                    | ER_IDENT _v ->
                        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
                    | ER_INT _v ->
                        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
                    | FALSE ->
                        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState26
                    | LPAREN ->
                        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState26
                    | TRUE ->
                        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState26
                    | _ ->
                        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                        _menhir_env._menhir_shifted <- (-1);
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26) : 'freshtv46)) : 'freshtv48)
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (('freshtv49 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1210 "parser.ml"
                    )) = Obj.magic _menhir_stack in
                    ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv50)) : 'freshtv52)) : 'freshtv54)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv55 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv56)) : 'freshtv58)) : 'freshtv60)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv61 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv62)) : 'freshtv64)) : 'freshtv66)
    | LET ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv81 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv79 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | LPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv75 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv73 * _menhir_state) * _menhir_state) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv69 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "parser.mly"
      (string)
# 1252 "parser.ml"
                )) = _v in
                ((let _menhir_stack = (_menhir_stack, _v) in
                let _tok = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv67 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1260 "parser.ml"
                )) = _menhir_stack in
                let (_tok : token) = _tok in
                ((match _tok with
                | ER_IDENT _v ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
                | ER_INT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
                | FALSE ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState18
                | LPAREN ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState18
                | TRUE ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState18
                | _ ->
                    assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                    _menhir_env._menhir_shifted <- (-1);
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18) : 'freshtv68)) : 'freshtv70)
            | _ ->
                assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
                _menhir_env._menhir_shifted <- (-1);
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv71 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)) : 'freshtv74)) : 'freshtv76)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv77 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)) : 'freshtv80)) : 'freshtv82)
    | LIST ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv89 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv87 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
        | ER_INT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
        | FALSE ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState10
        | LPAREN ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState10
        | RPAREN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv85 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState10 in
            ((let _ = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv83 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_ : _menhir_state) = _menhir_s in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            let _v : 'tv_expression = 
# 28 "parser.mly"
                     ( Deno.EList([]) )
# 1322 "parser.ml"
             in
            _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv84)) : 'freshtv86)
        | TRUE ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState10
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState10) : 'freshtv88)) : 'freshtv90)
    | LPAREN ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | THROW ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv99 * _menhir_state) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState2 in
        ((let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _tok = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv97 * _menhir_state) * _menhir_state) = _menhir_stack in
        let (_tok : token) = _tok in
        ((match _tok with
        | ER_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv93 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "parser.mly"
      (string)
# 1349 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _tok = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv91 * _menhir_state) * _menhir_state) * (
# 2 "parser.mly"
      (string)
# 1357 "parser.ml"
            )) = _menhir_stack in
            let (_tok : token) = _tok in
            ((match _tok with
            | ER_IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
            | ER_INT _v ->
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
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState4) : 'freshtv92)) : 'freshtv94)
        | _ ->
            assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
            _menhir_env._menhir_shifted <- (-1);
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv95 * _menhir_state) * _menhir_state) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv96)) : 'freshtv98)) : 'freshtv100)
    | TRUE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | _ ->
        assert (Pervasives.(<>) _menhir_env._menhir_shifted (-1));
        _menhir_env._menhir_shifted <- (-1);
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2) : 'freshtv102)

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv9) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _v : 'tv_expression = 
# 22 "parser.mly"
        ( Deno.EBool (false) )
# 1398 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv10)

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 1 "parser.mly"
      (int)
# 1405 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv7) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (n : (
# 1 "parser.mly"
      (int)
# 1415 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 19 "parser.mly"
             ( Deno.EInt (n) )
# 1420 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv8)

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "parser.mly"
      (string)
# 1427 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _ = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_1 : (
# 2 "parser.mly"
      (string)
# 1437 "parser.ml"
    )) = _v in
    ((let _v : 'tv_expression = 
# 20 "parser.mly"
           ( Deno.EVar (_1) )
# 1442 "parser.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v) : 'freshtv6)

and start : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 7 "parser.mly"
      (Deno.expr)
# 1449 "parser.ml"
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
    | ER_IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | ER_INT _v ->
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
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2)) : 'freshtv4))



