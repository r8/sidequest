import test
import isogram

pub fun main()
  run([
    test("empty string") { assert-true(is-isogram("")) },
    test("isogram with only lower case characters") { assert-true(is-isogram("isogram")) },
    test("word with one duplicated character") { assert-false(is-isogram("eleven")) },
    test("word with one duplicated character from the end of the alphabet") { assert-false(is-isogram("zzyzx")) },
    test("longest reported english isogram") { assert-true(is-isogram("subdermatoglyphic")) },
    test("word with duplicated character in mixed case") { assert-false(is-isogram("Alphabet")) },
    test("word with duplicated character in mixed case, lowercase first") { assert-false(is-isogram("alphAbet")) },
    test("hypothetical isogrammic word with hyphen") { assert-true(is-isogram("thumbscrew-japingly")) },
    test("hypothetical word with duplicated character following hyphen") { assert-false(is-isogram("thumbscrew-jappingly")) },
    test("isogram with duplicated hyphen") { assert-true(is-isogram("six-year-old")) },
    test("made-up name that is an isogram") { assert-true(is-isogram("Emily Jung Schwartzkopf")) },
    test("duplicated character in the middle") { assert-false(is-isogram("accentor")) },
    test("same first and last characters") { assert-false(is-isogram("angola")) },
    test("word with duplicated character and with two hyphens") { assert-false(is-isogram("up-to-date")) },
    // Not in the canonical data: letters outside ASCII repeat too, also in different cases.
    test("duplicated non-ASCII letter in mixed case") { assert-false(is-isogram("Éléphant")) },
    test("duplicated Cyrillic letter in mixed case") { assert-false(is-isogram("Ёж и ёлка")) },
  ])
