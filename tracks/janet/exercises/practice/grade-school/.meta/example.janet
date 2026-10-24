# A school is a mutable table made by make-school; add changes it, roster and grade read it.
# Here it maps each student's name to their grade.

(defn make-school
  "(make-school) -> a new school with no students"
  []
  @{})

(defn add
  "(add school name grade) -> true when the student was added; false, leaving school as it was, when name is already enrolled"
  [school name grade]
  (if (school name)
    false
    (do (put school name grade) true)))

(defn grade
  "(grade school grade) -> the names of the students in grade, sorted"
  [school grade]
  (sorted (filter |(= grade (school $)) (keys school))))

(defn roster
  "(roster school) -> the names of every student, sorted by grade and then by name"
  [school]
  (sorted (keys school) |(< [(school $0) $0] [(school $1) $1])))
