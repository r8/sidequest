import test
import typewriter

pub fun main()
  run([
    test("1. a lower-case vowel") { assert-true(is-vowel('a')) },
    test("1. an upper-case vowel") { assert-true(is-vowel('E')) },
    test("1. a consonant") { assert-false(is-vowel('y')) },
    test("1. a punctuation mark") { assert-false(is-vowel('?')) },
    test("2. a lower-case letter") { assert-equal('Q', capital('q')) },
    test("2. the first and last letters") { assert-equal("AZ", [capital('a'), capital('z')].string) },
    test("2. a capital stays a capital") { assert-equal('M', capital('M')) },
    test("2. a digit is unchanged") { assert-equal('7', capital('7')) },
    test("3. digits in an address") { assert-equal(4, count-digits("Flat 3b, 221 Baker Street")) },
    test("3. no digits") { assert-equal(0, count-digits("Dear Sir")) },
    test("3. only digits") { assert-equal(5, count-digits("90210")) },
    test("3. an empty text") { assert-equal(0, count-digits("")) },
    test("4. a lower-case letter") { assert-equal('h', intended('g')) },
    test("4. wrapping round in lower case") { assert-equal('a', intended('z')) },
    test("4. an upper-case letter") { assert-equal('B', intended('A')) },
    test("4. wrapping round in upper case") { assert-equal('A', intended('Z')) },
    test("4. a space is unchanged") { assert-equal(' ', intended(' ')) },
    test("5. a greeting") { assert-equal("Hello, world!", repair("Gdkkn, vnqkc!")) },
    test("5. a date") { assert-equal("May 4", repair("Lzx 4")) },
    test("5. an empty text") { assert-equal("", repair("")) },
  ])
