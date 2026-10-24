// saddle-points(matrix) -> the (row, column) positions, 1-based, of the saddle points of
// `matrix` (a list of rows): values that are the largest in their row and the smallest in
// their column; sorted by row, then by column
pub fun saddle-points(matrix : list<list<int>>) : exn list<(int, int)>
  throw("implement me", ExnTodo)
