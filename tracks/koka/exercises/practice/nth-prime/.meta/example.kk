// Whether odd `n` > 1 has no odd divisor from 3 up to its square root.
fun odd-prime(n : int) : div bool
  fun go(d : int) : div bool
    if d * d > n then True
    elif n % d == 0 then False
    else go(d + 2)
  go(3)

// The `k`th odd prime at or after the odd number `n`.
fun nth-odd-prime(k : int, n : int) : div int
  if !n.odd-prime then nth-odd-prime(k, n + 2)
  elif k == 1 then n
  else nth-odd-prime(k - 1, n + 2)

// prime(n) -> the `n`th prime number, counting 2 as the first;
// throws "there is no zeroth prime" when `n` is 0
pub fun prime(n : int) : <exn, div> int
  if n < 1 then throw("there is no zeroth prime")
  if n == 1 then 2 else nth-odd-prime(n - 1, 3)
