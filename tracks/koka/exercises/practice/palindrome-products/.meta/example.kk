fun is-palindrome(n : int) : bool
  val s = n.show
  s == s.list.reverse.string

// Whether the product `p` can still improve on `best` (by `better`).
fun improves(best : maybe<int>, p : int, better : (int, int) -> bool) : bool
  match best
    Just(b) -> better(p, b)
    Nothing -> True

// The pairs (a, b), lo <= a <= b <= hi, with a * b == n.
fun factors(n : int, lo : int, hi : int) : list<(int, int)>
  // 0 is a product only when the range starts at 0, and then 0 times every number in the range
  if n == 0 then list(lo, hi).map(fn(b) (0, b))
  else list(lo, hi).filter(fn(a) a * a <= n && n % a == 0 && n / a <= hi).map(fn(a) (a, n / a))

fun with-factors(p : maybe<int>, lo : int, hi : int) : maybe<(int, list<(int, int)>)>
  p.map(fn(n) (n, factors(n, lo, hi)))

// Walks a up from lo and, for each a, b up from a, until the products can't beat the best.
fun smallest-product(lo : int, hi : int) : div maybe<int>
  fun inner(a : int, b : int, best : maybe<int>) : div maybe<int>
    if b > hi || !improves(best, a * b, fn(x, y) x < y) then best
    elif is-palindrome(a * b) then Just(a * b)
    else inner(a, b + 1, best)
  fun outer(a : int, best : maybe<int>) : div maybe<int>
    if a > hi || !improves(best, a * a, fn(x, y) x < y) then best
    else outer(a + 1, inner(a, a, best))
  outer(lo, Nothing)

// Walks a down from hi and, for each a, b down from hi to a, until the products can't beat the best.
fun largest-product(lo : int, hi : int) : div maybe<int>
  fun inner(a : int, b : int, best : maybe<int>) : div maybe<int>
    if b < a || !improves(best, a * b, fn(x, y) x > y) then best
    elif is-palindrome(a * b) then Just(a * b)
    else inner(a, b - 1, best)
  fun outer(a : int, best : maybe<int>) : div maybe<int>
    if a < lo || !improves(best, a * hi, fn(x, y) x > y) then best
    else outer(a - 1, inner(a, hi, best))
  outer(hi, Nothing)

// smallest(min-factor, max-factor) -> the smallest palindromic product of two factors from
// min-factor to max-factor, with all its factor pairs (a, b), a <= b, in ascending order of a;
// Nothing if there is none. Throws "min must be <= max"
pub fun smallest(min-factor : int, max-factor : int) : <div,exn> maybe<(int, list<(int, int)>)>
  if min-factor > max-factor then throw("min must be <= max")
  smallest-product(min-factor, max-factor).with-factors(min-factor, max-factor)

// largest(min-factor, max-factor) -> the largest palindromic product of two factors from
// min-factor to max-factor, with all its factor pairs (a, b), a <= b, in ascending order of a;
// Nothing if there is none. Throws "min must be <= max"
pub fun largest(min-factor : int, max-factor : int) : <div,exn> maybe<(int, list<(int, int)>)>
  if min-factor > max-factor then throw("min must be <= max")
  largest-product(min-factor, max-factor).with-factors(min-factor, max-factor)
