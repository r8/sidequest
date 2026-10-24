import test
import largest-series-product

pub fun main()
  run([
    test("finds the largest product if span equals length") { assert-equal(18, largest-product("29", 2)) },
    test("can find the largest product of 2 with numbers in order") { assert-equal(72, largest-product("0123456789", 2)) },
    test("can find the largest product of 2") { assert-equal(48, largest-product("576802143", 2)) },
    test("can find the largest product of 3 with numbers in order") { assert-equal(504, largest-product("0123456789", 3)) },
    test("can find the largest product of 3") { assert-equal(270, largest-product("1027839564", 3)) },
    test("can find the largest product of 5 with numbers in order") { assert-equal(15120, largest-product("0123456789", 5)) },
    test("can get the largest product of a big number") { assert-equal(23520, largest-product("73167176531330624919225119674426574742355349194934", 6)) },
    test("reports zero if the only digits are zero") { assert-equal(0, largest-product("0000", 2)) },
    test("reports zero if all spans include zero") { assert-equal(0, largest-product("99099", 3)) },
    test("rejects span longer than string length") { assert-throws("span must not exceed string length") { largest-product("123", 4) } },
    test("reports 1 for empty string and empty product (0 span)") { assert-equal(1, largest-product("", 0)) },
    test("reports 1 for nonempty string and empty product (0 span)") { assert-equal(1, largest-product("123", 0)) },
    test("rejects empty string and nonzero span") { assert-throws("span must not exceed string length") { largest-product("", 1) } },
    test("rejects invalid character in digits") { assert-throws("digits input must only contain digits") { largest-product("1234a5", 2) } },
    test("rejects negative span") { assert-throws("span must not be negative") { largest-product("12345", -1) } },
  ])
