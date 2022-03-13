%{


    let split_params params =
      let rec split_params_aux posparams optparams = function
	| [] -> (posparams, optparams)
	| (Expr.Param(s))::rest -> split_params_aux (s::posparams) optparams rest
    	| (Expr.ParamOpt(s,e))::rest -> split_params_aux posparams ((s,e)::optparams) rest
      in
      split_params_aux [] [] params
    
    let split_args args =
      let rec split_args_aux posargs optargs = function
	| [] -> (posargs, optargs)
	| (Expr.Arg(e))::rest -> split_args_aux (e::posargs) optargs rest
    	| (Expr.ArgOpt(s,e))::rest -> split_args_aux posargs ((s,e)::optargs) rest
      in
      split_args_aux [] [] args
    
%}

%token<int> ER_INT
%token<string> ER_IDENT ER_IDENT_OPT
%token LPAREN RPAREN LCBRACKET RCBRACKET LBRACKET RBRACKET
%token SEMICOLON COMMA
%token ARROW ASSIGNMENT
%token LET
%token IF ELSE EOF
%token PLUS
%token FUNCTION RETURN
%left PLUS

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
  | FUNCTION LPAREN parameters=parameters RPAREN LCBRACKET body=expression RCBRACKET { let (posparams, optparams) = split_params parameters in 
								 Expr.ELambda (posparams, optparams, Expr.EAnonymousBlock(body)) } 

  | LPAREN parameters=parameters RPAREN ARROW body=expression { let (posparams, optparams) = split_params parameters in ELambda (posparams, optparams, body) }
  | e=expression LPAREN args=arguments RPAREN { let (posargs, optargs) = split_args args in Expr.EApp(e,posargs, optargs) }

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

/* bindings: */
/*   | LPAREN ER_IDENT expression RPAREN { [($2, $3)] } */
/*   | LPAREN ER_IDENT expression RPAREN bindings { ($2, $3)::$5 } */

/* clauses: */
/*   | clause { [$1] } */
/*   | clause clauses { $1::$2 } */

/* clause: */
/*   | LPAREN expression expression RPAREN { Expr.EClause($2, $3) } */
/*   | LPAREN ELSE expression RPAREN { Expr.EElseClause($3) } */
