// The value of character `c` at position `i`, if it may stand there.
fun digit-value(i : int, c : char) : maybe<int>
  if c.is-digit then Just(c.int - '0'.int)
  elif c == 'X' && i == 9 then Just(10)
  else Nothing

// is-valid(isbn) -> whether `isbn` is a valid ISBN-10: ten digits, optionally separated by
// dashes, the last of which may be X for 10
pub fun is-valid(isbn : string) : bool
  val cs = isbn.list.filter(fn(c) c != '-')
  val values = cs.map-indexed(digit-value).concat-maybe
  cs.length == 10 && values.length == 10 &&
    values.map-indexed(fn(i, v) v * (10 - i)).sum % 11 == 0
