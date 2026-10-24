// A binary tree; Leaf is the empty tree.
pub type tree<a>
  Leaf
  Node(left : tree<a>, value : a, right : tree<a>)

pub fun tree/(==)(t1 : tree<a>, t2 : tree<a>, ?(==) : (a, a) -> bool) : bool
  match t1
    Leaf -> t2.is-leaf
    Node(l1, v1, r1) -> match t2
      Node(l2, v2, r2) -> v1 == v2 && l1 == l2 && r1 == r2
      Leaf -> False

pub fun tree/show(t : tree<a>, ?show : (a) -> string) : string
  match t
    Leaf -> "Leaf"
    Node(l, v, r) -> "Node(" ++ l.show ++ ", " ++ v.show ++ ", " ++ r.show ++ ")"

fun has-duplicates(xs : list<a>, ?(==) : (a, a) -> bool) : bool
  match xs
    Nil -> False
    Cons(x, rest) -> rest.contains(x) || rest.has-duplicates

// Inserts `x` like into a search tree, ordered by `position`.
fun insert(t : tree<a>, x : a, position : (a) -> int) : tree<a>
  match t
    Leaf -> Node(Leaf, x, Leaf)
    Node(l, v, r) ->
      if position(x) < position(v) then Node(l.insert(x, position), v, r)
      else Node(l, v, r.insert(x, position))

// tree-from-traversals(preorder, inorder) -> the tree with these pre-order and in-order traversals;
// throws "traversals must have the same length", "traversals must have the same elements" or
// "traversals must contain unique items" when there is no such tree
pub fun tree-from-traversals(preorder : list<a>, inorder : list<a>, ?(==) : (a, a) -> bool) : exn tree<a>
  if preorder.length != inorder.length then throw("traversals must have the same length")
  if !preorder.all(fn(x) inorder.contains(x)) || !inorder.all(fn(x) preorder.contains(x)) then
    throw("traversals must have the same elements")
  if preorder.has-duplicates then throw("traversals must contain unique items")
  // The tree is a search tree keyed by in-order position, and pre-order puts every parent before
  // its children, so inserting in pre-order rebuilds it.
  preorder.foldl(Leaf, fn(t, x) t.insert(x, fn(y) inorder.index-of(fn(z) z == y)))
