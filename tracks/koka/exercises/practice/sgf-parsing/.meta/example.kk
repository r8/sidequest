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

// The text of a property value up to its closing ']', and the input after it.
fun value(cs : list<char>, acc : list<char>) : <div,exn> (string, list<char>)
  match cs
    Cons(']', rest) -> (acc.reverse.string, rest)
    Cons('\\', Cons('\n', rest)) -> value(rest, acc)
    Cons('\\', Cons(c, rest)) -> value(rest, Cons(if c != '\n' && c.is-white then ' ' else c, acc))
    Cons(c, rest) -> value(rest, Cons(if c != '\n' && c.is-white then ' ' else c, acc))
    Nil -> throw("properties without delimiter")

// One or more "[value]"s, and the input after them.
fun values(cs : list<char>) : <div,exn> (list<string>, list<char>)
  match cs
    Cons('[', rest) ->
      val (v, after) = value(rest, [])
      match after
        Cons('[', _) ->
          val (vs, after2) = values(after)
          (Cons(v, vs), after2)
        _ -> ([v], after)
    _ -> throw("properties without delimiter")

fun insert-property(p : (string, list<string>), ps : list<(string, list<string>)>) : list<(string, list<string>)>
  match ps
    Cons(q, rest) | q.fst < p.fst -> Cons(q, insert-property(p, rest))
    _ -> Cons(p, ps)

// The properties of a node, and the input after them.
fun properties(cs : list<char>) : <div,exn> (list<(string, list<string>)>, list<char>)
  match cs
    Cons(c, _) | c.is-alpha ->
      val (key, rest) = cs.span(is-alpha)
      if !key.all(is-upper) then throw("property must be in uppercase")
      val (vs, after) = values(rest)
      val (ps, after2) = properties(after)
      (insert-property((key.string, vs), ps), after2)
    _ -> ([], cs)

// A sequence of nodes, each the only child of the one before, with the last one's children being
// the subtrees that follow; and the input after the closing ')'.
fun nodes(cs : list<char>) : <div,exn> (tree, list<char>)
  match cs
    Cons(';', rest) ->
      val (ps, after) = properties(rest)
      match after
        Cons(';', _) ->
          val (child, after2) = nodes(after)
          (Tree(ps, [child]), after2)
        _ ->
          val (children, after2) = subtrees(after)
          (Tree(ps, children), after2)
    _ -> throw("tree with no nodes")

// The subtrees "(...)" at this point, and the input after the parent's closing ')'.
fun subtrees(cs : list<char>) : <div,exn> (list<tree>, list<char>)
  match cs
    Cons(')', rest) -> ([], rest)
    Cons('(', rest) ->
      val (t, after) = nodes(rest)
      val (ts, after2) = subtrees(after)
      (Cons(t, ts), after2)
    _ -> throw("tree missing")

// parse(encoded) -> the tree an SGF string like "(;A[B](;B[C])(;C[D]))" encodes; throws "tree missing",
// "tree with no nodes", "properties without delimiter" or "property must be in uppercase" for bad input
pub fun parse(encoded : string) : <div,exn> tree
  match encoded.list
    Cons('(', rest) ->
      match nodes(rest)
        (t, Nil) -> t
        _ -> throw("tree missing")
    _ -> throw("tree missing")
