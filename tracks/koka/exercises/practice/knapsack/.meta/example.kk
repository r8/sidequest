// An item that can go into the knapsack.
pub struct item
  weight : int
  value : int

pub fun show(i : item) : string
  "Item(" ++ i.weight.show ++ ", " ++ i.value.show ++ ")"

pub fun (==)(i : item, j : item) : bool
  i.weight == j.weight && i.value == j.value

// maximum-value(maximum-weight, items) -> the largest total value of items, each taken at most
// once, whose total weight is at most `maximum-weight`
pub fun maximum-value(maximum-weight : int, items : list<item>) : int
  // best[w] is the largest value that fits in weight w using the items seen so far
  val best = items.foldl(replicate(0, maximum-weight + 1)) fn(best, i)
    val taking = replicate(0, i.weight) ++ best.map(fn(v) v + i.value)
    best.zipwith(taking, fn(a, b) max(a, b))
  best.last.default(0)
