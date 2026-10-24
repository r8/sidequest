import test
import sublist

pub fun main()
  run([
    test("empty lists") { assert-equal(Equal, sublist([] : list<int>, [])) },
    test("empty list within non empty list") { assert-equal(Sublist, sublist([], [1, 2, 3])) },
    test("non empty list contains empty list") { assert-equal(Superlist, sublist([1, 2, 3], [])) },
    test("list equals itself") { assert-equal(Equal, sublist([1, 2, 3], [1, 2, 3])) },
    test("different lists") { assert-equal(Unequal, sublist([1, 2, 3], [2, 3, 4])) },
    test("false start") { assert-equal(Sublist, sublist([1, 2, 5], [0, 1, 2, 3, 1, 2, 5, 6])) },
    test("consecutive") { assert-equal(Sublist, sublist([1, 1, 2], [0, 1, 1, 1, 2, 1, 2])) },
    test("sublist at start") { assert-equal(Sublist, sublist([0, 1, 2], [0, 1, 2, 3, 4, 5])) },
    test("sublist in middle") { assert-equal(Sublist, sublist([2, 3, 4], [0, 1, 2, 3, 4, 5])) },
    test("sublist at end") { assert-equal(Sublist, sublist([3, 4, 5], [0, 1, 2, 3, 4, 5])) },
    test("at start of superlist") { assert-equal(Superlist, sublist([0, 1, 2, 3, 4, 5], [0, 1, 2])) },
    test("in middle of superlist") { assert-equal(Superlist, sublist([0, 1, 2, 3, 4, 5], [2, 3])) },
    test("at end of superlist") { assert-equal(Superlist, sublist([0, 1, 2, 3, 4, 5], [3, 4, 5])) },
    test("first list missing element from second list") { assert-equal(Unequal, sublist([1, 3], [1, 2, 3])) },
    test("second list missing element from first list") { assert-equal(Unequal, sublist([1, 2, 3], [1, 3])) },
    test("first list missing additional digits from second list") { assert-equal(Unequal, sublist([1, 2], [1, 22])) },
    test("order matters to a list") { assert-equal(Unequal, sublist([1, 2, 3], [3, 2, 1])) },
    test("same digits but different numbers") { assert-equal(Unequal, sublist([1, 0, 1], [10, 1])) },
  ])
