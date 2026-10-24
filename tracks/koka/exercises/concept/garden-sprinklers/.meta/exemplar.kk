// twice(action) -> runs `action` two times
pub fun twice(action : () -> e ()) : e ()
  action()
  action()

// each-bed(garden, action) -> runs `action` on every bed of `garden` that is switched on, in order
pub fun each-bed(garden : list<string>, action : (string) -> e ()) : e ()
  with bed <- garden.foreach
  if !bed.starts-with("#").is-just then action(bed)

// round-plan(garden, rounds) -> the entries "round <n>: <bed>" of `rounds` rounds of watering `garden`
pub fun round-plan(garden : list<string>, rounds : int) : list<string>
  var plan := []
  for(1, rounds) fn(round)
    with bed <- each-bed(garden)
    plan := Cons("round " ++ round.show ++ ": " ++ bed, plan)
  plan.reverse

// double-soak(garden) -> the beds of `garden` in watering order, when every bed is soaked twice in a row
pub fun double-soak(garden : list<string>) : list<string>
  var order := []
  each-bed(garden) fn(bed)
    with twice
    order := Cons(bed, order)
  order.reverse
