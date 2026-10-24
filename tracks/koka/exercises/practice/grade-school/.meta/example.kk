// A school roster: its students as (grade, name) pairs, ordered by grade and then by name.
abstract struct school(students : list<(int, string)>)

// empty-school() -> a school with no students
pub fun empty-school() : school
  School([])

fun before(a : (int, string), b : (int, string)) : bool
  a.fst < b.fst || (a.fst == b.fst && a.snd < b.snd)

fun insert(xs : list<(int, string)>, x : (int, string)) : list<(int, string)>
  match xs
    Cons(y, rest) | y.before(x) -> Cons(y, rest.insert(x))
    _ -> Cons(x, xs)

// add(s, name, grade) -> `s` with the student `name` added to `grade`, or Nothing if a student of
// that name is already in the school, in any grade
pub fun add(s : school, name : string, grade : int) : maybe<school>
  if s.students.any(fn(student) student.snd == name) then Nothing
  else Just(School(s.students.insert((grade, name))))

// roster(s) -> the names of all students, ordered by grade and, within a grade, by name
pub fun roster(s : school) : list<string>
  s.students.map(snd)

// grade(s, n) -> the names of the students in grade `n`, in alphabetical order
pub fun grade(s : school, n : int) : list<string>
  s.students.filter(fn(student) student.fst == n).map(snd)
