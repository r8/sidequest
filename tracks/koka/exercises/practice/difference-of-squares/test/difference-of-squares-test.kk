import test
import difference-of-squares

pub fun main()
  run([
    test("Square the sum of the numbers up to the given number > square of sum 1") { assert-equal(1, square-of-sum(1)) },
    test("Square the sum of the numbers up to the given number > square of sum 5") { assert-equal(225, square-of-sum(5)) },
    test("Square the sum of the numbers up to the given number > square of sum 100") { assert-equal(25502500, square-of-sum(100)) },
    test("Sum the squares of the numbers up to the given number > sum of squares 1") { assert-equal(1, sum-of-squares(1)) },
    test("Sum the squares of the numbers up to the given number > sum of squares 5") { assert-equal(55, sum-of-squares(5)) },
    test("Sum the squares of the numbers up to the given number > sum of squares 100") { assert-equal(338350, sum-of-squares(100)) },
    test("Subtract sum of squares from square of sums > difference of squares 1") { assert-equal(0, difference-of-squares(1)) },
    test("Subtract sum of squares from square of sums > difference of squares 5") { assert-equal(170, difference-of-squares(5)) },
    test("Subtract sum of squares from square of sums > difference of squares 100") { assert-equal(25164150, difference-of-squares(100)) },
  ])
