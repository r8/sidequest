import std/num/float64
import test
import rational-numbers

// Powers of real numbers are compared with a small relative tolerance.
fun assert-close(expected : float64, actual : float64) : exn ()
  if abs(expected - actual) > 1.0e-9 * max(1.0, abs(expected)) then
    throw("expected " ++ expected.show ++ ", got " ++ actual.show, ExnAssert)

pub fun main()
  run([
    test("Arithmetic > Addition > Add two positive rational numbers") { assert-equal(Rational(7, 6), add(Rational(1, 2), Rational(2, 3))) },
    test("Arithmetic > Addition > Add a positive rational number and a negative rational number") { assert-equal(Rational(-1, 6), add(Rational(1, 2), Rational(-2, 3))) },
    test("Arithmetic > Addition > Add two negative rational numbers") { assert-equal(Rational(-7, 6), add(Rational(-1, 2), Rational(-2, 3))) },
    test("Arithmetic > Addition > Add a rational number to its additive inverse") { assert-equal(Rational(0, 1), add(Rational(1, 2), Rational(-1, 2))) },
    test("Arithmetic > Subtraction > Subtract two positive rational numbers") { assert-equal(Rational(-1, 6), sub(Rational(1, 2), Rational(2, 3))) },
    test("Arithmetic > Subtraction > Subtract a positive rational number and a negative rational number") { assert-equal(Rational(7, 6), sub(Rational(1, 2), Rational(-2, 3))) },
    test("Arithmetic > Subtraction > Subtract two negative rational numbers") { assert-equal(Rational(1, 6), sub(Rational(-1, 2), Rational(-2, 3))) },
    test("Arithmetic > Subtraction > Subtract a rational number from itself") { assert-equal(Rational(0, 1), sub(Rational(1, 2), Rational(1, 2))) },
    test("Arithmetic > Multiplication > Multiply two positive rational numbers") { assert-equal(Rational(1, 3), mul(Rational(1, 2), Rational(2, 3))) },
    test("Arithmetic > Multiplication > Multiply a negative rational number by a positive rational number") { assert-equal(Rational(-1, 3), mul(Rational(-1, 2), Rational(2, 3))) },
    test("Arithmetic > Multiplication > Multiply two negative rational numbers") { assert-equal(Rational(1, 3), mul(Rational(-1, 2), Rational(-2, 3))) },
    test("Arithmetic > Multiplication > Multiply a rational number by its reciprocal") { assert-equal(Rational(1, 1), mul(Rational(1, 2), Rational(2, 1))) },
    test("Arithmetic > Multiplication > Multiply a rational number by 1") { assert-equal(Rational(1, 2), mul(Rational(1, 2), Rational(1, 1))) },
    test("Arithmetic > Multiplication > Multiply a rational number by 0") { assert-equal(Rational(0, 1), mul(Rational(1, 2), Rational(0, 1))) },
    test("Arithmetic > Division > Divide two positive rational numbers") { assert-equal(Rational(3, 4), div(Rational(1, 2), Rational(2, 3))) },
    test("Arithmetic > Division > Divide a positive rational number by a negative rational number") { assert-equal(Rational(-3, 4), div(Rational(1, 2), Rational(-2, 3))) },
    test("Arithmetic > Division > Divide two negative rational numbers") { assert-equal(Rational(3, 4), div(Rational(-1, 2), Rational(-2, 3))) },
    test("Arithmetic > Division > Divide a rational number by 1") { assert-equal(Rational(1, 2), div(Rational(1, 2), Rational(1, 1))) },
    test("Absolute value > Absolute value of a positive rational number") { assert-equal(Rational(1, 2), abs(Rational(1, 2))) },
    test("Absolute value > Absolute value of a positive rational number with negative numerator and denominator") { assert-equal(Rational(1, 2), abs(Rational(-1, -2))) },
    test("Absolute value > Absolute value of a negative rational number") { assert-equal(Rational(1, 2), abs(Rational(-1, 2))) },
    test("Absolute value > Absolute value of a negative rational number with negative denominator") { assert-equal(Rational(1, 2), abs(Rational(1, -2))) },
    test("Absolute value > Absolute value of zero") { assert-equal(Rational(0, 1), abs(Rational(0, 1))) },
    test("Absolute value > Absolute value of a rational number is reduced to lowest terms") { assert-equal(Rational(1, 2), abs(Rational(2, 4))) },
    test("Exponentiation of a rational number > Raise a positive rational number to a positive integer power") { assert-equal(Rational(1, 8), exp-rational(Rational(1, 2), 3)) },
    test("Exponentiation of a rational number > Raise a negative rational number to a positive integer power") { assert-equal(Rational(-1, 8), exp-rational(Rational(-1, 2), 3)) },
    test("Exponentiation of a rational number > Raise a positive rational number to a negative integer power") { assert-equal(Rational(25, 9), exp-rational(Rational(3, 5), -2)) },
    test("Exponentiation of a rational number > Raise a negative rational number to an even negative integer power") { assert-equal(Rational(25, 9), exp-rational(Rational(-3, 5), -2)) },
    test("Exponentiation of a rational number > Raise a negative rational number to an odd negative integer power") { assert-equal(Rational(-125, 27), exp-rational(Rational(-3, 5), -3)) },
    test("Exponentiation of a rational number > Raise zero to an integer power") { assert-equal(Rational(0, 1), exp-rational(Rational(0, 1), 5)) },
    test("Exponentiation of a rational number > Raise one to an integer power") { assert-equal(Rational(1, 1), exp-rational(Rational(1, 1), 4)) },
    test("Exponentiation of a rational number > Raise a positive rational number to the power of zero") { assert-equal(Rational(1, 1), exp-rational(Rational(1, 2), 0)) },
    test("Exponentiation of a rational number > Raise a negative rational number to the power of zero") { assert-equal(Rational(1, 1), exp-rational(Rational(-1, 2), 0)) },
    test("Exponentiation of a real number to a rational number > Raise a real number to a positive rational number") { assert-close(16.0, exp-real(8.0, Rational(4, 3))) },
    test("Exponentiation of a real number to a rational number > Raise a real number to a negative rational number") { assert-close(0.3333333333333333, exp-real(9.0, Rational(-1, 2))) },
    test("Exponentiation of a real number to a rational number > Raise a real number to a zero rational number") { assert-close(1.0, exp-real(2.0, Rational(0, 1))) },
    test("Reduction to lowest terms > Reduce a positive rational number to lowest terms") { assert-equal(Rational(1, 2), reduce(Rational(2, 4))) },
    test("Reduction to lowest terms > Reduce places the minus sign on the numerator") { assert-equal(Rational(-3, 4), reduce(Rational(3, -4))) },
    test("Reduction to lowest terms > Reduce a negative rational number to lowest terms") { assert-equal(Rational(-2, 3), reduce(Rational(-4, 6))) },
    test("Reduction to lowest terms > Reduce a rational number with a negative denominator to lowest terms") { assert-equal(Rational(-1, 3), reduce(Rational(3, -9))) },
    test("Reduction to lowest terms > Reduce zero to lowest terms") { assert-equal(Rational(0, 1), reduce(Rational(0, 6))) },
    test("Reduction to lowest terms > Reduce an integer to lowest terms") { assert-equal(Rational(-2, 1), reduce(Rational(-14, 7))) },
    test("Reduction to lowest terms > Reduce one to lowest terms") { assert-equal(Rational(1, 1), reduce(Rational(13, 13))) },
  ])
