fun parse(matrix : string) : list<list<int>>
  matrix.lines.map(fn(line) line.split(" ").filter(is-notempty).map(fn(n) n.parse-int.default(0)))

fun nth(xs : list<a>, index : int) : exn a
  match xs.drop(index - 1)
    Cons(x, _) -> x
    Nil -> throw("index out of range")

// row(matrix, index) -> the numbers in row `index` (1-based) of `matrix`, a string of
// whitespace-separated numbers with one row per line
pub fun row(matrix : string, index : int) : exn list<int>
  matrix.parse.nth(index)

// column(matrix, index) -> the numbers in column `index` (1-based) of `matrix`, top to bottom
pub fun column(matrix : string, index : int) : exn list<int>
  matrix.parse.map(fn(r) r.nth(index))
