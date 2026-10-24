import test
import isbn-verifier

pub fun main()
  run([
    test("valid isbn") { assert-true(is-valid("3-598-21508-8")) },
    test("invalid isbn check digit") { assert-false(is-valid("3-598-21508-9")) },
    test("valid isbn with a check digit of 10") { assert-true(is-valid("3-598-21507-X")) },
    test("check digit is a character other than X") { assert-false(is-valid("3-598-21507-A")) },
    test("invalid check digit in isbn is not treated as zero") { assert-false(is-valid("4-598-21507-B")) },
    test("invalid character in isbn is not treated as zero") { assert-false(is-valid("3-598-P1581-X")) },
    test("X is only valid as a check digit") { assert-false(is-valid("3-598-2X507-9")) },
    test("only one check digit is allowed") { assert-false(is-valid("3-598-21508-96")) },
    test("X is not substituted by the value 10") { assert-false(is-valid("3-598-2X507-5")) },
    test("valid isbn without separating dashes") { assert-true(is-valid("3598215088")) },
    test("isbn without separating dashes and X as check digit") { assert-true(is-valid("359821507X")) },
    test("isbn without check digit and dashes") { assert-false(is-valid("359821507")) },
    test("too long isbn and no dashes") { assert-false(is-valid("3598215078X")) },
    test("too short isbn") { assert-false(is-valid("00")) },
    test("isbn without check digit") { assert-false(is-valid("3-598-21507")) },
    test("check digit of X should not be used for 0") { assert-false(is-valid("3-598-21515-X")) },
    test("empty isbn") { assert-false(is-valid("")) },
    test("input is 9 characters") { assert-false(is-valid("134456729")) },
    test("invalid characters are not ignored after checking length") { assert-false(is-valid("3132P34035")) },
    test("invalid characters are not ignored before checking length") { assert-false(is-valid("3598P215088")) },
    test("input is too long but contains a valid isbn") { assert-false(is-valid("98245726788")) },
  ])
