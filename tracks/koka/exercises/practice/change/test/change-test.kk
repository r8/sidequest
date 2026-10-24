import test
import change

pub fun main()
  run([
    test("change for 1 cent") { assert-equal([1], find-fewest-coins([1, 5, 10, 25], 1)) },
    test("single coin change") { assert-equal([25], find-fewest-coins([1, 5, 10, 25, 100], 25)) },
    test("multiple coin change") { assert-equal([5, 10], find-fewest-coins([1, 5, 10, 25, 100], 15)) },
    test("change with Lilliputian Coins") { assert-equal([4, 4, 15], find-fewest-coins([1, 4, 15, 20, 50], 23)) },
    test("change with Lower Elbonia Coins") { assert-equal([21, 21, 21], find-fewest-coins([1, 5, 10, 21, 25], 63)) },
    test("large target values") { assert-equal([2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100], find-fewest-coins([1, 2, 5, 10, 20, 50, 100], 999)) },
    test("possible change without unit coins available") { assert-equal([2, 2, 2, 5, 10], find-fewest-coins([2, 5, 10, 20, 50], 21)) },
    test("another possible change without unit coins available") { assert-equal([4, 4, 4, 5, 5, 5], find-fewest-coins([4, 5], 27)) },
    test("a greedy approach is not optimal") { assert-equal([10, 10], find-fewest-coins([1, 10, 11], 20)) },
    test("no coins make 0 change") { assert-equal([], find-fewest-coins([1, 5, 10, 21, 25], 0)) },
    test("error testing for change smaller than the smallest of coins") { assert-throws("can't make target with given coins") { find-fewest-coins([5, 10], 3) } },
    test("error if no combination can add up to target") { assert-throws("can't make target with given coins") { find-fewest-coins([5, 10], 94) } },
    test("cannot find negative change values") { assert-throws("target can't be negative") { find-fewest-coins([1, 2, 5], -5) } },
  ])
