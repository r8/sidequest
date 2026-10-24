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

// sublist(xs, ys) -> Equal if the lists are equal, Sublist if `xs` appears as a contiguous run inside `ys`,
// Superlist if `ys` appears inside `xs`, and Unequal otherwise
pub fun sublist(xs : list<a>, ys : list<a>, ?(==) : (a, a) -> bool) : exn relation
  throw("implement me", ExnTodo)
