// An amount of money, in cents.
pub struct money(cents : int)

// How an item is sold: by the piece or by weight.
pub type measure
  Each
  PerKilo

// money/show(m) -> `m` as "$<dollars>.<two digits of cents>"
pub fun money/show(m : money) : string
  "$" ++ (m.cents / 100).show ++ "." ++ (m.cents % 100).show.pad-left(2, '0')

// measure/show(m) -> "each" or "per kilo"
pub fun measure/show(m : measure) : string
  match m
    Each -> "each"
    PerKilo -> "per kilo"

// money/(==)(a, b) -> whether `a` and `b` are the same amount
pub fun money/(==)(a : money, b : money) : bool
  a.cents == b.cents

// money/cmp(a, b) -> `Lt`, `Eq` or `Gt` as `a` is less than, equal to or greater than `b`
pub fun money/cmp(a : money, b : money) : order
  cmp(a.cents, b.cents)

// label(name, value) -> "<name>: <value shown>"
pub fun label(name : string, value : a, ?show : (a) -> e string) : e string
  name ++ ": " ++ value.show

// cheapest(prices) -> the first smallest of `prices`, or `Nothing` if there are none
pub fun cheapest(prices : list<a>, ?cmp : (a, a) -> e order) : e maybe<a>
  match prices
    Nil -> Nothing
    Cons(first, rest) ->
      val best = rest.foldl(first) fn(best, p)
        if cmp(p, best) == Lt then p else best
      Just(best)
