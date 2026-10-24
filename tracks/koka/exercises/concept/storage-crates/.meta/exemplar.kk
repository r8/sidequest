// A storage space in the warehouse: vacant, or holding one item of type `a`.
pub type crate<a>
  Vacant
  Holding(item : a)

// swap(pair) -> `pair` with its two halves exchanged
pub fun swap(pair : (a, b)) : (b, a)
  val (x, y) = pair
  (y, x)

// fill(items) -> one crate holding each of `items`, in order
pub fun fill(items : list<a>) : list<crate<a>>
  items.map(Holding)

// unpack(c, fallback) -> the item in `c`, or `fallback` if `c` is vacant
pub fun unpack(c : crate<a>, fallback : a) : a
  match c
    Holding(item) -> item
    Vacant -> fallback

// repack(c, f) -> a crate holding `f` of the item in `c`; vacant if `c` is
pub fun repack(c : crate<a>, f : (a) -> b) : crate<b>
  match c
    Holding(item) -> Holding(f(item))
    Vacant -> Vacant

// holds(crates, wanted, same) -> whether a crate in `crates` holds an item that is `same` as `wanted`
pub fun holds(crates : list<crate<a>>, wanted : a, same : (a, a) -> bool) : bool
  crates.any fn(c)
    match c
      Holding(item) -> same(item, wanted)
      Vacant -> False
