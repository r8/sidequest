import test
import armstrong-numbers

pub fun main()
  run([
    test("Zero is an Armstrong number") { assert-true(is-armstrong-number(0)) },
    test("Single-digit numbers are Armstrong numbers") { assert-true(is-armstrong-number(5)) },
    test("There are no two-digit Armstrong numbers") { assert-false(is-armstrong-number(10)) },
    test("Three-digit number that is an Armstrong number") { assert-true(is-armstrong-number(153)) },
    test("Three-digit number that is not an Armstrong number") { assert-false(is-armstrong-number(100)) },
    test("Four-digit number that is an Armstrong number") { assert-true(is-armstrong-number(9474)) },
    test("Four-digit number that is not an Armstrong number") { assert-false(is-armstrong-number(9475)) },
    test("Seven-digit number that is an Armstrong number") { assert-true(is-armstrong-number(9926315)) },
    test("Seven-digit number that is not an Armstrong number") { assert-false(is-armstrong-number(9926314)) },
    test("Armstrong number containing seven zeroes") { assert-true(is-armstrong-number(186709961001538790100634132976990)) },
    test("The largest and last Armstrong number") { assert-true(is-armstrong-number(115132219018763992565095597973971522401)) },
  ])
