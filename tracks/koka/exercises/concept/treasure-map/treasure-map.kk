// move(pos, direction) -> the position one step from `pos` towards `direction`
pub fun move(pos : (int, int), direction : string) : exn (int, int)
  throw("implement me", ExnTodo)

// region(pos) -> the region of the island `pos` is in
pub fun region(pos : (int, int)) : exn string
  throw("implement me", ExnTodo)

// paces(from, to) -> the steps along the grid from `from` to `to`
pub fun paces(from : (int, int), to : (int, int)) : exn int
  throw("implement me", ExnTodo)

// read-clues(clues) -> what the parrot says about `clues`
pub fun read-clues(clues : list<string>) : exn string
  throw("implement me", ExnTodo)
