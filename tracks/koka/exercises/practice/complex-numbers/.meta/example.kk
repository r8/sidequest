import std/num/float64

// A complex number `re + im·i`.
pub struct complex
  re : float64
  im : float64

pub fun show(z : complex) : string
  "Complex(" ++ z.re.show ++ ", " ++ z.im.show ++ ")"

pub fun (==)(z : complex, w : complex) : bool
  z.re == w.re && z.im == w.im

// real(z) -> the real part of `z`
pub fun real(z : complex) : float64
  z.re

// imaginary(z) -> the imaginary part of `z`
pub fun imaginary(z : complex) : float64
  z.im

// add(z1, z2) -> the sum `z1 + z2`
pub fun add(z1 : complex, z2 : complex) : complex
  Complex(z1.re + z2.re, z1.im + z2.im)

// sub(z1, z2) -> the difference `z1 - z2`
pub fun sub(z1 : complex, z2 : complex) : complex
  Complex(z1.re - z2.re, z1.im - z2.im)

// mul(z1, z2) -> the product `z1 * z2`
pub fun mul(z1 : complex, z2 : complex) : complex
  Complex(z1.re * z2.re - z1.im * z2.im, z1.im * z2.re + z1.re * z2.im)

// div(z1, z2) -> the quotient `z1 / z2`
pub fun div(z1 : complex, z2 : complex) : complex
  val d = z2.re * z2.re + z2.im * z2.im
  val n = mul(z1, conjugate(z2))
  Complex(n.re / d, n.im / d)

// abs(z) -> the absolute value (modulus) of `z`
pub fun abs(z : complex) : float64
  hypot(z.re, z.im)

// conjugate(z) -> the complex conjugate of `z`
pub fun conjugate(z : complex) : complex
  z(im = ~z.im)

// exp(z) -> e raised to the power `z`
pub fun exp(z : complex) : complex
  val r = exp(z.re)
  Complex(r * cos(z.im), r * sin(z.im))
