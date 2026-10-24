fun digits(n : int) : list<int>
  n.show.list.map(fn(c) c - '0').map(int)

// is-armstrong-number(n) -> whether `n` is the sum of its own digits each raised to the power
// of the number of digits
pub fun is-armstrong-number(n : int) : bool
  val ds = n.digits
  ds.map(fn(d) d.pow(ds.length)).sum == n
