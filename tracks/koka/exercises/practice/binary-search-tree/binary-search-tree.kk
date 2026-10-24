// A binary search tree: values less than or equal to a node's value go into its left subtree,
// greater values into its right subtree.
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

// insert(t, x) -> `t` with `x` added in its proper place
pub fun insert(t : tree<a>, x : a, ?cmp : (a, a) -> order) : exn tree<a>
  throw("implement me", ExnTodo)

// from-list(xs) -> the tree made by inserting the elements of `xs`, in order, into an empty tree
pub fun from-list(xs : list<a>, ?cmp : (a, a) -> order) : exn tree<a>
  throw("implement me", ExnTodo)

// sorted-data(t) -> the values in `t`, in ascending order
pub fun sorted-data(t : tree<a>) : exn list<a>
  throw("implement me", ExnTodo)
