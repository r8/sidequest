import test
import book-store

pub fun main()
  run([
    test("Only a single book") { assert-equal(800, total([1])) },
    test("Two of the same book") { assert-equal(1600, total([2, 2])) },
    test("Empty basket") { assert-equal(0, total([])) },
    test("Two different books") { assert-equal(1520, total([1, 2])) },
    test("Three different books") { assert-equal(2160, total([1, 2, 3])) },
    test("Four different books") { assert-equal(2560, total([1, 2, 3, 4])) },
    test("Five different books") { assert-equal(3000, total([1, 2, 3, 4, 5])) },
    test("Two groups of four is cheaper than group of five plus group of three") { assert-equal(5120, total([1, 1, 2, 2, 3, 3, 4, 5])) },
    test("Two groups of four is cheaper than groups of five and three") { assert-equal(5120, total([1, 1, 2, 3, 4, 4, 5, 5])) },
    test("Group of four plus group of two is cheaper than two groups of three") { assert-equal(4080, total([1, 1, 2, 2, 3, 4])) },
    test("Two each of first four books and one copy each of rest") { assert-equal(5560, total([1, 1, 2, 2, 3, 3, 4, 4, 5])) },
    test("Two copies of each book") { assert-equal(6000, total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])) },
    test("Three copies of first book and two each of remaining") { assert-equal(6800, total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1])) },
    test("Three each of first two books and two each of remaining books") { assert-equal(7520, total([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2])) },
    test("Four groups of four are cheaper than two groups each of five and three") { assert-equal(10240, total([1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5])) },
    test("Check that groups of four are created properly even when there are more groups of three than groups of five") { assert-equal(14560, total([1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5])) },
    test("One group of one and four is cheaper than one group of two and three") { assert-equal(3360, total([1, 1, 2, 3, 4])) },
    test("One group of one and two plus three groups of four is cheaper than one group of each size") { assert-equal(10000, total([1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5])) },
  ])
