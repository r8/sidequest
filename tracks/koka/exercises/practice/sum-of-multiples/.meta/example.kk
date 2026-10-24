// sum-of-multiples(factors, limit) -> the sum of the distinct numbers below `limit`
// that are multiples of at least one of `factors`
pub fun sum-of-multiples(factors : list<int>, limit : int) : int
  val positive = factors.filter(fn(f) f > 0)
  list(1, limit - 1).filter(fn(n) positive.any(fn(f) n % f == 0)).sum
