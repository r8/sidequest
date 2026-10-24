// A calculation as the calculator keeps it.
pub type expr
  Num(value : int)
  Add(left : expr, right : expr)
  Mul(left : expr, right : expr)
  Neg(inner : expr)

// Shows an expression, as the tests print it.
pub fun show(e : expr) : string
  match e
    Num(n) -> "Num(" ++ n.show ++ ")"
    Add(l, r) -> "Add(" ++ l.show ++ ", " ++ r.show ++ ")"
    Mul(l, r) -> "Mul(" ++ l.show ++ ", " ++ r.show ++ ")"
    Neg(x) -> "Neg(" ++ x.show ++ ")"

// Whether two expressions are the same.
pub fun (==)(a : expr, b : expr) : bool
  a.show == b.show

// evaluate(e) -> the value of `e`
pub fun evaluate(e : expr) : exn int
  throw("implement me", ExnTodo)

// count-numbers(e) -> how many numbers `e` contains
pub fun count-numbers(e : expr) : exn int
  throw("implement me", ExnTodo)

// display(e) -> `e` as text, such as "(1 + (2 * 3))" or "-4"
pub fun display(e : expr) : exn string
  throw("implement me", ExnTodo)

// depth(e) -> how many levels deep `e` is nested, 1 for a number
pub fun depth(e : expr) : exn int
  throw("implement me", ExnTodo)

// drop-zeros(e) -> `e` without any addition of `Num(0)`
pub fun drop-zeros(e : expr) : exn expr
  throw("implement me", ExnTodo)
