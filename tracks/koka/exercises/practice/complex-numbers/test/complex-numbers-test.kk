import std/num/float64
import test
import complex-numbers

// Results of division and of the exponential are compared with a small tolerance.
fun close(x : float64, y : float64) : bool
  abs(x - y) < 1.0e-9

fun assert-close(expected : float64, actual : float64) : exn ()
  if !close(expected, actual) then
    throw("expected " ++ expected.show ++ ", got " ++ actual.show, ExnAssert)

fun assert-complex(expected : complex, actual : complex) : exn ()
  if !(close(expected.re, actual.re) && close(expected.im, actual.im)) then
    throw("expected " ++ expected.show ++ ", got " ++ actual.show, ExnAssert)

// A real number `x` is the complex number `x + 0i`.
fun r(x : float64) : complex
  Complex(x, 0.0)

pub fun main()
  run([
    test("Real part > Real part of a purely real number") { assert-close(1.0, real(Complex(1.0, 0.0))) },
    test("Real part > Real part of a purely imaginary number") { assert-close(0.0, real(Complex(0.0, 1.0))) },
    test("Real part > Real part of a number with real and imaginary part") { assert-close(1.0, real(Complex(1.0, 2.0))) },
    test("Imaginary part > Imaginary part of a purely real number") { assert-close(0.0, imaginary(Complex(1.0, 0.0))) },
    test("Imaginary part > Imaginary part of a purely imaginary number") { assert-close(1.0, imaginary(Complex(0.0, 1.0))) },
    test("Imaginary part > Imaginary part of a number with real and imaginary part") { assert-close(2.0, imaginary(Complex(1.0, 2.0))) },
    test("Imaginary unit") { assert-complex(Complex(-1.0, 0.0), mul(Complex(0.0, 1.0), Complex(0.0, 1.0))) },
    test("Arithmetic > Addition > Add purely real numbers") { assert-complex(Complex(3.0, 0.0), add(Complex(1.0, 0.0), Complex(2.0, 0.0))) },
    test("Arithmetic > Addition > Add purely imaginary numbers") { assert-complex(Complex(0.0, 3.0), add(Complex(0.0, 1.0), Complex(0.0, 2.0))) },
    test("Arithmetic > Addition > Add numbers with real and imaginary part") { assert-complex(Complex(4.0, 6.0), add(Complex(1.0, 2.0), Complex(3.0, 4.0))) },
    test("Arithmetic > Subtraction > Subtract purely real numbers") { assert-complex(Complex(-1.0, 0.0), sub(Complex(1.0, 0.0), Complex(2.0, 0.0))) },
    test("Arithmetic > Subtraction > Subtract purely imaginary numbers") { assert-complex(Complex(0.0, -1.0), sub(Complex(0.0, 1.0), Complex(0.0, 2.0))) },
    test("Arithmetic > Subtraction > Subtract numbers with real and imaginary part") { assert-complex(Complex(-2.0, -2.0), sub(Complex(1.0, 2.0), Complex(3.0, 4.0))) },
    test("Arithmetic > Multiplication > Multiply purely real numbers") { assert-complex(Complex(2.0, 0.0), mul(Complex(1.0, 0.0), Complex(2.0, 0.0))) },
    test("Arithmetic > Multiplication > Multiply purely imaginary numbers") { assert-complex(Complex(-2.0, 0.0), mul(Complex(0.0, 1.0), Complex(0.0, 2.0))) },
    test("Arithmetic > Multiplication > Multiply numbers with real and imaginary part") { assert-complex(Complex(-5.0, 10.0), mul(Complex(1.0, 2.0), Complex(3.0, 4.0))) },
    test("Arithmetic > Division > Divide purely real numbers") { assert-complex(Complex(0.5, 0.0), div(Complex(1.0, 0.0), Complex(2.0, 0.0))) },
    test("Arithmetic > Division > Divide purely imaginary numbers") { assert-complex(Complex(0.5, 0.0), div(Complex(0.0, 1.0), Complex(0.0, 2.0))) },
    test("Arithmetic > Division > Divide numbers with real and imaginary part") { assert-complex(Complex(0.44, 0.08), div(Complex(1.0, 2.0), Complex(3.0, 4.0))) },
    test("Absolute value > Absolute value of a positive purely real number") { assert-close(5.0, abs(Complex(5.0, 0.0))) },
    test("Absolute value > Absolute value of a negative purely real number") { assert-close(5.0, abs(Complex(-5.0, 0.0))) },
    test("Absolute value > Absolute value of a purely imaginary number with positive imaginary part") { assert-close(5.0, abs(Complex(0.0, 5.0))) },
    test("Absolute value > Absolute value of a purely imaginary number with negative imaginary part") { assert-close(5.0, abs(Complex(0.0, -5.0))) },
    test("Absolute value > Absolute value of a number with real and imaginary part") { assert-close(5.0, abs(Complex(3.0, 4.0))) },
    test("Complex conjugate > Conjugate a purely real number") { assert-complex(Complex(5.0, 0.0), conjugate(Complex(5.0, 0.0))) },
    test("Complex conjugate > Conjugate a purely imaginary number") { assert-complex(Complex(0.0, -5.0), conjugate(Complex(0.0, 5.0))) },
    test("Complex conjugate > Conjugate a number with real and imaginary part") { assert-complex(Complex(1.0, -1.0), conjugate(Complex(1.0, 1.0))) },
    test("Complex exponential function > Euler's identity/formula") { assert-complex(Complex(-1.0, 0.0), exp(Complex(0.0, pi))) },
    test("Complex exponential function > Exponential of 0") { assert-complex(Complex(1.0, 0.0), exp(Complex(0.0, 0.0))) },
    test("Complex exponential function > Exponential of a purely real number") { assert-complex(Complex(flt-e, 0.0), exp(Complex(1.0, 0.0))) },
    test("Complex exponential function > Exponential of a number with real and imaginary part") { assert-complex(Complex(-2.0, 0.0), exp(Complex(ln(2.0), pi))) },
    test("Complex exponential function > Exponential resulting in a number with real and imaginary part") { assert-complex(Complex(1.0, 1.0), exp(Complex(ln(2.0) / 2.0, pi / 4.0))) },
    test("Operations between real numbers and complex numbers > Add real number to complex number") { assert-complex(Complex(6.0, 2.0), add(Complex(1.0, 2.0), r(5.0))) },
    test("Operations between real numbers and complex numbers > Add complex number to real number") { assert-complex(Complex(6.0, 2.0), add(r(5.0), Complex(1.0, 2.0))) },
    test("Operations between real numbers and complex numbers > Subtract real number from complex number") { assert-complex(Complex(1.0, 7.0), sub(Complex(5.0, 7.0), r(4.0))) },
    test("Operations between real numbers and complex numbers > Subtract complex number from real number") { assert-complex(Complex(-1.0, -7.0), sub(r(4.0), Complex(5.0, 7.0))) },
    test("Operations between real numbers and complex numbers > Multiply complex number by real number") { assert-complex(Complex(10.0, 25.0), mul(Complex(2.0, 5.0), r(5.0))) },
    test("Operations between real numbers and complex numbers > Multiply real number by complex number") { assert-complex(Complex(10.0, 25.0), mul(r(5.0), Complex(2.0, 5.0))) },
    test("Operations between real numbers and complex numbers > Divide complex number by real number") { assert-complex(Complex(1.0, 10.0), div(Complex(10.0, 100.0), r(10.0))) },
    test("Operations between real numbers and complex numbers > Divide real number by complex number") { assert-complex(Complex(2.5, -2.5), div(r(5.0), Complex(1.0, 1.0))) },
  ])
