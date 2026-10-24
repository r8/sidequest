// The runs of equal characters in `cs`, as (count, character) pairs.
fun runs(cs : list<char>) : list<(int, char)>
  cs.foldr(Nil) fn(c, acc)
    match acc
      Cons((n, d), rest) | d == c -> Cons((n + 1, d), rest)
      _ -> Cons((1, c), acc)

// encode(text) -> `text` with each run of a repeated character replaced by its length and the character
// ("AABCCC" -> "2AB3C"); single characters keep no count
pub fun encode(text : string) : exn string
  text.list.runs.map(fn((n, c)) (if n == 1 then "" else n.show) ++ c.string).join

fun expand(cs : list<char>, count : int) : list<char>
  match cs
    Nil -> Nil
    Cons(c, rest) ->
      if c.is-digit then expand(rest, count * 10 + (c - '0').int)
      else replicate(c, max(count, 1)) ++ expand(rest, 0)

// decode(text) -> the original string of the run-length encoded `text` ("2AB3C" -> "AABCCC")
pub fun decode(text : string) : exn string
  text.list.expand(0).string
