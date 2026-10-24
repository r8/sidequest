// The row below `row`: each inner number is the sum of the two numbers above it.
fun next-row(row : list<int>) : list<int>
  zipwith(Cons(0, row), row ++ [0], fn(a, b) a + b)

// rows(count) -> the first `count` rows of Pascal's triangle, each a list of numbers
pub fun rows(count : int) : div list<list<int>>
  fun go(k : int, row : list<int>) : div list<list<int>>
    if k <= 0 then Nil else Cons(row, go(k - 1, row.next-row))
  go(count, [1])
