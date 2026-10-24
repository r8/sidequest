// A volunteer spots a bird of the species `bird`.
pub effect fun spot(bird : string) : ()

// The number for a new volunteer's badge.
pub effect fun ticket() : int

// numbered(first, action) -> the result of `action`, where tickets are numbered from `first` up
pub fun numbered(first : int, action : () -> <ticket,exn|e> a) : <exn|e> a
  throw("implement me", ExnTodo)

// count-spots(action) -> the result of `action` and the number of birds it spotted
pub fun count-spots(action : () -> <spot,exn|e> a) : <exn|e> (a, int)
  throw("implement me", ExnTodo)

// spotted(action) -> the result of `action` and the birds it spotted, in order
pub fun spotted(action : () -> <spot,exn|e> a) : <exn|e> (a, list<string>)
  throw("implement me", ExnTodo)

// species(action) -> the number of different species `action` spotted
pub fun species(action : () -> <spot,exn|e> a) : <exn|e> int
  throw("implement me", ExnTodo)
