import test
import matrix

pub fun main()
  run([
    test("extract row from one number matrix") { assert-equal([1], row("1", 1)) },
    test("can extract row") { assert-equal([3, 4], row("1 2\n3 4", 2)) },
    test("extract row where numbers have different widths") { assert-equal([10, 20], row("1 2\n10 20", 2)) },
    test("can extract row from non-square matrix with no corresponding column") { assert-equal([8, 7, 6], row("1 2 3\n4 5 6\n7 8 9\n8 7 6", 4)) },
    test("extract column from one number matrix") { assert-equal([1], column("1", 1)) },
    test("can extract column") { assert-equal([3, 6, 9], column("1 2 3\n4 5 6\n7 8 9", 3)) },
    test("can extract column from non-square matrix with no corresponding row") { assert-equal([4, 8, 6], column("1 2 3 4\n5 6 7 8\n9 8 7 6", 4)) },
    test("extract column where numbers have different widths") { assert-equal([1903, 3, 4], column("89 1903 3\n18 3 1\n9 4 800", 2)) },
  ])
