%token<int> ER_INT
%token<string> ER_IDENT ER_STRING
%token LPAREN RPAREN LAMBDA LET LETREC 
%token TRUE FALSE IF EOF BEGIN EQUAL SET QUOTE
%token CAR CDR CONS LIST
%token CATCH THROW CALLCC BLOCK RETURNFROM
%token PLUS MINUS MULT
%start start
%type <Expr.expr> start

%%

start: 
| e = expression EOF { e }

expressions:
| expression { [$1] }
| expression expressions { $1 :: $2 }

expression:
| n = ER_INT { Expr.EInt (n) }
| ER_STRING { Expr.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
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
| LPAREN LAMBDA LPAREN ER_IDENT RPAREN expression RPAREN { Expr.ELambda ($4, $6) }
| LPAREN LET LPAREN ER_IDENT expression RPAREN expression RPAREN { Expr.ELet ($4, $5, $7) }
| LPAREN LETREC LPAREN ER_IDENT expression RPAREN expression RPAREN { Expr.ELet ($4, Expr.EInt 0, Expr.ELet ($4^"-rec-tmp", $5, Expr.EBegin([Expr.ESet($4,Expr.EVar ($4^"-rec-tmp"));$7]))) }
| LPAREN SET ER_IDENT expression RPAREN { Expr.ESet($3, $4) }
| LPAREN EQUAL expression expression RPAREN { Expr.EEqual ($3,$4) }
| LPAREN BEGIN expressions RPAREN { Expr.EBegin ($3) }
| LPAREN expression expression RPAREN { Expr.EApp ($2, $3) }
