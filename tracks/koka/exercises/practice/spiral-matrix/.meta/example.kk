// A spiral of `rows` x `cols` numbered from `start`: its first row, then the rest of it is the
// remaining (cols x rows - 1) spiral turned clockwise.
fun spiral(rows : int, cols : int, start : int) : div list<list<int>>
  if rows <= 0 || cols <= 0 then Nil
  else
    val inner = spiral(cols, rows - 1, start + cols)
    Cons(list(start, start + cols - 1), rotate-clockwise(inner, rows - 1))

// Rotates a matrix clockwise; `height` is the height of the result (the matrix's width),
// needed when the matrix is empty.
fun rotate-clockwise(m : list<list<int>>, height : int) : list<list<int>>
  transpose(m.reverse, height)

fun transpose(m : list<list<int>>, rows : int) : list<list<int>>
  list(0, rows - 1).map(fn(i) m.flatmap(fn(r) r.drop(i).take(1)))

// spiral-matrix(size) -> the rows of a `size` x `size` matrix filled with 1, 2, 3, ... in a
// clockwise spiral that starts in the top-left corner and goes right first
pub fun spiral-matrix(size : int) : div list<list<int>>
  spiral(size, size, 1)
