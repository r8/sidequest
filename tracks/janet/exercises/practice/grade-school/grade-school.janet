# A school is a mutable table made by make-school; add changes it, roster and grade read it.

(defn make-school
  "(make-school) -> a new school with no students"
  []
  (error "implement me"))

(defn add
  "(add school name grade) -> true when the student was added; false, leaving school as it was, when name is already enrolled"
  [school name grade]
  (error "implement me"))

(defn grade
  "(grade school grade) -> the names of the students in grade, sorted"
  [school grade]
  (error "implement me"))

(defn roster
  "(roster school) -> the names of every student, sorted by grade and then by name"
  [school]
  (error "implement me"))
