import test
import sum-of-multiples

pub fun main()
  run([
    test("no multiples within limit") { assert-equal(0, sum-of-multiples([3, 5], 1)) },
    test("one factor has multiples within limit") { assert-equal(3, sum-of-multiples([3, 5], 4)) },
    test("more than one multiple within limit") { assert-equal(9, sum-of-multiples([3], 7)) },
    test("more than one factor with multiples within limit") { assert-equal(23, sum-of-multiples([3, 5], 10)) },
    test("each multiple is only counted once") { assert-equal(2318, sum-of-multiples([3, 5], 100)) },
    test("a much larger limit") { assert-equal(233168, sum-of-multiples([3, 5], 1000)) },
    test("three factors") { assert-equal(51, sum-of-multiples([7, 13, 17], 20)) },
    test("factors not relatively prime") { assert-equal(30, sum-of-multiples([4, 6], 15)) },
    test("some pairs of factors relatively prime and some not") { assert-equal(4419, sum-of-multiples([5, 6, 8], 150)) },
    test("one factor is a multiple of another") { assert-equal(275, sum-of-multiples([5, 25], 51)) },
    test("much larger factors") { assert-equal(2203160, sum-of-multiples([43, 47], 10000)) },
    test("all numbers are multiples of 1") { assert-equal(4950, sum-of-multiples([1], 100)) },
    test("no factors means an empty sum") { assert-equal(0, sum-of-multiples([], 10000)) },
    test("the only multiple of 0 is 0") { assert-equal(0, sum-of-multiples([0], 1)) },
    test("the factor 0 does not affect the sum of multiples of other factors") { assert-equal(3, sum-of-multiples([3, 0], 4)) },
    test("solutions using include-exclude must extend to cardinality greater than 3") { assert-equal(39614537, sum-of-multiples([2, 3, 5, 7, 11], 10000)) },
  ])
