// The price in cents of a group of `n` different books.
fun group-price(n : int) : int
  match n
    1 -> 800
    2 -> 1520
    3 -> 2160
    4 -> 2560
    5 -> 3000
    _ -> 0

// total(basket) -> the lowest price in cents of the books in `basket`, each a book number
// from 1 to 5, using the discounts for groups of different books
pub fun total(basket : list<int>) : int
  val copies = list(1, 5).map(fn(b) basket.filter(fn(x) x == b).length)
  // Make groups as large as possible: group k holds every book with at least k copies.
  val groups = list(1, copies.maximum).map(fn(k) copies.filter(fn(c) c >= k).length)
  // Two groups of four are cheaper than a group of five and a group of three.
  val swaps = min(groups.filter(fn(g) g == 5).length, groups.filter(fn(g) g == 3).length)
  groups.map(group-price).sum - swaps * (group-price(5) + group-price(3) - 2 * group-price(4))
