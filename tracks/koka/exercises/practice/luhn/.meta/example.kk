fun luhn-digit(i : int, d : int) : int
  if i % 2 == 0 then d
  elif d * 2 > 9 then d * 2 - 9
  else d * 2

// valid(value) -> whether `value`, digits and spaces with at least two digits, passes the Luhn check
pub fun valid(value : string) : bool
  val cs = value.list.filter(fn(c) c != ' ')
  cs.length > 1 && cs.all(is-digit) &&
    cs.reverse.map-indexed(fn(i, c) luhn-digit(i, c.int - '0'.int)).sum % 10 == 0
