import test
import say

pub fun main()
  run([
    test("zero") { assert-equal("zero", say(0)) },
    test("one") { assert-equal("one", say(1)) },
    test("fourteen") { assert-equal("fourteen", say(14)) },
    test("twenty") { assert-equal("twenty", say(20)) },
    test("twenty-two") { assert-equal("twenty-two", say(22)) },
    test("thirty") { assert-equal("thirty", say(30)) },
    test("ninety-nine") { assert-equal("ninety-nine", say(99)) },
    test("one hundred") { assert-equal("one hundred", say(100)) },
    test("one hundred twenty-three") { assert-equal("one hundred twenty-three", say(123)) },
    test("two hundred") { assert-equal("two hundred", say(200)) },
    test("nine hundred ninety-nine") { assert-equal("nine hundred ninety-nine", say(999)) },
    test("one thousand") { assert-equal("one thousand", say(1000)) },
    test("one thousand two hundred thirty-four") { assert-equal("one thousand two hundred thirty-four", say(1234)) },
    test("one million") { assert-equal("one million", say(1000000)) },
    test("one million two thousand three hundred forty-five") { assert-equal("one million two thousand three hundred forty-five", say(1002345)) },
    test("one billion") { assert-equal("one billion", say(1000000000)) },
    test("a big number") { assert-equal("nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three", say(987654321123)) },
    test("numbers below zero are out of range") { assert-throws("input out of range") { say(-1) } },
    test("numbers above 999,999,999,999 are out of range") { assert-throws("input out of range") { say(1000000000000) } },
  ])
