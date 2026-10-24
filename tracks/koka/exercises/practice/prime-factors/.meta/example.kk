// The prime factors of `n` that are at least `d`, given that `n` has none below `d`.
fun factors-from(n : int, d : int) : div list<int>
  if n == 1 then Nil
  elif d * d > n then [n]
  elif n % d == 0 then Cons(d, factors-from(n / d, d))
  else factors-from(n, d + 1)

// factors(n) -> the prime factors of `n` in increasing order, each repeated as often as it divides `n`
pub fun factors(n : int) : div list<int>
  factors-from(n, 2)
