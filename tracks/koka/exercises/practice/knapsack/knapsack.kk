// An item that can go into the knapsack.
pub struct item
  weight : int
  value : int

pub fun show(i : item) : string
  "Item(" ++ i.weight.show ++ ", " ++ i.value.show ++ ")"

pub fun (==)(i : item, j : item) : bool
  i.weight == j.weight && i.value == j.value

// maximum-value(maximum-weight, items) -> the largest total value of items, each taken at most
// once, whose total weight is at most `maximum-weight`
pub fun maximum-value(maximum-weight : int, items : list<item>) : exn int
  throw("implement me", ExnTodo)
