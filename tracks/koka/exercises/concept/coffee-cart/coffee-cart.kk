// The size of a cup.
pub type size
  Small
  Medium
  Large

// A drink on Femi's menu.
pub type drink
  Espresso
  Latte(cup : size, oat-milk : bool)
  Tea(kind : string, cup : size)

// Shows a size, as the tests print it.
pub fun size/show(s : size) : string
  match s
    Small -> "Small"
    Medium -> "Medium"
    Large -> "Large"

// Shows a drink, as the tests print it.
pub fun drink/show(d : drink) : string
  match d
    Espresso -> "Espresso"
    Latte(cup, oat-milk) -> "Latte(" ++ cup.show ++ ", " ++ oat-milk.show ++ ")"
    Tea(kind, cup) -> "Tea(" ++ kind.show ++ ", " ++ cup.show ++ ")"

// Whether two drinks are the same order.
pub fun drink/(==)(a : drink, b : drink) : bool
  a.show == b.show

// cup-price(s) -> the price in cents of a cup of size `s`
pub fun cup-price(s : size) : exn int
  throw("implement me", ExnTodo)

// price(d) -> the price in cents of the drink `d`
pub fun price(d : drink) : exn int
  throw("implement me", ExnTodo)

// label(d) -> what is written on the cup of `d`, such as "large mint tea"
pub fun label(d : drink) : exn string
  throw("implement me", ExnTodo)

// upsize(d) -> `d` one size larger, if there is a larger size
pub fun upsize(d : drink) : exn drink
  throw("implement me", ExnTodo)

// needs-milk(d) -> whether `d` needs warm cow's milk
pub fun needs-milk(d : drink) : exn bool
  throw("implement me", ExnTodo)
