val m = 26

// The modular multiplicative inverse of `a` mod m; throws when there is none.
fun inverse(a : int) : exn int
  match list(1, m - 1).find(fn(x) (a * x) % m == 1)
    Just(x) -> x
    Nothing -> throw("a and m must be coprime.")

// The letters and digits of `phrase`, lowercased, with each letter's index x replaced by f(x) mod m.
fun transcode(phrase : string, f : int -> int) : list<char>
  phrase.to-lower.list.filter(is-alpha-num).map(fn(c)
    if c.is-lower then ('a'.int + f(c.int - 'a'.int) % m).char else c
  )

// encode(phrase, a, b) -> the affine cipher E(x) = (a * x + b) mod 26 of the letters and digits of `phrase`,
// lowercase, in groups of 5 separated by spaces; throws "a and m must be coprime." unless `a` is coprime to 26
pub fun encode(phrase : string, a : int, b : int) : exn string
  inverse(a)
  phrase.transcode(fn(x) a * x + b)
    .map-indexed(fn(i, c) if i > 0 && i % 5 == 0 then [' ', c] else [c]).concat.string

// decode(phrase, a, b) -> the plain text of the affine cipher `phrase` with key (a, b), lowercase, without spaces;
// throws "a and m must be coprime." unless `a` is coprime to 26
pub fun decode(phrase : string, a : int, b : int) : exn string
  val a-inv = inverse(a)
  phrase.transcode(fn(y) a-inv * (y - b)).string
