// All runs of `n` adjacent elements of `xs`.
fun windows(xs : list<int>, n : int) : list<list<int>>
  match xs
    Nil -> if n == 0 then [[]] else []
    Cons(_, rest) -> if xs.length < n then [] else Cons(xs.take(n), windows(rest, n))

fun digit(c : char) : exn int
  if c.is-digit then c.int - '0'.int else throw("digits input must only contain digits")

// largest-product(digits, span) -> the largest product of `span` adjacent digits in `digits`.
// Throws "span must not be negative", "span must not exceed string length" or
// "digits input must only contain digits"
pub fun largest-product(digits : string, span : int) : exn int
  if span < 0 then throw("span must not be negative")
  if span > digits.count then throw("span must not exceed string length")
  digits.list.map(digit).windows(span).map(fn(w) w.foldl(1, fn(p, d) p * d)).maximum
