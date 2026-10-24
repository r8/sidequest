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
pub fun evaluate(e : expr) : int
  match e
    Num(n) -> n
    Add(l, r) -> evaluate(l) + evaluate(r)
    Mul(l, r) -> evaluate(l) * evaluate(r)
    Neg(x) -> 0 - evaluate(x)

// count-numbers(e) -> how many numbers `e` contains
pub fun count-numbers(e : expr) : int
  match e
    Num -> 1
    Add(l, r) -> count-numbers(l) + count-numbers(r)
    Mul(l, r) -> count-numbers(l) + count-numbers(r)
    Neg(x) -> count-numbers(x)

// display(e) -> `e` as text, such as "(1 + (2 * 3))" or "-4"
pub fun display(e : expr) : string
  match e
    Num(n) -> n.show
    Add(l, r) -> "(" ++ display(l) ++ " + " ++ display(r) ++ ")"
    Mul(l, r) -> "(" ++ display(l) ++ " * " ++ display(r) ++ ")"
    Neg(x) -> "-" ++ display(x)

// depth(e) -> how many levels deep `e` is nested, 1 for a number
pub fun depth(e : expr) : int
  match e
    Num -> 1
    Add(l, r) -> 1 + max(depth(l), depth(r))
    Mul(l, r) -> 1 + max(depth(l), depth(r))
    Neg(x) -> 1 + depth(x)

// drop-zeros(e) -> `e` without any addition of `Num(0)`
pub fun drop-zeros(e : expr) : expr
  match e
    Num -> e
    Add(l, r) ->
      match (drop-zeros(l), drop-zeros(r))
        (Num(0), r2) -> r2
        (l2, Num(0)) -> l2
        (l2, r2) -> Add(l2, r2)
    Mul(l, r) -> Mul(drop-zeros(l), drop-zeros(r))
    Neg(x) -> Neg(drop-zeros(x))
