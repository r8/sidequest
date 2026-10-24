import test
import grade-school

// Adds the students to `s` in order; returns the resulting school and, per student, whether it was added.
fun enroll(s : school, students : list<(string, int)>) : exn (school, list<bool>)
  match students
    Nil -> (s, [])
    Cons((name, g), rest) ->
      val (s2, was-added) = match s.add(name, g)
        Just(bigger) -> (bigger, True)
        Nothing -> (s, False)
      val (result, added) = s2.enroll(rest)
      (result, Cons(was-added, added))

fun school-of(students : list<(string, int)>) : exn school
  empty-school().enroll(students).fst

fun added(students : list<(string, int)>) : exn list<bool>
  empty-school().enroll(students).snd

pub fun main()
  run([
    test("Roster is empty when no student is added") { assert-equal([], school-of([]).roster) },
    test("Add a student") { assert-equal([True], added([("Aimee", 2)])) },
    test("Student is added to the roster") { assert-equal(["Aimee"], school-of([("Aimee", 2)]).roster) },
    test("Adding multiple students in the same grade in the roster") {
      assert-equal([True, True, True], added([("Blair", 2), ("James", 2), ("Paul", 2)]))
    },
    test("Multiple students in the same grade are added to the roster") {
      assert-equal(["Blair", "James", "Paul"], school-of([("Blair", 2), ("James", 2), ("Paul", 2)]).roster)
    },
    test("Cannot add student to same grade in the roster more than once") {
      assert-equal([True, True, False, True], added([("Blair", 2), ("James", 2), ("James", 2), ("Paul", 2)]))
    },
    test("Student not added to same grade in the roster more than once") {
      assert-equal(["Blair", "James", "Paul"], school-of([("Blair", 2), ("James", 2), ("James", 2), ("Paul", 2)]).roster)
    },
    test("Adding students in multiple grades") {
      assert-equal([True, True], added([("Chelsea", 3), ("Logan", 7)]))
    },
    test("Students in multiple grades are added to the roster") {
      assert-equal(["Chelsea", "Logan"], school-of([("Chelsea", 3), ("Logan", 7)]).roster)
    },
    test("Cannot add same student to multiple grades in the roster") {
      assert-equal([True, True, False, True], added([("Blair", 2), ("James", 2), ("James", 3), ("Paul", 3)]))
    },
    test("Student not added to multiple grades in the roster") {
      assert-equal(["Blair", "James", "Paul"], school-of([("Blair", 2), ("James", 2), ("James", 3), ("Paul", 3)]).roster)
    },
    test("Students are sorted by grades in the roster") {
      assert-equal(["Anna", "Peter", "Jim"], school-of([("Jim", 3), ("Peter", 2), ("Anna", 1)]).roster)
    },
    test("Students are sorted by name in the roster") {
      assert-equal(["Alex", "Peter", "Zoe"], school-of([("Peter", 2), ("Zoe", 2), ("Alex", 2)]).roster)
    },
    test("Students are sorted by grades and then by name in the roster") {
      val students = [("Peter", 2), ("Anna", 1), ("Barb", 1), ("Zoe", 2), ("Alex", 2), ("Jim", 3), ("Charlie", 1)]
      assert-equal(["Anna", "Barb", "Charlie", "Alex", "Peter", "Zoe", "Jim"], school-of(students).roster)
    },
    test("Grade is empty if no students in the roster") { assert-equal([], school-of([]).grade(1)) },
    test("Grade is empty if no students in that grade") {
      assert-equal([], school-of([("Peter", 2), ("Zoe", 2), ("Alex", 2), ("Jim", 3)]).grade(1))
    },
    test("Student not added to same grade more than once") {
      assert-equal(["Blair", "James", "Paul"], school-of([("Blair", 2), ("James", 2), ("James", 2), ("Paul", 2)]).grade(2))
    },
    test("Student not added to multiple grades") {
      assert-equal(["Blair", "James"], school-of([("Blair", 2), ("James", 2), ("James", 3), ("Paul", 3)]).grade(2))
    },
    test("Student not added to other grade for multiple grades") {
      assert-equal(["Paul"], school-of([("Blair", 2), ("James", 2), ("James", 3), ("Paul", 3)]).grade(3))
    },
    test("Students are sorted by name in a grade") {
      assert-equal(["Bradley", "Franklin"], school-of([("Franklin", 5), ("Bradley", 5), ("Jeff", 1)]).grade(5))
    },
  ])
