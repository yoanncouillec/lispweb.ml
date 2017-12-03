%token<int> ER_INT
%token<string> ER_IDENT ER_STRING ER_CHAR
%token LPAREN RPAREN LAMBDA LET LETREC DEFINE LETSTAR
%token TRUE FALSE IF EOF BEGIN EQUAL SET QUOTE
%token CAR CDR CONS LIST
%token CATCH THROW CALLCC BLOCK RETURNFROM HOSTCALL
%token PLUS MINUS MULT
%start start
%type <Expr.expr> start

%%

start: 
| e = expressions EOF { Expr.EList e }

expressions:
| expression { [$1] }
| expression expressions { $1 :: $2 }

expression:
| n = ER_INT { Expr.EInt (n) }
| ER_STRING { Expr.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
| ER_CHAR { Expr.EChar (String.get $1 1) }
| ER_IDENT { Expr.EVar ($1) }
| QUOTE expression { Expr.EQuote ($2) }
| TRUE { Expr.EBool (true) }
| FALSE { Expr.EBool (false) }
| LPAREN PLUS expression expression RPAREN { Expr.EBinary(Expr.OPlus,$3,$4) }
| LPAREN MINUS expression expression RPAREN { Expr.EBinary(Expr.OMinus,$3,$4) }
| LPAREN MULT expression expression RPAREN { Expr.EBinary(Expr.OMult,$3,$4) }
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
| LPAREN LAMBDA LPAREN RPAREN expression RPAREN { Expr.EThunk $5 }
| LPAREN LAMBDA LPAREN idents RPAREN expression RPAREN { List.fold_left (fun a b -> Expr.ELambda(b,a)) (Expr.ELambda (List.hd ((List.rev $4)), $6)) (List.tl (List.rev $4)) }
| LPAREN LET LPAREN ER_IDENT expression RPAREN expressions RPAREN { Expr.ELet ($4, $5, Expr.EList $7) }
| LPAREN LETSTAR LPAREN bindings RPAREN expressions RPAREN { List.fold_left (fun a b -> Expr.ELet (fst b, snd b, a)) (Expr.ELet (fst (List.hd (List.rev $4)), snd (List.hd (List.rev $4)), Expr.EList $6)) (List.tl (List.rev $4)) }
| LPAREN DEFINE ER_IDENT expression RPAREN { Expr.EDefine ($3, $4) }
| LPAREN LETREC LPAREN ER_IDENT expression RPAREN expression RPAREN { Expr.ELet ($4, Expr.EInt 0, Expr.ELet ($4^"-rec-tmp", $5, Expr.EBegin([Expr.ESet($4,Expr.EVar ($4^"-rec-tmp"));$7]))) }
| LPAREN SET ER_IDENT expression RPAREN { Expr.ESet($3, $4) }
| LPAREN EQUAL expression expression RPAREN { Expr.EEqual ($3,$4) }
| LPAREN BEGIN expressions RPAREN { Expr.EBegin ($3) }
| LPAREN HOSTCALL ER_IDENT RPAREN { Expr.EHostCall ($3,Expr.EList []) }
| LPAREN HOSTCALL ER_IDENT expressions RPAREN { Expr.EHostCall ($3,Expr.EList $4) }
| LPAREN expression RPAREN { Expr.EThunkApp $2 }
| LPAREN expression expressions RPAREN { List.fold_left (fun a b -> Expr.EApp(a,b)) (Expr.EApp ($2, List.hd $3)) (List.tl $3)}

idents:
| ER_IDENT { [$1] }
| ER_IDENT idents { $1::$2 }

bindings:
| LPAREN ER_IDENT expression RPAREN { [($2, $3)] }
| LPAREN ER_IDENT expression RPAREN bindings { ($2, $3)::$5 }