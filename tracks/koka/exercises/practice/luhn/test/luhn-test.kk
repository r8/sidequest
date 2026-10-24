import test
import luhn

pub fun main()
  run([
    test("single digit strings can not be valid") { assert-false(valid("1")) },
    test("a single zero is invalid") { assert-false(valid("0")) },
    test("a simple valid SIN that remains valid if reversed") { assert-true(valid("059")) },
    test("a simple valid SIN that becomes invalid if reversed") { assert-true(valid("59")) },
    test("a valid Canadian SIN") { assert-true(valid("055 444 285")) },
    test("invalid Canadian SIN") { assert-false(valid("055 444 286")) },
    test("invalid credit card") { assert-false(valid("8273 1232 7352 0569")) },
    test("invalid long number with an even remainder") { assert-false(valid("1 2345 6789 1234 5678 9012")) },
    test("invalid long number with a remainder divisible by 5") { assert-false(valid("1 2345 6789 1234 5678 9013")) },
    test("valid number with an even number of digits") { assert-true(valid("095 245 88")) },
    test("valid number with an odd number of spaces") { assert-true(valid("234 567 891 234")) },
    test("valid strings with a non-digit added at the end become invalid") { assert-false(valid("059a")) },
    test("valid strings with punctuation included become invalid") { assert-false(valid("055-444-285")) },
    test("valid strings with symbols included become invalid") { assert-false(valid("055# 444$ 285")) },
    test("single zero with space is invalid") { assert-false(valid(" 0")) },
    test("more than a single zero is valid") { assert-true(valid("0000 0")) },
    test("input digit 9 is correctly converted to output digit 9") { assert-true(valid("091")) },
    test("very long input is valid") { assert-true(valid("9999999999 9999999999 9999999999 9999999999")) },
    test("valid luhn with an odd number of digits and non zero first digit") { assert-true(valid("109")) },
    test("using ascii value for non-doubled non-digit isn't allowed") { assert-false(valid("055b 444 285")) },
    test("using ascii value for doubled non-digit isn't allowed") { assert-false(valid(":9")) },
    test("non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed") { assert-false(valid("59%59")) },
  ])
