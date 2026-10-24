// A queen on a chess board; rows and columns are numbered 0 to 7.
pub struct queen
  row : int
  column : int

pub fun (==)(a : queen, b : queen) : bool
  a.row == b.row && a.column == b.column

pub fun show(q : queen) : string
  "Queen(" ++ q.row.show ++ ", " ++ q.column.show ++ ")"

// create(row, column) -> a queen at (row, column); throws "row not positive",
// "row not on board", "column not positive" or "column not on board" if that is off the board
pub fun create(row : int, column : int) : exn queen
  throw("implement me", ExnTodo)

// can-attack(white, black) -> whether the two queens share a row, a column or a diagonal
pub fun can-attack(white : queen, black : queen) : exn bool
  throw("implement me", ExnTodo)
