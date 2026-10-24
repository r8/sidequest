import test
import spiral-matrix

pub fun main()
  run([
    test("empty spiral") { assert-equal([], spiral-matrix(0)) },
    test("trivial spiral") { assert-equal([[1]], spiral-matrix(1)) },
    test("spiral of size 2") { assert-equal([[1, 2], [4, 3]], spiral-matrix(2)) },
    test("spiral of size 3") { assert-equal([[1, 2, 3], [8, 9, 4], [7, 6, 5]], spiral-matrix(3)) },
    test("spiral of size 4") {
      assert-equal([[1, 2, 3, 4], [12, 13, 14, 5], [11, 16, 15, 6], [10, 9, 8, 7]], spiral-matrix(4))
    },
    test("spiral of size 5") {
      assert-equal([[1, 2, 3, 4, 5], [16, 17, 18, 19, 6], [15, 24, 25, 20, 7], [14, 23, 22, 21, 8], [13, 12, 11, 10, 9]], spiral-matrix(5))
    },
  ])
