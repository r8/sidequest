import test
import escape-room

val book = [("clock", "it is always half past"), ("safe", "1984"), ("globe", "spin it")]

pub fun main()
  run([
    test("1. a team that escapes") { assert-equal(Just("escaped"), attempt { "escaped" }) },
    test("1. a team that gives up") { assert-true(attempt({ give-up("too dark") }).is-nothing) },
    test("1. giving up stops the rest of the attempt") {
      var steps := 0
      val result = attempt
        steps := steps + 1
        give-up("stuck")
        steps := steps + 1
        42
      assert-equal((Nothing, 1), (result, steps))
    },
    test("1. a team that gives up only sometimes") {
      assert-equal(Just(7), attempt { if 3 > 4 then give-up("never") else 7 })
    },
    test("2. a hint from the book") {
      assert-equal(Just("it is always half past"), with-hints(book) { hint("clock") })
    },
    test("2. several hints from the book") {
      assert-equal(Just("1984, spin it"), with-hints(book) { hint("safe") ++ ", " ++ hint("globe") })
    },
    test("2. a puzzle the book has no hint for ends the game") {
      assert-equal(Nothing, with-hints(book) { hint("safe") ++ hint("bookcase") })
    },
    test("2. no hints needed") { assert-equal(Just(3), with-hints([]) { 1 + 2 }) },
    test("3. counting two hints") {
      assert-equal(Just(("1984 spin it", 2)), with-hints(book) { counting-hints { hint("safe") ++ " " ++ hint("globe") } })
    },
    test("3. counting no hints") { assert-equal(Just(("done", 0)), with-hints(book) { counting-hints { "done" } }) },
    test("3. counting the same hint twice") {
      assert-equal(Just((2, 2)), with-hints(book) { counting-hints { [hint("clock"), hint("clock")].length } })
    },
    test("3. the game still ends without a hint") {
      assert-equal(Nothing, with-hints(book) { counting-hints { hint("bookcase") } })
    },
    test("4. a strict team that needs no hints") { assert-equal(Just("out"), attempt { strict { "out" } }) },
    test("4. asking for a hint gives up") { assert-equal(Nothing, attempt { strict { hint("safe") } }) },
    test("4. the reason names the puzzle") {
      val reason = with-hints(book) { attempt { strict { hint("globe") } } }
      assert-equal(Just(Nothing), reason)
      val message = with-hints(book)
        with final ctl give-up(why) why
        strict { hint("globe") }
      assert-equal(Just("asked for a hint on globe"), message)
    },
  ])
