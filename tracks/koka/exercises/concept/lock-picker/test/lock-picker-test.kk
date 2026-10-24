import test
import lock-picker

// Two dials: the first shows 1 or 2, the second 3 or 4.
fun two-dials() : pick int
  val a = pick-digit([1, 2])
  val b = pick-digit([3, 4])
  a * 10 + b

pub fun main()
  run([
    test("1. a single dial") { assert-equal([5, 6, 7], all-outcomes { pick-digit([5, 6, 7]) }) },
    test("1. two dials, in the order of the options") { assert-equal([13, 14, 23, 24], all-outcomes(two-dials)) },
    test("1. dead ends leave no outcome") {
      assert-equal([1, 3], all-outcomes { val d = pick-digit([1, 2, 3]); if d == 2 then dead-end() else d })
    },
    test("1. a dial with no digits has no outcomes") { assert-equal([], all-outcomes { pick-digit([]) }) },
    test("1. a program that picks nothing has one outcome") { assert-equal([42], all-outcomes { 42 }) },
    test("2. two dials open four ways") { assert-equal(4, count-outcomes(two-dials)) },
    test("2. ten digits on one dial") { assert-equal(10, count-outcomes { pick-digit(list(0, 9)) }) },
    test("2. dead ends are not counted") {
      assert-equal(5, count-outcomes { val d = pick-digit(list(0, 9)); if d.is-odd then dead-end() else d })
    },
    test("2. a program that picks nothing finishes once") { assert-equal(1, count-outcomes { "open" }) },
    test("3. the first of two dials") { assert-equal(Just(13), first-outcome(two-dials)) },
    test("3. skips dead ends") {
      assert-equal(Just((2, 3)), first-outcome {
        val a = pick-digit([1, 2, 3])
        val b = pick-digit([1, 2, 3])
        if a + b == 5 then (a, b) else dead-end()
      })
    },
    test("3. nothing when every attempt is a dead end") {
      assert-equal(Nothing, first-outcome { val d = pick-digit([1, 2]); if d > 5 then d else dead-end() })
    },
    test("3. stops at the first outcome") {
      var tried := 0
      val found = first-outcome
        val d = pick-digit(list(0, 9))
        tried := tried + 1
        if d == 3 then d else dead-end()
      assert-equal((Just(3), 4), (found, tried))
    },
    test("4. every combination of two binary digits") {
      assert-equal([[0, 0], [0, 1], [1, 0], [1, 1]], all-outcomes { combination(2, [0, 1]) })
    },
    test("4. a three-digit lock has a thousand combinations") {
      assert-equal(1000, count-outcomes { combination(3, list(0, 9)) })
    },
    test("4. a combination of no digits") { assert-equal([[]], all-outcomes { combination(0, [1, 2]) }) },
    test("5. every opening whose digits add up to 4") {
      assert-equal([[1, 3], [2, 2], [3, 1]], all-outcomes { opening(2, [1, 2, 3], fn(c) c.sum == 4) })
    },
    test("5. finds a known combination") {
      assert-equal(Just([4, 0, 7]), first-outcome { opening(3, list(0, 9), fn(c) c == [4, 0, 7]) })
    },
    test("5. counts the openings whose digits add up to 5") {
      assert-equal(21, count-outcomes { opening(3, list(0, 9), fn(c) c.sum == 5) })
    },
    test("5. no opening fits") {
      assert-equal(Nothing, first-outcome { opening(2, [1, 2], fn(c) c.sum == 9) })
    },
  ])
