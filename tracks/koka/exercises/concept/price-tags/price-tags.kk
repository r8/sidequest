// An amount of money, in cents.
pub struct money(cents : int)

// How an item is sold: by the piece or by weight.
pub type measure
  Each
  PerKilo

// money/show(m) -> `m` as "$<dollars>.<two digits of cents>"
pub fun money/show(m : money) : exn string
  throw("implement me", ExnTodo)

// measure/show(m) -> "each" or "per kilo"
pub fun measure/show(m : measure) : exn string
  throw("implement me", ExnTodo)

// money/(==)(a, b) -> whether `a` and `b` are the same amount
pub fun money/(==)(a : money, b : money) : exn bool
  throw("implement me", ExnTodo)

// money/cmp(a, b) -> `Lt`, `Eq` or `Gt` as `a` is less than, equal to or greater than `b`
pub fun money/cmp(a : money, b : money) : exn order
  throw("implement me", ExnTodo)

// label(name, value) -> "<name>: <value shown>"
pub fun label(name : string, value : a, ?show : (a) -> <exn|e> string) : <exn|e> string
  throw("implement me", ExnTodo)

// cheapest(prices) -> the first smallest of `prices`, or `Nothing` if there are none
pub fun cheapest(prices : list<a>, ?cmp : (a, a) -> <exn|e> order) : <exn|e> maybe<a>
  throw("implement me", ExnTodo)
