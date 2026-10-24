(import test :as t)
(import ../grade-school :as sol)

(t/deftest "Roster is empty when no student is added"
  (def school (sol/make-school))
  (t/assert-equal [] (sol/roster school)))

(t/deftest "Add a student"
  (def school (sol/make-school))
  (t/assert-true (sol/add school "Aimee" 2)))

(t/deftest "Student is added to the roster"
  (def school (sol/make-school))
  (sol/add school "Aimee" 2)
  (t/assert-equal ["Aimee"] (sol/roster school)))

(t/deftest "Adding multiple students in the same grade in the roster"
  (def school (sol/make-school))
  (t/assert-true (sol/add school "Blair" 2))
  (t/assert-true (sol/add school "James" 2))
  (t/assert-true (sol/add school "Paul" 2)))

(t/deftest "Multiple students in the same grade are added to the roster"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "Paul" 2)
  (t/assert-equal ["Blair" "James" "Paul"] (sol/roster school)))

(t/deftest "Cannot add student to same grade in the roster more than once"
  (def school (sol/make-school))
  (t/assert-true (sol/add school "Blair" 2))
  (t/assert-true (sol/add school "James" 2))
  (t/assert-false (sol/add school "James" 2))
  (t/assert-true (sol/add school "Paul" 2)))

(t/deftest "Student not added to same grade in the roster more than once"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "James" 2)
  (sol/add school "Paul" 2)
  (t/assert-equal ["Blair" "James" "Paul"] (sol/roster school)))

(t/deftest "Adding students in multiple grades"
  (def school (sol/make-school))
  (t/assert-true (sol/add school "Chelsea" 3))
  (t/assert-true (sol/add school "Logan" 7)))

(t/deftest "Students in multiple grades are added to the roster"
  (def school (sol/make-school))
  (sol/add school "Chelsea" 3)
  (sol/add school "Logan" 7)
  (t/assert-equal ["Chelsea" "Logan"] (sol/roster school)))

(t/deftest "Cannot add same student to multiple grades in the roster"
  (def school (sol/make-school))
  (t/assert-true (sol/add school "Blair" 2))
  (t/assert-true (sol/add school "James" 2))
  (t/assert-false (sol/add school "James" 3))
  (t/assert-true (sol/add school "Paul" 3)))

(t/deftest "Student not added to multiple grades in the roster"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "James" 3)
  (sol/add school "Paul" 3)
  (t/assert-equal ["Blair" "James" "Paul"] (sol/roster school)))

(t/deftest "Students are sorted by grades in the roster"
  (def school (sol/make-school))
  (sol/add school "Jim" 3)
  (sol/add school "Peter" 2)
  (sol/add school "Anna" 1)
  (t/assert-equal ["Anna" "Peter" "Jim"] (sol/roster school)))

(t/deftest "Students are sorted by name in the roster"
  (def school (sol/make-school))
  (sol/add school "Peter" 2)
  (sol/add school "Zoe" 2)
  (sol/add school "Alex" 2)
  (t/assert-equal ["Alex" "Peter" "Zoe"] (sol/roster school)))

(t/deftest "Students are sorted by grades and then by name in the roster"
  (def school (sol/make-school))
  (sol/add school "Peter" 2)
  (sol/add school "Anna" 1)
  (sol/add school "Barb" 1)
  (sol/add school "Zoe" 2)
  (sol/add school "Alex" 2)
  (sol/add school "Jim" 3)
  (sol/add school "Charlie" 1)
  (t/assert-equal ["Anna" "Barb" "Charlie" "Alex" "Peter" "Zoe" "Jim"] (sol/roster school)))

(t/deftest "Grade is empty if no students in the roster"
  (def school (sol/make-school))
  (t/assert-equal [] (sol/grade school 1)))

(t/deftest "Grade is empty if no students in that grade"
  (def school (sol/make-school))
  (sol/add school "Peter" 2)
  (sol/add school "Zoe" 2)
  (sol/add school "Alex" 2)
  (sol/add school "Jim" 3)
  (t/assert-equal [] (sol/grade school 1)))

(t/deftest "Student not added to same grade more than once"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "James" 2)
  (sol/add school "Paul" 2)
  (t/assert-equal ["Blair" "James" "Paul"] (sol/grade school 2)))

(t/deftest "Student not added to multiple grades"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "James" 3)
  (sol/add school "Paul" 3)
  (t/assert-equal ["Blair" "James"] (sol/grade school 2)))

(t/deftest "Student not added to other grade for multiple grades"
  (def school (sol/make-school))
  (sol/add school "Blair" 2)
  (sol/add school "James" 2)
  (sol/add school "James" 3)
  (sol/add school "Paul" 3)
  (t/assert-equal ["Paul"] (sol/grade school 3)))

(t/deftest "Students are sorted by name in a grade"
  (def school (sol/make-school))
  (sol/add school "Franklin" 5)
  (sol/add school "Bradley" 5)
  (sol/add school "Jeff" 1)
  (t/assert-equal ["Bradley" "Franklin"] (sol/grade school 5)))

(t/run)
