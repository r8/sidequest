// The sorting sidings of the yard: a siding holds one wagon, with the sidings for smaller wagon numbers on its
// left and those for larger ones on its right; a buffer stop ends the line.
pub type yard
  Siding(left : yard, wagon : int, right : yard)
  Buffer

// tracks(y) -> the wagons in the yard `y`, smallest number first
pub fun tracks(y : yard) : list<int>
  match y
    Siding(l, w, r) -> l.tracks ++ Cons(w, r.tracks)
    Buffer -> Nil

// reverse-train(wagons) -> the train `wagons` with its wagons in the opposite order (fip)
pub fun reverse-train(wagons : list<a>) : exn list<a>
  throw("implement me", ExnTodo)

// renumber(wagons, offset) -> the train `wagons` with `offset` added to every wagon number (fip)
pub fun renumber(wagons : list<int>, offset : int) : exn list<int>
  throw("implement me", ExnTodo)

// swap-pairs(wagons) -> the train `wagons` with the first and second wagon swapped, the third and fourth, and so on (fip)
pub fun swap-pairs(wagons : list<a>) : exn list<a>
  throw("implement me", ExnTodo)

// uncouple(wagons, number) -> the train `wagons` without the wagons numbered `number` (fbip)
pub fun uncouple(wagons : list<int>, number : int) : exn list<int>
  throw("implement me", ExnTodo)

// park(y, wagon) -> the yard `y` with `wagon` parked on a siding of its own, unless it is already there (fip(1))
pub fun park(y : yard, wagon : int) : exn yard
  throw("implement me", ExnTodo)
