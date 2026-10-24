fun bottles(n : int) : string
  match n
    0 -> "no more bottles"
    1 -> "1 bottle"
    _ -> n.show ++ " bottles"

fun verse(n : int) : list<string>
  val first = bottles(n).capitalize ++ " of beer on the wall, " ++ bottles(n) ++ " of beer."
  val second = match n
    0 -> "Go to the store and buy some more, " ++ bottles(99) ++ " of beer on the wall."
    1 -> "Take it down and pass it around, " ++ bottles(0) ++ " of beer on the wall."
    _ -> "Take one down and pass it around, " ++ bottles(n - 1) ++ " of beer on the wall."
  [first, second]

// recite(start-bottles, take-down) -> the lines of `take-down` verses counting down from
// `start-bottles`, with an empty line between verses
pub fun recite(start-bottles : int, take-down : int) : list<string>
  list(0, take-down - 1).map(fn(i) verse(start-bottles - i)).intersperse([""]).concat
