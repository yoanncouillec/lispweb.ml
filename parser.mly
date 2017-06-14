%token<int> INT
%token<string> IDENT STRING
%token LPAREN RPAREN LAMBDA LET LISTEN STRING_APPEND STRING_TO_INT INT_TO_STRING HTML SCRIPT FROM_SERVER TRUE FALSE IF QUOTE PLUS LIST TAG EOF
%start start
%type <Lispweb.expression> start

%%

start: 
| e = expression EOF { e }

expressions:
| expression { [$1] }
| expression expressions { $1 :: $2 }

expression:
| n = INT { Lispweb.EInteger (n) }
| IDENT { Lispweb.EIdent ($1) }
| QUOTE expression { Lispweb.EQuote ($2) }
| STRING { Lispweb.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
| TRUE { Lispweb.EBoolean (true) }
| FALSE { Lispweb.EBoolean (false) }
| LPAREN PLUS expression expression RPAREN { Lispweb.EPlus ($3, $4) }
| LPAREN IF expression expression expression RPAREN { Lispweb.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN IDENT RPAREN expression RPAREN { Lispweb.ELambda ($4, $6) }
| LPAREN LET LPAREN IDENT expression RPAREN expression RPAREN { Lispweb.ELet ($4, $5, $7) }
| LPAREN LISTEN expression RPAREN { Lispweb.EListen ($3) }
| LPAREN LIST RPAREN { Lispweb.EList ([]) }
| LPAREN LIST expressions RPAREN { Lispweb.EList ($3) }
| LPAREN TAG expression expressions RPAREN { Lispweb.ETag ($3, $4) }
| LPAREN STRING_APPEND expression expression RPAREN { Lispweb.EStringAppend ($3, $4) }
| LPAREN STRING_TO_INT expression RPAREN { Lispweb.EStringToInt ($3) }
| LPAREN INT_TO_STRING expression RPAREN { Lispweb.EIntToString ($3) }
| LPAREN HTML expression RPAREN { Lispweb.EHtml ($3) }
| LPAREN SCRIPT expression RPAREN { Lispweb.EScript ($3) }
| LPAREN FROM_SERVER IDENT RPAREN { Lispweb.EFromServer ($3) }
| LPAREN expression expression RPAREN { Lispweb.EApplication ($2, $3) }