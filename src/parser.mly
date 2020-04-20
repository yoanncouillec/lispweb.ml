%token<int> ER_INT
%token<string> ER_CHAR_ESC
%token<string> ER_IDENT ER_STRING ER_CHAR ER_IDENT_OPT
%token LPAREN RPAREN LAMBDA LET LETREC DEFINE LETSTAR LOAD EVAL
%token TRUE FALSE IF COND ELSE EOF BEGIN EQUAL SET NOT AND
%token CAR CDR CONS LIST
%token CATCH THROW CALLCC BLOCK RETURNFROM HOSTCALL CALLWITHNEWTHREAD
%token PLUS MINUS MULT DIV
%token CQUOTE CQUASIQUOTE CUNQUOTE
%start start
%type <Expr.expr option> start

%%

start: 
| e = expressions EOF { Some(Expr.EBegin e) }

expressions:
| expression { [$1] }
| expression expressions { $1 :: $2 }

expression:
| n = ER_INT { Expr.EInt (n) }
| ER_STRING { Expr.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
| ER_CHAR { Expr.EChar (String.get $1 1) }
| ER_CHAR_ESC { Expr.EChar (match $1 with "'\\n'" -> '\n' | "'\\r'" -> '\r' | _ -> failwith "ER_CHAR_ESC") }
| ER_IDENT { Expr.EVar ($1) }
| CQUOTE expression { Expr.EQuote ($2) }
| CQUASIQUOTE expression { Expr.EQuasiQuote ($2) }
| CUNQUOTE expression { Expr.EUnQuote ($2) }
| TRUE { Expr.EBool (true) }
| FALSE { Expr.EBool (false) }
| LPAREN EVAL expression RPAREN { Expr.EEval $3 }
| LPAREN LOAD expression RPAREN { Expr.ELoad $3 }
| LPAREN NOT expression RPAREN { Expr.ENot ($3) }
| LPAREN AND expression expression RPAREN { Expr.EAnd ($3, $4) }
| LPAREN PLUS expression expression RPAREN { Expr.EBinary(Expr.OPlus,$3,$4) }
| LPAREN MINUS expression expression RPAREN { Expr.EBinary(Expr.OMinus,$3,$4) }
| LPAREN MULT expression expression RPAREN { Expr.EBinary(Expr.OMult,$3,$4) }
| LPAREN DIV expression expression RPAREN { Expr.EBinary(Expr.ODiv,$3,$4) }
| LPAREN CATCH ER_IDENT expression RPAREN { Expr.ECatch($3,$4) }
| LPAREN THROW ER_IDENT expression RPAREN { Expr.EThrow($3,$4) }
| LPAREN BLOCK ER_IDENT expression RPAREN { Expr.EBlock($3,$4) }
| LPAREN RETURNFROM ER_IDENT expression RPAREN { Expr.EReturnFrom($3,$4) }
| LPAREN CALLCC ER_IDENT expression RPAREN { Expr.ECallcc($3,$4) }
| LPAREN CAR expression RPAREN { Expr.ECar($3) }
| LPAREN CDR expression  RPAREN { Expr.ECdr($3) }
| LPAREN CONS expression expression RPAREN { Expr.ECons($3,$4) }
| LPAREN LIST RPAREN { Expr.EList([]) }
| LPAREN LIST expressions RPAREN { Expr.EList($3) }
| LPAREN IF expression expression expression RPAREN { Expr.EIf ($3, $4, $5) }
| LPAREN COND clauses RPAREN { Expr.ECond ($3) }
| LPAREN LAMBDA LPAREN RPAREN expressions RPAREN { Expr.EThunk (Expr.EBegin $5) }
| LPAREN LAMBDA LPAREN parameters RPAREN expressions RPAREN { List.fold_left (fun a b -> Expr.ELambda(b,a)) (Expr.ELambda (List.hd ((List.rev $4)), (Expr.EBegin $6))) (List.tl (List.rev $4)) }
| LPAREN LET LPAREN ER_IDENT expression RPAREN expressions RPAREN { Expr.ELet ([($4, $5)], Expr.EBegin $7, []) }
| LPAREN LET LPAREN bindings RPAREN expressions RPAREN { Expr.ELet ($4, Expr.EBegin $6, []) }
| LPAREN LETSTAR LPAREN bindings RPAREN expressions RPAREN { List.fold_left (fun a b -> Expr.ELet ([fst b, snd b], a, [])) (Expr.ELet ([fst (List.hd (List.rev $4)), snd (List.hd (List.rev $4))], Expr.EBegin $6, [])) (List.tl (List.rev $4)) }
| LPAREN DEFINE ER_IDENT expression RPAREN { Expr.EDefine ($3, $4) }
| LPAREN LETREC LPAREN ER_IDENT expression RPAREN expression RPAREN { Expr.ELet ([$4, Expr.EInt 0], Expr.ELet ([$4^"-rec-tmp", $5], Expr.EBegin([Expr.ESet($4,Expr.EVar ($4^"-rec-tmp"));$7]),[]),[]) }
| LPAREN SET ER_IDENT expression RPAREN { Expr.ESet($3, $4) }
| LPAREN EQUAL expression expression RPAREN { Expr.EEqual ($3,$4) }
| LPAREN BEGIN expressions RPAREN { Expr.EBegin ($3) }
| LPAREN HOSTCALL ER_IDENT RPAREN { Expr.EHostCall ($3,Expr.EList []) }
| LPAREN HOSTCALL ER_IDENT expressions RPAREN { Expr.EHostCall ($3,Expr.EList $4) }
| LPAREN CALLWITHNEWTHREAD expression RPAREN { Expr.ECallWithNewThread $3 }
| LPAREN expression RPAREN { Expr.EThunkApp $2 }
| LPAREN expression arguments RPAREN { List.fold_left (fun a b -> Expr.EApp(a,b)) (Expr.EApp ($2, List.hd $3)) (List.tl $3)}

parameters:
| parameter { [$1] }
| parameter parameters { $1::$2 } 

parameter:
| ER_IDENT { Expr.Param($1) }
| ER_IDENT_OPT expression { Expr.ParamOpt($1, $2) }

arguments:
| argument { [$1] }
| argument arguments { $1::$2 }

argument:
| expression { Expr.Arg($1) }
| ER_IDENT_OPT expression { Expr.ArgOpt($1, $2) }

bindings:
| LPAREN ER_IDENT expression RPAREN { [($2, $3)] }
| LPAREN ER_IDENT expression RPAREN bindings { ($2, $3)::$5 }

clauses:
| clause { [$1] }
| clause clauses { $1::$2 }

clause:
| LPAREN expression expression RPAREN { Expr.EClause($2, $3) }
| LPAREN ELSE expression RPAREN { Expr.EElseClause($3) }
