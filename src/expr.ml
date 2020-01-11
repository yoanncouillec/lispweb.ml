type operator = OPlus | OMinus | OMult

type expr =
  | EVersion
  | EInt of int
  | EBinary of operator * expr * expr
  | EBool of bool
  | ENot of expr
  | EAnd of expr * expr
  | EChar of char
  | EString of string
  | EQuote of expr
  | EQuasiQuote of expr
  | EUnQuote of expr
  | EVar of string
  | ESet of string * expr
  | EIf of expr * expr * expr
  | ELet of string * expr * expr
  | EDefine of string * expr
  | EThunk of expr
  | EThunkApp of expr
  | ELambda of string * expr
  | ELambdaDot of string * expr
  | EApp of expr * expr
  | EBegin of expr list
  | ECatch of string * expr
  | EThrow of string * expr
  | EBlock of string * expr
  | EReturnFrom of string * expr
  | ECallcc of string * expr
  | EEqual of expr * expr
  | ECar of expr
  | ECdr of expr
  | ECons of expr * expr
  | EList of expr list
  | EHostCall of string * expr
  | ELoad of expr
  | EEval of expr

