%token<string> ER_OPT ER_ARG
%token EOF
%start start
%type <Opt.opt> start
%%

start: 
| opts EOF { $1 }

opts:
| opt { [$1] }
| opt opts { $1 :: $2 }

opt:
| ER_OPT { ($1,None) }
| ER_OPT ER_ARG { ($1, Some $2) }
