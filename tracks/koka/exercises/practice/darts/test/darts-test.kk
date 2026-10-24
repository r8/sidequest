import test
import darts

pub fun main()
  run([
    test("Missed target") { assert-equal(0, score(-9.0, 9.0)) },
    test("On the outer circle") { assert-equal(1, score(0.0, 10.0)) },
    test("On the middle circle") { assert-equal(5, score(-5.0, 0.0)) },
    test("On the inner circle") { assert-equal(10, score(0.0, -1.0)) },
    test("Exactly on center") { assert-equal(10, score(0.0, 0.0)) },
    test("Near the center") { assert-equal(10, score(-0.1, -0.1)) },
    test("Just within the inner circle") { assert-equal(10, score(0.7, 0.7)) },
    test("Just outside the inner circle") { assert-equal(5, score(0.8, -0.8)) },
    test("Just within the middle circle") { assert-equal(5, score(-3.5, 3.5)) },
    test("Just outside the middle circle") { assert-equal(1, score(-3.6, -3.6)) },
    test("Just within the outer circle") { assert-equal(1, score(-7.0, 7.0)) },
    test("Just outside the outer circle") { assert-equal(0, score(7.1, -7.1)) },
    test("Asymmetric position between the inner and middle circles") { assert-equal(5, score(0.5, -4.0)) },
  ])
