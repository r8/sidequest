import test
import prime-factors

pub fun main()
  run([
    test("no factors") { assert-equal([], factors(1)) },
    test("prime number") { assert-equal([2], factors(2)) },
    test("another prime number") { assert-equal([3], factors(3)) },
    test("square of a prime") { assert-equal([3, 3], factors(9)) },
    test("product of first prime") { assert-equal([2, 2], factors(4)) },
    test("cube of a prime") { assert-equal([2, 2, 2], factors(8)) },
    test("product of second prime") { assert-equal([3, 3, 3], factors(27)) },
    test("product of third prime") { assert-equal([5, 5, 5, 5], factors(625)) },
    test("product of first and second prime") { assert-equal([2, 3], factors(6)) },
    test("product of primes and non-primes") { assert-equal([2, 2, 3], factors(12)) },
    test("product of primes") { assert-equal([5, 17, 23, 461], factors(901255)) },
    test("factors include a large prime") { assert-equal([11, 9539, 894119], factors(93819012551)) },
  ])
