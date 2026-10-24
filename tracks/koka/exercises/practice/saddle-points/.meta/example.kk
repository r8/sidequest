fun columns(matrix : list<list<int>>) : div list<list<int>>
  if matrix.any(is-nil) then Nil
  else Cons(matrix.flatmap(fn(row) row.take(1)), columns(matrix.map(fn(row) row.drop(1))))

// saddle-points(matrix) -> the (row, column) positions, 1-based, of the saddle points of
// `matrix` (a list of rows): values that are the largest in their row and the smallest in
// their column; sorted by row, then by column
pub fun saddle-points(matrix : list<list<int>>) : div list<(int, int)>
  val column-minimums = matrix.columns.map(minimum)
  matrix.map-indexed(fn(r, row)
    val row-maximum = row.maximum
    zip(row, column-minimums).map-indexed(fn(c, (value, column-minimum))
      if value == row-maximum && value == column-minimum then [(r + 1, c + 1)] else []
    ).concat
  ).concat
