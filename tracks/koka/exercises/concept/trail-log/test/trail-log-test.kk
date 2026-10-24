import test
import trail-log

pub fun main()
  run([
    test("1. a hike of three legs") { assert-equal(14, total-distance([4, 7, 3])) },
    test("1. a hike of one leg") { assert-equal(9, total-distance([9])) },
    test("1. a hike with no legs") { assert-equal(0, total-distance([])) },
    test("1. a long hike") { assert-equal(55, total-distance(list(1, 10))) },
    test("2. the longest leg in the middle") { assert-equal(7, longest-leg([4, 7, 3])) },
    test("2. the longest leg last") { assert-equal(12, longest-leg([2, 5, 12])) },
    test("2. legs of equal length") { assert-equal(5, longest-leg([5, 5])) },
    test("2. no legs") { assert-equal(0, longest-leg([])) },
    test("3. ups and downs") { assert-equal(130, total-climb([100, 150, 120, 200])) },
    test("3. all the way down") { assert-equal(0, total-climb([900, 600, 300])) },
    test("3. a single waymark") { assert-equal(0, total-climb([250])) },
    test("3. no waymarks") { assert-equal(0, total-climb([])) },
    test("3. a flat stretch then a climb") { assert-equal(75, total-climb([10, 10, 85])) },
    test("4. a four kilometre trail") { assert-equal([4, 3, 2, 1], waymarks(4)) },
    test("4. a one kilometre trail") { assert-equal([1], waymarks(1)) },
    test("4. no trail") { assert-equal([], waymarks(0)) },
  ])
