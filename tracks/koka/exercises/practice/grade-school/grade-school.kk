// A school roster: which student is in which grade. Its representation is up to you: give this type
// its constructor(s).
pub type school

// empty-school() -> a school with no students
pub fun empty-school() : exn school
  throw("implement me", ExnTodo)

// add(s, name, grade) -> `s` with the student `name` added to `grade`, or Nothing if a student of
// that name is already in the school, in any grade
pub fun add(s : school, name : string, grade : int) : exn maybe<school>
  throw("implement me", ExnTodo)

// roster(s) -> the names of all students, ordered by grade and, within a grade, by name
pub fun roster(s : school) : exn list<string>
  throw("implement me", ExnTodo)

// grade(s, n) -> the names of the students in grade `n`, in alphabetical order
pub fun grade(s : school, n : int) : exn list<string>
  throw("implement me", ExnTodo)
