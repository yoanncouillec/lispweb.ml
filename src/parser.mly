%token<int> INT
%token<string> IDENT STRING
%token LPAREN RPAREN LAMBDA LET LISTEN STRING_APPEND STRING_TO_INT INT_TO_STRING HTML SCRIPT FROM_SERVER TRUE FALSE IF QUOTE LIST TAG EOF
%token PLUS MINUS MULT DIV
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
| LPAREN PLUS expression expression RPAREN { Lispweb.EBinary (Lispweb.OPlus, $3, $4) }
| LPAREN MINUS expression expression RPAREN { Lispweb.EBinary (Lispweb.OMinus, $3, $4) }
| LPAREN MULT expression expression RPAREN { Lispweb.EBinary (Lispweb.OMult, $3, $4) }
| LPAREN DIV expression expression RPAREN { Lispweb.EBinary (Lispweb.ODiv, $3, $4) }
| LPAREN IF expression expression expression RPAREN { Lispweb.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN RPAREN expression RPAREN { Lispweb.ELambda ([], $5) }
| LPAREN LAMBDA LPAREN parameters RPAREN expression RPAREN { Lispweb.ELambda ($4, $6) }
| LPAREN LET LPAREN IDENT expression RPAREN expression RPAREN { Lispweb.ELet ($4, $5, $7) }
| LPAREN LISTEN expression RPAREN { Lispweb.EListen ($3) }
| LPAREN LIST RPAREN { Lispweb.EList ([]) }
| LPAREN LIST expressions RPAREN { Lispweb.EList ($3) }
 (*
 (tag <tagname> <attributes> <expression> ...)
 (tag "html" (list) "lipsum")
 (tag "html" (list (list "onclick" (script (alert "click")))) "lipsum")
 (tag "p" '(list) (tag "span" (list) "lipsum"))
 (tag "p" '(list) (tag "span" (list) "lipsum") (tag "div" (list) "webum"))
 *)
| LPAREN TAG expression expression expressions RPAREN { Lispweb.ETag ($3, $4, $5) }
| LPAREN STRING_APPEND expression expression RPAREN { Lispweb.EStringAppend ($3, $4) }
| LPAREN STRING_TO_INT expression RPAREN { Lispweb.EStringToInt ($3) }
| LPAREN INT_TO_STRING expression RPAREN { Lispweb.EIntToString ($3) }
| LPAREN HTML expression RPAREN { Lispweb.EHtml ($3) }
| LPAREN SCRIPT expression RPAREN { Lispweb.EScript ($3) }
| LPAREN FROM_SERVER IDENT RPAREN { Lispweb.EFromServer ($3) }
| LPAREN expression RPAREN { Lispweb.EApplication ($2, []) }
| LPAREN expression arguments RPAREN { Lispweb.EApplication ($2, $3) }

parameters:
| IDENT { [$1] }
| IDENT parameters { $1::$2 }

arguments:
| expression { [$1] }
| expression arguments { $1::$2 }

