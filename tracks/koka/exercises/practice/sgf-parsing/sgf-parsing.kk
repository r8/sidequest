// A node of an SGF game tree: its properties, as a list of (key, values) sorted by key,
// and its child nodes.
pub struct tree
  properties : list<(string, list<string>)>
  children : list<tree>

fun forest-eq(xs : list<tree>, ys : list<tree>) : bool
  match xs
    Nil -> ys.is-nil
    Cons(Tree(p1, c1), r1) -> match ys
      Cons(Tree(p2, c2), r2) -> p1 == p2 && forest-eq(c1, c2) && forest-eq(r1, r2)
      Nil -> False

pub fun tree/(==)(a : tree, b : tree) : bool
  forest-eq([a], [b])

fun forest-show(ts : list<tree>) : list<string>
  match ts
    Nil -> []
    Cons(Tree(p, c), rest) -> Cons("Tree(" ++ p.show ++ ", [" ++ forest-show(c).join(", ") ++ "])", forest-show(rest))

pub fun tree/show(t : tree) : string
  forest-show([t]).join

// parse(encoded) -> the tree an SGF string like "(;A[B](;B[C])(;C[D]))" encodes; throws "tree missing",
// "tree with no nodes", "properties without delimiter" or "property must be in uppercase" for bad input
pub fun parse(encoded : string) : exn tree
  throw("implement me", ExnTodo)
