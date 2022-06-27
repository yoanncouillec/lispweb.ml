type schoolPerson =
  | Teacher
  | Director
  | Student of string

let greeting = function
  | Teacher -> "Hey Professor!"
  | Director -> "Hello Director."
  | Student("Richard") -> "Still here Ricky?"
  | Student(anyOtherName) -> "Hey, " ^ anyOtherName ^ "."
