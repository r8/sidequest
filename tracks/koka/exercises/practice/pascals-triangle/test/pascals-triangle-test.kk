import test
import pascals-triangle

pub fun main()
  run([
    test("zero rows") { assert-equal([], rows(0)) },
    test("single row") { assert-equal([[1]], rows(1)) },
    test("two rows") { assert-equal([[1], [1, 1]], rows(2)) },
    test("three rows") { assert-equal([[1], [1, 1], [1, 2, 1]], rows(3)) },
    test("four rows") { assert-equal([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]], rows(4)) },
    test("five rows") { assert-equal([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]], rows(5)) },
    test("six rows") {
      assert-equal([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1]], rows(6))
    },
    test("ten rows") {
      assert-equal([
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
        [1, 5, 10, 10, 5, 1],
        [1, 6, 15, 20, 15, 6, 1],
        [1, 7, 21, 35, 35, 21, 7, 1],
        [1, 8, 28, 56, 70, 56, 28, 8, 1],
        [1, 9, 36, 84, 126, 126, 84, 36, 9, 1],
      ], rows(10))
    },
  ])
