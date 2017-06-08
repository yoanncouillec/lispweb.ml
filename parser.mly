%token<int> INT
%token<string> IDENT
%token LPAREN RPAREN LAMBDA SERVE STRINGAPPEND TRUE FALSE IF QUOTE DQUOTE EOF
%start start
%type <Lispweb.expression> start

%%

start: 
| e = expression EOF { e }

expression:
| n = INT { Lispweb.EInteger (n) }
| IDENT { Lispweb.EIdent ($1) }
| QUOTE expression { Lispweb.EQuote ($2) }
| DQUOTE IDENT DQUOTE { Lispweb.EString ($2) }
| TRUE { Lispweb.EBoolean (true) }
| FALSE { Lispweb.EBoolean (false) }
| LPAREN IF expression expression expression RPAREN { Lispweb.EIf ($3, $4, $5) }
| LPAREN LAMBDA LPAREN IDENT RPAREN expression RPAREN { Lispweb.ELambda ($4, $6) }
| LPAREN SERVE LPAREN IDENT expression RPAREN RPAREN { Lispweb.EServe ($4, $5) }
| LPAREN STRINGAPPEND expression expression RPAREN { Lispweb.EStringAppend ($3, $4) }
| LPAREN expression expression RPAREN { Lispweb.EApplication ($2, $3) }