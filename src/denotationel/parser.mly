%token<int> ER_INT
%token<string> ER_IDENT ER_STRING
%token LPAREN RPAREN LAMBDA LET LETREC 
%token TRUE FALSE IF EOF BEGIN EQUAL SET QUOTE
%token CAR CDR CONS LIST
%token CATCH THROW CALLCC BLOCK RETURNFROM
%token PLUS MINUS MULT
%start start
%type <Deno.expr> start

%%

start: 
| e = expression EOF { e }

expressions:
| expression { [$1] }
| expression expressions { $1 :: $2 }

expression:
| n = ER_INT { Deno.EInt (n) }
| ER_STRING { Deno.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
| ER_IDENT { Deno.EVar ($1) }
| QUOTE expression { Deno.EQuote ($2) }
| TRUE { Deno.EBool (true) }
| FALSE { Deno.EBool (false) }
| LPAREN PLUS expression expression RPAREN { Deno.EBinary(Deno.OPlus,$3,$4) }
| LPAREN MINUS expression expression RPAREN { Deno.EBinary(Deno.OMinus,$3,$4) }
| LPAREN MULT expression expression RPAREN { Deno.EBinary(Deno.OMult,$3,$4) }
| LPAREN CATCH ER_IDENT expression RPAREN { Deno.ECatch($3,$4) }
| LPAREN THROW ER_IDENT expression RPAREN { Deno.EThrow($3,$4) }
| LPAREN BLOCK ER_IDENT expression RPAREN { Deno.EBlock($3,$4) }
| LPAREN RETURNFROM ER_IDENT expression RPAREN { Deno.EReturnFrom($3,$4) }
| LPAREN CALLCC ER_IDENT expression RPAREN { Deno.ECallcc($3,$4) }
| LPAREN CAR expression RPAREN { Deno.ECar($3) }
| LPAREN CDR expression  RPAREN { Deno.ECdr($3) }
| LPAREN CONS expression expression RPAREN { Deno.ECons($3,$4) }
| LPAREN LIST RPAREN { Deno.EList([]) }
| LPAREN LIST expressions RPAREN { Deno.EList($3) }
| LPAREN IF expression expression expression RPAREN { Deno.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN ER_IDENT RPAREN expression RPAREN { Deno.ELambda ($4, $6) }
| LPAREN LET LPAREN ER_IDENT expression RPAREN expression RPAREN { Deno.ELet ($4, $5, $7) }
| LPAREN LETREC LPAREN ER_IDENT expression RPAREN expression RPAREN { Deno.ELet ($4, Deno.EInt 0, Deno.ELet ($4^"-rec-tmp", $5, Deno.EBegin([Deno.ESet($4,Deno.EVar ($4^"-rec-tmp"));$7]))) }
| LPAREN SET ER_IDENT expression RPAREN { Deno.ESet($3, $4) }
| LPAREN EQUAL expression expression RPAREN { Deno.EEqual ($3,$4) }
| LPAREN BEGIN expressions RPAREN { Deno.EBegin ($3) }
| LPAREN expression expression RPAREN { Deno.EApp ($2, $3) }
