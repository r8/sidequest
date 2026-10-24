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

// tree-from-traversals(preorder, inorder) -> the tree with these pre-order and in-order traversals;
// throws "traversals must have the same length", "traversals must have the same elements" or
// "traversals must contain unique items" when there is no such tree
pub fun tree-from-traversals(preorder : list<a>, inorder : list<a>, ?(==) : (a, a) -> bool) : exn tree<a>
  throw("implement me", ExnTodo)
