import test
import series

pub fun main()
  run([
    test("slices of one from one") { assert-equal(["1"], slices("1", 1)) },
    test("slices of one from two") { assert-equal(["1", "2"], slices("12", 1)) },
    test("slices of two") { assert-equal(["35"], slices("35", 2)) },
    test("slices of two overlap") { assert-equal(["91", "14", "42"], slices("9142", 2)) },
    test("slices can include duplicates") { assert-equal(["777", "777", "777", "777"], slices("777777", 3)) },
    test("slices of a long series") {
      assert-equal(["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"], slices("918493904243", 5))
    },
    test("slice length is too large") {
      assert-throws("slice length cannot be greater than series length") { slices("12345", 6) }
    },
    test("slice length is way too large") {
      assert-throws("slice length cannot be greater than series length") { slices("12345", 42) }
    },
    test("slice length cannot be zero") { assert-throws("slice length cannot be zero") { slices("12345", 0) } },
    test("slice length cannot be negative") { assert-throws("slice length cannot be negative") { slices("123", -1) } },
    test("empty series is invalid") { assert-throws("series cannot be empty") { slices("", 1) } },
  ])
