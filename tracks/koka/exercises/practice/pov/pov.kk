// A tree node: a label and the subtrees below it.
pub struct tree(label : string, children : list<tree>)

// Whether the forests `xs` and `ys ++ skipped` hold the same trees, in any order.
fun same-forest(xs : list<tree>, ys : list<tree>, skipped : list<tree>) : bool
  match xs
    Nil -> ys.is-nil && skipped.is-nil
    Cons(Tree(l, cs), rest) -> match ys
      Nil -> False
      Cons(y, ys-rest) -> match y
        Tree(m, ds) ->
          (l == m && same-forest(cs, ds, []) && same-forest(rest, skipped ++ ys-rest, []))
            || same-forest(xs, ys-rest, Cons(y, skipped))

// Two trees are equal when their roots have the same label and the same subtrees, in any order.
pub fun tree/(==)(t1 : tree, t2 : tree) : bool
  same-forest([t1], [t2], [])

fun show-forest(ts : list<tree>) : list<string>
  match ts
    Nil -> Nil
    Cons(Tree(l, cs), rest) -> Cons("Tree(" ++ l.show ++ ", [" ++ show-forest(cs).join(", ") ++ "])", show-forest(rest))

pub fun tree/show(t : tree) : string
  show-forest([t]).join

// from-pov(t, from) -> `t` re-rooted on the node labelled `from`, or Nothing if there is none
pub fun from-pov(t : tree, from : string) : exn maybe<tree>
  throw("implement me", ExnTodo)

// path-to(t, from, to) -> the labels on the path from the node labelled `from` to the one labelled `to`,
// both included, or Nothing if either is missing
pub fun path-to(t : tree, from : string, to : string) : exn maybe<list<string>>
  throw("implement me", ExnTodo)
