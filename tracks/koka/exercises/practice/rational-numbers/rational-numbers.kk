import std/num/float64

// A rational number `numer/denom`. The operations below return it in lowest terms with a
// positive denominator, so equal numbers are `==`.
pub struct rational
  numer : int
  denom : int

pub fun show(r : rational) : string
  r.numer.show ++ "/" ++ r.denom.show

pub fun (==)(r : rational, s : rational) : bool
  r.numer == s.numer && r.denom == s.denom

// add(r1, r2) -> the sum `r1 + r2`, in lowest terms
pub fun add(r1 : rational, r2 : rational) : exn rational
  throw("implement me", ExnTodo)

// sub(r1, r2) -> the difference `r1 - r2`, in lowest terms
pub fun sub(r1 : rational, r2 : rational) : exn rational
  throw("implement me", ExnTodo)

// mul(r1, r2) -> the product `r1 * r2`, in lowest terms
pub fun mul(r1 : rational, r2 : rational) : exn rational
  throw("implement me", ExnTodo)

// div(r1, r2) -> the quotient `r1 / r2`, in lowest terms
pub fun div(r1 : rational, r2 : rational) : exn rational
  throw("implement me", ExnTodo)

// abs(r) -> the absolute value of `r`, in lowest terms
pub fun abs(r : rational) : exn rational
  throw("implement me", ExnTodo)

// exp-rational(r, n) -> `r` raised to the (possibly negative) integer power `n`, in lowest terms
pub fun exp-rational(r : rational, n : int) : exn rational
  throw("implement me", ExnTodo)

// exp-real(x, r) -> the real number `x` raised to the rational power `r`
pub fun exp-real(x : float64, r : rational) : exn float64
  throw("implement me", ExnTodo)

// reduce(r) -> `r` in lowest terms, with a positive denominator
pub fun reduce(r : rational) : exn rational
  throw("implement me", ExnTodo)
