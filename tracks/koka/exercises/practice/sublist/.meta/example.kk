// How the first list relates to the second.
pub type relation
  Equal
  Sublist
  Superlist
  Unequal

pub fun relation/(==)(r1 : relation, r2 : relation) : bool
  match (r1, r2)
    (Equal, Equal) -> True
    (Sublist, Sublist) -> True
    (Superlist, Superlist) -> True
    (Unequal, Unequal) -> True
    _ -> False

pub fun relation/show(r : relation) : string
  match r
    Equal -> "Equal"
    Sublist -> "Sublist"
    Superlist -> "Superlist"
    Unequal -> "Unequal"

// Whether `xs` is a prefix of `ys`.
fun is-prefix(xs : list<a>, ys : list<a>, ?(==) : (a, a) -> bool) : bool
  match xs
    Nil -> True
    Cons(x, xr) -> match ys
      Cons(y, yr) -> x == y && is-prefix(xr, yr)
      Nil -> False

// Whether `xs` appears as a contiguous run inside `ys`.
fun is-infix(xs : list<a>, ys : list<a>, ?(==) : (a, a) -> bool) : bool
  match ys
    Nil -> xs.is-nil
    Cons(_, rest) -> is-prefix(xs, ys) || is-infix(xs, rest)

// sublist(xs, ys) -> Equal if the lists are equal, Sublist if `xs` appears as a contiguous run inside `ys`,
// Superlist if `ys` appears inside `xs`, and Unequal otherwise
pub fun sublist(xs : list<a>, ys : list<a>, ?(==) : (a, a) -> bool) : relation
  if xs == ys then Equal
  elif is-infix(xs, ys) then Sublist
  elif is-infix(ys, xs) then Superlist
  else Unequal
