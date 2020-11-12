%{
    let remove_enclosing_quotes s = 
      String.sub (s) 1 ((String.length s) - 2)

    let replace_escape s =
      let r = Str.regexp "\\\\\"" in
      Str.global_replace r s "\""
      %}

%token<int> ER_INT
%token<string> ER_CHAR_ESC
%token<string> ER_IDENT ER_STRING ER_CHAR ER_IDENT_OPT
%token LPAREN RPAREN LAMBDA LET LETREC DEFINE LETSTAR LOAD_STRING LOAD EVAL
%token TRUE FALSE IF COND ELSE EOF BEGIN EQUAL NOT AND
%token CAR CDR CONS LIST
%token CATCH THROW CALLCC BLOCK RETURNFROM HOSTCALL CALLWITHNEWTHREAD
%token PLUS MINUS MULT DIV
%token CQUOTE CQUASIQUOTE CUNQUOTE
%token GET SET STARTWITH
%token SCHEMETOJS JSTOSTRING
%token DOT SEMICOLON COMMA ARROW VAR ASSIGNMENT LCBRACKET RCBRACKET TRY
%start start
%type <Expr.expr option> start

%%

start: 
  | e = expressions EOF { Some(Expr.EBegin (e, Some(Parsing.symbol_start_pos()))) }

expressions:
  | expression { [$1] }
  | expression SEMICOLON{ [$1] }
  | expression SEMICOLON expressions { $1 :: $3 }

expression:
  | LPAREN e=expression RPAREN { e }
  | LCBRACKET es=expressions RCBRACKET { Expr.EBegin(es,None) }
  | LET id=ER_IDENT ASSIGNMENT e=expression SEMICOLON body=expressions { Expr.ELet([(id,e)],EBegin(body,None),[],None) }
  | n = ER_INT { Expr.EInt (n, Some(Parsing.symbol_start_pos())) }
  | e1=expression PLUS e2=expression { Expr.EBinary(OPlus,e1,e2,None) } 
  | IF LPAREN expression RPAREN LCBRACKET expression RCBRACKET ELSE LCBRACKET expression RCBRACKET { Expr.EIf ($3, $6, $10, Some(Parsing.symbol_start_pos())) }
  | LPAREN p=parameters RPAREN ARROW e=expression { List.fold_left (fun a b -> Expr.ELambda(b,a, Some(Parsing.symbol_start_pos())))
								   (Expr.ELambda ((List.hd (List.rev p)), e, Some(Parsing.symbol_start_pos())))
								   (List.tl (List.rev p)) }
  | e=expression LPAREN a=arguments RPAREN { Expr.EApp(e,a) }
  | ER_IDENT { Expr.EVar ($1, Some(Parsing.symbol_start_pos())) }

parameters:
  | p=parameter { [p] }
  | p=parameter COMMA rest=parameters { p::rest } 

parameter:
  | id=ER_IDENT { Expr.Param(id) }
  | id=ER_IDENT_OPT e=expression { Expr.ParamOpt(id, e) }

arguments:
  | a=argument { [a] }
  | a=argument COMMA rest=arguments { a::rest }

argument:
  | e=expression { Expr.Arg(e) }
  | id=ER_IDENT_OPT COMMA e=expression { Expr.ArgOpt(id, e) }

bindings:
  | LPAREN ER_IDENT expression RPAREN { [($2, $3)] }
  | LPAREN ER_IDENT expression RPAREN bindings { ($2, $3)::$5 }

clauses:
  | clause { [$1] }
  | clause clauses { $1::$2 }

clause:
  | LPAREN expression expression RPAREN { Expr.EClause($2, $3) }
  | LPAREN ELSE expression RPAREN { Expr.EElseClause($3) }
