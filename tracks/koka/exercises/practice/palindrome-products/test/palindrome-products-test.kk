import test
import palindrome-products

pub fun main()
  run([
    test("find the smallest palindrome from single digit factors") { assert-equal(Just((1, [(1, 1)])), smallest(1, 9)) },
    test("find the largest palindrome from single digit factors") { assert-equal(Just((9, [(1, 9), (3, 3)])), largest(1, 9)) },
    test("find the smallest palindrome from double digit factors") { assert-equal(Just((121, [(11, 11)])), smallest(10, 99)) },
    test("find the largest palindrome from double digit factors") { assert-equal(Just((9009, [(91, 99)])), largest(10, 99)) },
    test("find the smallest palindrome from triple digit factors") { assert-equal(Just((10201, [(101, 101)])), smallest(100, 999)) },
    test("find the largest palindrome from triple digit factors") { assert-equal(Just((906609, [(913, 993)])), largest(100, 999)) },
    test("find the smallest palindrome from four digit factors") { assert-equal(Just((1002001, [(1001, 1001)])), smallest(1000, 9999)) },
    test("find the largest palindrome from four digit factors") { assert-equal(Just((99000099, [(9901, 9999)])), largest(1000, 9999)) },
    test("empty result for smallest if no palindrome in the range") { assert-equal(Nothing, smallest(1002, 1003)) },
    test("empty result for largest if no palindrome in the range") { assert-equal(Nothing, largest(15, 15)) },
    test("error result for smallest if min is more than max") { assert-throws("min must be <= max") { smallest(10000, 1) } },
    test("error result for largest if min is more than max") { assert-throws("min must be <= max") { largest(2, 1) } },
    test("smallest product does not use the smallest factor") { assert-equal(Just((10988901, [(3297, 3333)])), smallest(3215, 4000)) },
    // Not in the canonical data: when the range starts at 0, the smallest palindrome is 0, and every
    // number in the range is a factor of it with 0.
    test("smallest palindrome of a range starting at zero") { assert-equal(Just((0, [(0, 0), (0, 1), (0, 2), (0, 3)])), smallest(0, 3)) },
  ])
