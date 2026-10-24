// chain(dominoes) -> the dominoes in an order (each possibly flipped) where neighbouring halves match
// and the two free ends match each other; Nothing if there is no such chain
pub fun chain(dominoes : list<(int, int)>) : exn maybe<list<(int, int)>>
  throw("implement me", ExnTodo)
