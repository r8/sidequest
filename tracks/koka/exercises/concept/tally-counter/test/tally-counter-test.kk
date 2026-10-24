import test
import tally-counter

// A walk along the north shore.
fun north-shore() : spot string
  spot("mallard")
  spot("coot")
  spot("mallard")
  spot("grebe")
  "north shore"

pub fun main()
  run([
    test("1. tickets count up from the first number") {
      assert-equal([100, 101, 102], numbered(100) { [ticket(), ticket(), ticket()] })
    },
    test("1. one ticket") { assert-equal(1, numbered(1) { ticket() }) },
    test("1. no tickets") { assert-equal("quiet day", numbered(5) { "quiet day" }) },
    test("1. each handler numbers on its own") {
      assert-equal((10, 20, 11), numbered(10) { val a = ticket(); val b = numbered(20) { ticket() }; (a, b, ticket()) })
    },
    test("2. counting a walk") { assert-equal(("north shore", 4), count-spots(north-shore)) },
    test("2. counting two birds") {
      assert-equal(("pier", 2), count-spots { spot("mallard"); spot("coot"); "pier" })
    },
    test("2. counting no birds") { assert-equal((7, 0), count-spots { 7 }) },
    test("2. nested counts count their own birds") {
      assert-equal((("pier", 1), 1), count-spots { spot("coot"); count-spots { spot("teal"); "pier" } })
    },
    test("3. the log of a walk") {
      assert-equal(("north shore", ["mallard", "coot", "mallard", "grebe"]), spotted(north-shore))
    },
    test("3. the log keeps the order") {
      assert-equal((3, ["teal", "coot"]), spotted { spot("teal"); spot("coot"); 3 })
    },
    test("3. the log of no birds") { assert-equal(("empty", []), spotted { "empty" }) },
    test("4. the species of a walk") { assert-equal(3, species(north-shore)) },
    test("4. one species seen often") {
      assert-equal(1, species { spot("coot"); spot("coot"); spot("coot") })
    },
    test("4. no birds, no species") { assert-equal(0, species { 42 }) },
    test("4. the walk's result is ignored") {
      assert-equal(2, species { spot("teal"); spot("grebe"); [1, 2, 3] })
    },
  ])
