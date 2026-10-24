import test
import customs-desk

pub fun main()
  run([
    test("1. no bottles are allowed") { assert-equal(Right(0), check-bottles(0)) },
    test("1. four bottles are allowed") { assert-equal(Right(4), check-bottles(4)) },
    test("1. five bottles are too many") { assert-equal(Left("too many bottles"), check-bottles(5)) },
    test("1. a negative count is rejected") { assert-equal(Left("bottles cannot be negative"), check-bottles(-1)) },
    test("2. a little cash is fine") { assert-equal(Right(800), check-cash(800)) },
    test("2. exactly 10000 need not be declared") { assert-equal(Right(10000), check-cash(10000)) },
    test("2. more than 10000 must be declared") { assert-equal(Left("declare cash over 10000"), check-cash(10001)) },
    test("3. a number is read") { assert-equal(Right(250), read-amount("250")) },
    test("3. zero is read") { assert-equal(Right(0), read-amount("0")) },
    test("3. a word is unreadable") { assert-equal(Left("unreadable: lots"), read-amount("lots")) },
    test("3. an empty form is unreadable") { assert-equal(Left("unreadable: "), read-amount("")) },
    test("4. a declaration that passes") { assert-equal(Right((3, 900)), check-declaration(3, 900)) },
    test("4. too much cash") { assert-equal(Left("declare cash over 10000"), check-declaration(2, 12000)) },
    test("4. too many bottles") { assert-equal(Left("too many bottles"), check-declaration(7, 50)) },
    test("4. the bottles are reported first") { assert-equal(Left("too many bottles"), check-declaration(9, 20000)) },
    test("5. a traveller is welcomed") { assert-equal("Welcome to the island!", verdict(Right((1, 100)))) },
    test("5. a traveller is stopped") {
      assert-equal("Please step aside: declare cash over 10000", verdict(Left("declare cash over 10000")))
    },
    test("5. a whole declaration is judged") {
      assert-equal("Please step aside: too many bottles", verdict(check-declaration(5, 0)))
    },
  ])
