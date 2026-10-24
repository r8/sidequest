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

// Moves the wagons of `wagons` onto the front of `done`, one at a time.
fip fun reverse-onto(wagons : list<a>, done : list<a>) : list<a>
  match wagons
    Cons(w, rest) -> reverse-onto(rest, Cons(w, done))
    Nil -> done

// reverse-train(wagons) -> the train `wagons` with its wagons in the opposite order (fip)
pub fip fun reverse-train(wagons : list<a>) : list<a>
  reverse-onto(wagons, Nil)

// renumber(wagons, offset) -> the train `wagons` with `offset` added to every wagon number (fip)
pub fip fun renumber(wagons : list<int>, offset : int) : list<int>
  match wagons
    Cons(w, rest) -> Cons(w + offset, renumber(rest, offset))
    Nil -> Nil

// swap-pairs(wagons) -> the train `wagons` with the first and second wagon swapped, the third and fourth, and so on (fip)
pub fip fun swap-pairs(wagons : list<a>) : list<a>
  match wagons
    Cons(a, Cons(b, rest)) -> Cons(b, Cons(a, swap-pairs(rest)))
    Cons(a, Nil) -> Cons(a, Nil)
    Nil -> Nil

// uncouple(wagons, number) -> the train `wagons` without the wagons numbered `number` (fbip)
pub fbip fun uncouple(wagons : list<int>, number : int) : list<int>
  match wagons
    Cons(w, rest) ->
      if w == number then uncouple(rest, number)
      else Cons(w, uncouple(rest, number))
    Nil -> Nil

// park(y, wagon) -> the yard `y` with `wagon` parked on a siding of its own, unless it is already there (fip(1))
pub fip(1) fun park(y : yard, wagon : int) : yard
  match y
    Siding(l, w, r) ->
      if wagon < w then Siding(park(l, wagon), w, r)
      elif wagon > w then Siding(l, w, park(r, wagon))
      else Siding(l, w, r)
    Buffer -> Siding(Buffer, wagon, Buffer)
