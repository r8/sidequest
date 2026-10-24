import test
import grains

pub fun main()
  run([
    test("returns the number of grains on the square > grains on square 1") { assert-equal(1, square(1)) },
    test("returns the number of grains on the square > grains on square 2") { assert-equal(2, square(2)) },
    test("returns the number of grains on the square > grains on square 3") { assert-equal(4, square(3)) },
    test("returns the number of grains on the square > grains on square 4") { assert-equal(8, square(4)) },
    test("returns the number of grains on the square > grains on square 16") { assert-equal(32768, square(16)) },
    test("returns the number of grains on the square > grains on square 32") { assert-equal(2147483648, square(32)) },
    test("returns the number of grains on the square > grains on square 64") { assert-equal(9223372036854775808, square(64)) },
    test("returns the number of grains on the square > square 0 is invalid") { assert-throws("square must be between 1 and 64") { square(0) } },
    test("returns the number of grains on the square > negative square is invalid") { assert-throws("square must be between 1 and 64") { square(-1) } },
    test("returns the number of grains on the square > square greater than 64 is invalid") { assert-throws("square must be between 1 and 64") { square(65) } },
    test("returns the total number of grains on the board") { assert-equal(18446744073709551615, total()) },
  ])
