%token<int> ER_INT
%token<string> ER_IDENT
%token LPAREN RPAREN LAMBDA LET TRUE FALSE IF EOF BEGIN EQUAL
%token CAR CDR CONS LIST
%token CATCH THROW
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
| ER_IDENT { Deno.EVar ($1) }
| TRUE { Deno.EBool (true) }
| FALSE { Deno.EBool (false) }
| LPAREN CATCH ER_IDENT expression RPAREN { Deno.ECatch($3,$4) }
| LPAREN THROW ER_IDENT expression RPAREN { Deno.EThrow($3,$4) }
| LPAREN CAR expression RPAREN { Deno.ECar($3) }
| LPAREN CDR expression  RPAREN { Deno.ECdr($3) }
| LPAREN CONS expression expression RPAREN { Deno.ECons($3,$4) }
| LPAREN LIST RPAREN { Deno.EList([]) }
| LPAREN LIST expressions RPAREN { Deno.EList($3) }
| LPAREN IF expression expression expression RPAREN { Deno.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN ER_IDENT RPAREN expression RPAREN { Deno.ELambda ($4, $6) }
| LPAREN LET LPAREN ER_IDENT expression RPAREN expression RPAREN { Deno.ELet ($4, $5, $7) }
| LPAREN EQUAL expression expression RPAREN { Deno.EEqual ($3,$4) }
| LPAREN BEGIN expressions RPAREN { Deno.EBegin ($3) }
| LPAREN expression expression RPAREN { Deno.EApp ($2, $3) }
