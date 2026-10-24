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
pub fun cup-price(s : size) : int
  match s
    Small -> 250
    Medium -> 300
    Large -> 350

// price(d) -> the price in cents of the drink `d`
pub fun price(d : drink) : int
  match d
    Espresso -> 200
    Latte(cup, True) -> cup-price(cup) + 50
    Latte(cup, False) -> cup-price(cup)
    Tea(_, cup) -> cup-price(cup) - 50

fun word(s : size) : string
  match s
    Small -> "small"
    Medium -> "medium"
    Large -> "large"

// label(d) -> what is written on the cup of `d`, such as "large mint tea"
pub fun label(d : drink) : string
  match d
    Espresso -> "espresso"
    Latte(cup, True) -> cup.word ++ " latte with oat milk"
    Latte(cup, False) -> cup.word ++ " latte"
    Tea(kind, cup) -> cup.word ++ " " ++ kind ++ " tea"

fun bigger(s : size) : size
  match s
    Small -> Medium
    _ -> Large

// upsize(d) -> `d` one size larger, if there is a larger size
pub fun upsize(d : drink) : drink
  match d
    Espresso -> Espresso
    Latte(cup, oat-milk) -> Latte(cup.bigger, oat-milk)
    Tea(kind, cup) -> Tea(kind, cup.bigger)

// needs-milk(d) -> whether `d` needs warm cow's milk
pub fun needs-milk(d : drink) : bool
  match d
    Latte(_, False) -> True
    _ -> False
