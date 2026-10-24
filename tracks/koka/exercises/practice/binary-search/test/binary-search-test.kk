import test
import binary-search

pub fun main()
  run([
    test("finds a value in an array with one element") { assert-equal(Just(0), find([6].vector, 6)) },
    test("finds a value in the middle of an array") { assert-equal(Just(3), find([1, 3, 4, 6, 8, 9, 11].vector, 6)) },
    test("finds a value at the beginning of an array") { assert-equal(Just(0), find([1, 3, 4, 6, 8, 9, 11].vector, 1)) },
    test("finds a value at the end of an array") { assert-equal(Just(6), find([1, 3, 4, 6, 8, 9, 11].vector, 11)) },
    test("finds a value in an array of odd length") { assert-equal(Just(9), find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634].vector, 144)) },
    test("finds a value in an array of even length") { assert-equal(Just(5), find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377].vector, 21)) },
    test("identifies that a value is not included in the array") { assert-equal(Nothing, find([1, 3, 4, 6, 8, 9, 11].vector, 7)) },
    test("a value smaller than the array's smallest value is not found") { assert-equal(Nothing, find([1, 3, 4, 6, 8, 9, 11].vector, 0)) },
    test("a value larger than the array's largest value is not found") { assert-equal(Nothing, find([1, 3, 4, 6, 8, 9, 11].vector, 13)) },
    test("nothing is found in an empty array") { assert-equal(Nothing, find([].vector, 1)) },
    test("nothing is found when the left and right bounds cross") { assert-equal(Nothing, find([1, 2].vector, 0)) },
  ])
