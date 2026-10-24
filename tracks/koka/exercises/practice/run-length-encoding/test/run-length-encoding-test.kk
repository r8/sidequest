import test
import run-length-encoding

pub fun main()
  run([
    test("run-length encode a string > empty string") { assert-equal("", encode("")) },
    test("run-length encode a string > single characters only are encoded without count") { assert-equal("XYZ", encode("XYZ")) },
    test("run-length encode a string > string with no single characters") { assert-equal("2A3B4C", encode("AABBBCCCC")) },
    test("run-length encode a string > single characters mixed with repeated characters") {
      assert-equal("12WB12W3B24WB", encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
    },
    test("run-length encode a string > multiple whitespace mixed in string") { assert-equal("2 hs2q q2w2 ", encode("  hsqq qww  ")) },
    test("run-length encode a string > lowercase characters") { assert-equal("2a3b4c", encode("aabbbcccc")) },
    test("run-length decode a string > empty string") { assert-equal("", decode("")) },
    test("run-length decode a string > single characters only") { assert-equal("XYZ", decode("XYZ")) },
    test("run-length decode a string > string with no single characters") { assert-equal("AABBBCCCC", decode("2A3B4C")) },
    test("run-length decode a string > single characters with repeated characters") {
      assert-equal("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB", decode("12WB12W3B24WB"))
    },
    test("run-length decode a string > multiple whitespace mixed in string") { assert-equal("  hsqq qww  ", decode("2 hs2q q2w2 ")) },
    test("run-length decode a string > lowercase string") { assert-equal("aabbbcccc", decode("2a3b4c")) },
    test("encode and then decode > encode followed by decode gives original string") {
      assert-equal("zzz ZZ  zZ", decode(encode("zzz ZZ  zZ")))
    },
  ])
