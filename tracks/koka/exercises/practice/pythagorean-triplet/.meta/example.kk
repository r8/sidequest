// The triplet with smallest side `a` and perimeter `n`, if any: from a + b + c == n and
// a² + b² == c², b == (n² - 2na) / (2(n - a)).
fun triplet-for(n : int, a : int) : maybe<(int, int, int)>
  val num = n * n - 2 * n * a
  val den = 2 * (n - a)
  val b = num / den
  if num % den == 0 && a < b then Just((a, b, n - a - b)) else Nothing

// triplets-with-sum(n) -> every Pythagorean triplet (a, b, c) with a < b < c and a + b + c == n,
// in increasing order of a
pub fun triplets-with-sum(n : int) : list<(int, int, int)>
  list(1, n / 3).filter-map(fn(a) triplet-for(n, a))
