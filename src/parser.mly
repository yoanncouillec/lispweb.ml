%token<int> ER_INT
%token<string> ER_IDENT ER_STRING
%token LPAREN RPAREN LAMBDA LET LISTEN STRING_APPEND STRING_TO_INT INT_TO_STRING HTML SCRIPT FROM_SERVER TRUE FALSE IF QUOTE LIST TAG EOF HOSTCALL MAKE_STRING BEGIN
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
| n = ER_INT { Lispweb.EInteger (n) }
| ER_IDENT { Lispweb.EIdent ($1) }
| QUOTE expression { Lispweb.EQuote ($2) }
| ER_STRING { Lispweb.EString (String.sub ($1) 1 ((String.length $1) - 2)) }
| TRUE { Lispweb.EBoolean (true) }
| FALSE { Lispweb.EBoolean (false) }
| LPAREN MAKE_STRING expression RPAREN { Lispweb.EMakeString ($3) }
| LPAREN PLUS expression expression RPAREN { Lispweb.EBinary (Lispweb.OPlus, $3, $4) }
| LPAREN MINUS expression expression RPAREN { Lispweb.EBinary (Lispweb.OMinus, $3, $4) }
| LPAREN MULT expression expression RPAREN { Lispweb.EBinary (Lispweb.OMult, $3, $4) }
| LPAREN DIV expression expression RPAREN { Lispweb.EBinary (Lispweb.ODiv, $3, $4) }
| LPAREN IF expression expression expression RPAREN { Lispweb.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN RPAREN expression RPAREN { Lispweb.ELambda ([], $5) }
| LPAREN LAMBDA LPAREN parameters RPAREN expression RPAREN { Lispweb.ELambda ($4, $6) }
| LPAREN LET LPAREN RPAREN expression RPAREN { Lispweb.ELet ([], $5) }
| LPAREN LET LPAREN bindings RPAREN expression RPAREN { Lispweb.ELet ($4, $6) }
| LPAREN LISTEN expression RPAREN { Lispweb.EListen ($3) }
| LPAREN LIST RPAREN { Lispweb.EList ([]) }
| LPAREN LIST expressions RPAREN { Lispweb.EList ($3) }
| LPAREN BEGIN expressions RPAREN { Lispweb.EBegin ($3) }
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
| LPAREN FROM_SERVER ER_IDENT RPAREN { Lispweb.EFromServer ($3) }
| LPAREN HOSTCALL ER_IDENT expression RPAREN { Lispweb.EHostCall($3,$4) }
| LPAREN expression RPAREN { Lispweb.EApplication ($2, []) }
| LPAREN expression arguments RPAREN { Lispweb.EApplication ($2, $3) }

bindings:
| LPAREN ER_IDENT expression RPAREN { [($2, $3)] }
| LPAREN ER_IDENT expression RPAREN bindings { ($2, $3)::$5 }

parameters:
| ER_IDENT { [$1] }
| ER_IDENT parameters { $1::$2 }

arguments:
| expression { [$1] }
| expression arguments { $1::$2 }

