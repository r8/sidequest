// twice(action) -> runs `action` two times
pub fun twice(action : () -> <exn|e> ()) : <exn|e> ()
  throw("implement me", ExnTodo)

// each-bed(garden, action) -> runs `action` on every bed of `garden` that is switched on, in order
pub fun each-bed(garden : list<string>, action : (string) -> <exn|e> ()) : <exn|e> ()
  throw("implement me", ExnTodo)

// round-plan(garden, rounds) -> the entries "round <n>: <bed>" of `rounds` rounds of watering `garden`
pub fun round-plan(garden : list<string>, rounds : int) : exn list<string>
  throw("implement me", ExnTodo)

// double-soak(garden) -> the beds of `garden` in watering order, when every bed is soaked twice in a row
pub fun double-soak(garden : list<string>) : exn list<string>
  throw("implement me", ExnTodo)
