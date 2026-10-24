import test
import wordy

pub fun main()
  run([
    test("just a number") { assert-equal(5, answer("What is 5?")) },
    test("just a zero") { assert-equal(0, answer("What is 0?")) },
    test("just a negative number") { assert-equal(-123, answer("What is -123?")) },
    test("addition") { assert-equal(2, answer("What is 1 plus 1?")) },
    test("addition with a left hand zero") { assert-equal(2, answer("What is 0 plus 2?")) },
    test("addition with a right hand zero") { assert-equal(3, answer("What is 3 plus 0?")) },
    test("more addition") { assert-equal(55, answer("What is 53 plus 2?")) },
    test("addition with negative numbers") { assert-equal(-11, answer("What is -1 plus -10?")) },
    test("large addition") { assert-equal(45801, answer("What is 123 plus 45678?")) },
    test("subtraction") { assert-equal(16, answer("What is 4 minus -12?")) },
    test("multiplication") { assert-equal(-75, answer("What is -3 multiplied by 25?")) },
    test("division") { assert-equal(-11, answer("What is 33 divided by -3?")) },
    test("multiple additions") { assert-equal(3, answer("What is 1 plus 1 plus 1?")) },
    test("addition and subtraction") { assert-equal(8, answer("What is 1 plus 5 minus -2?")) },
    test("multiple subtraction") { assert-equal(3, answer("What is 20 minus 4 minus 13?")) },
    test("subtraction then addition") { assert-equal(14, answer("What is 17 minus 6 plus 3?")) },
    test("multiple multiplication") { assert-equal(-12, answer("What is 2 multiplied by -2 multiplied by 3?")) },
    test("addition and multiplication") { assert-equal(-8, answer("What is -3 plus 7 multiplied by -2?")) },
    test("multiple division") { assert-equal(2, answer("What is -12 divided by 2 divided by -3?")) },
    // Not in the canonical data: integer division rounds toward zero, as in most languages' integer division.
    test("division rounds toward zero") { assert-equal(-3, answer("What is -7 divided by 2?")) },
    // Not in the canonical data: dividing by zero is an error, not a number.
    test("division by zero") { assert-throws("division by zero") { answer("What is 1 divided by 0?") } },
    test("unknown operation") { assert-throws("unknown operation") { answer("What is 52 cubed?") } },
    test("Non math question") { assert-throws("unknown operation") { answer("Who is the President of the United States?") } },
    test("reject problem missing an operand") { assert-throws("syntax error") { answer("What is 1 plus?") } },
    test("reject problem with no operands or operators") { assert-throws("syntax error") { answer("What is?") } },
    test("reject two operations in a row") { assert-throws("syntax error") { answer("What is 1 plus plus 2?") } },
    test("reject two numbers in a row") { assert-throws("syntax error") { answer("What is 1 plus 2 1?") } },
    test("reject postfix notation") { assert-throws("syntax error") { answer("What is 1 2 plus?") } },
    test("reject prefix notation") { assert-throws("syntax error") { answer("What is plus 1 2?") } },
  ])
