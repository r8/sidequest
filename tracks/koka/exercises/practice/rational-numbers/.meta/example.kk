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

// Euclid's algorithm; Koka can't see that it terminates, hence `div`.
fun gcd(a : int, b : int) : div int
  if b == 0 then a.abs else gcd(b, a % b)

// reduce(r) -> `r` in lowest terms, with a positive denominator
pub fun reduce(r : rational) : div rational
  val g = gcd(r.numer, r.denom) * r.denom.sign.int
  if g == 0 then r else Rational(r.numer / g, r.denom / g)

// add(r1, r2) -> the sum `r1 + r2`, in lowest terms
pub fun add(r1 : rational, r2 : rational) : div rational
  reduce(Rational(r1.numer * r2.denom + r2.numer * r1.denom, r1.denom * r2.denom))

// sub(r1, r2) -> the difference `r1 - r2`, in lowest terms
pub fun sub(r1 : rational, r2 : rational) : div rational
  add(r1, r2(numer = ~r2.numer))

// mul(r1, r2) -> the product `r1 * r2`, in lowest terms
pub fun mul(r1 : rational, r2 : rational) : div rational
  reduce(Rational(r1.numer * r2.numer, r1.denom * r2.denom))

// div(r1, r2) -> the quotient `r1 / r2`, in lowest terms
pub fun div(r1 : rational, r2 : rational) : div rational
  mul(r1, Rational(r2.denom, r2.numer))

// abs(r) -> the absolute value of `r`, in lowest terms
pub fun abs(r : rational) : div rational
  reduce(Rational(r.numer.abs, r.denom.abs))

// exp-rational(r, n) -> `r` raised to the (possibly negative) integer power `n`, in lowest terms
pub fun exp-rational(r : rational, n : int) : div rational
  if n >= 0 then reduce(Rational(r.numer ^ n, r.denom ^ n))
  else reduce(Rational(r.denom ^ (~n), r.numer ^ (~n)))

// exp-real(x, r) -> the real number `x` raised to the rational power `r`
pub fun exp-real(x : float64, r : rational) : float64
  pow(x, r.numer.float64 / r.denom.float64)
