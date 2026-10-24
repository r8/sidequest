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
pub fun real(z : complex) : exn float64
  throw("implement me", ExnTodo)

// imaginary(z) -> the imaginary part of `z`
pub fun imaginary(z : complex) : exn float64
  throw("implement me", ExnTodo)

// add(z1, z2) -> the sum `z1 + z2`
pub fun add(z1 : complex, z2 : complex) : exn complex
  throw("implement me", ExnTodo)

// sub(z1, z2) -> the difference `z1 - z2`
pub fun sub(z1 : complex, z2 : complex) : exn complex
  throw("implement me", ExnTodo)

// mul(z1, z2) -> the product `z1 * z2`
pub fun mul(z1 : complex, z2 : complex) : exn complex
  throw("implement me", ExnTodo)

// div(z1, z2) -> the quotient `z1 / z2`
pub fun div(z1 : complex, z2 : complex) : exn complex
  throw("implement me", ExnTodo)

// abs(z) -> the absolute value (modulus) of `z`
pub fun abs(z : complex) : exn float64
  throw("implement me", ExnTodo)

// conjugate(z) -> the complex conjugate of `z`
pub fun conjugate(z : complex) : exn complex
  throw("implement me", ExnTodo)

// exp(z) -> e raised to the power `z`
pub fun exp(z : complex) : exn complex
  throw("implement me", ExnTodo)
