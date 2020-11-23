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
%token FUNCTION RETURN
%token DOT SEMICOLON COMMA ARROW VAR ASSIGNMENT LCBRACKET RCBRACKET TRY LBRACKET RBRACKET
%start start
%type <Expr.expr option> start

%%

start: 
  | e = expressions EOF { Some(Expr.EBegin (e)) }

expressions:
  | expression { [$1] }
  | expression SEMICOLON { [$1] }
  | expression SEMICOLON expressions { $1 :: $3 }

list_expressions:
  | expression { [$1] }
  | expression COMMA { [$1] }
  | expression COMMA expressions { $1 :: $3 }

expression:
  | LCBRACKET es=expressions RCBRACKET { Expr.EBegin(es) }
  | ER_IDENT { Expr.EVar ($1) }
  | LBRACKET es=list_expressions RBRACKET { Expr.EList(es) }
  | LET id=ER_IDENT ASSIGNMENT e=expression SEMICOLON body=expressions { Expr.ELet([(id,e)],EBegin(body),[]) }
  | n = ER_INT { Expr.EInt (n) }
  | e1=expression PLUS e2=expression { Expr.EBinary(OPlus,e1,e2) } 
  | IF LPAREN expression RPAREN LCBRACKET expression RCBRACKET ELSE LCBRACKET expression RCBRACKET { Expr.EIf ($3, $6, $10) }
  | RETURN e=expression { Expr.EAnonymousReturnFrom(e) }
  | FUNCTION LPAREN p=parameters RPAREN LCBRACKET e=expression RCBRACKET {
				   List.fold_left (fun a b -> Expr.ELambda(b,a))
						  (Expr.ELambda ((List.hd (List.rev p)), Expr.EAnonymousBlock(e)))
						  (List.tl (List.rev p)) }

  | LPAREN p=parameters RPAREN ARROW e=expression { List.fold_left (fun a b -> Expr.ELambda(b,a))
								   (Expr.ELambda ((List.hd (List.rev p)), e))
								   (List.tl (List.rev p)) }
  | e=expression LPAREN a=arguments RPAREN { Expr.EApp(e,a) }

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
