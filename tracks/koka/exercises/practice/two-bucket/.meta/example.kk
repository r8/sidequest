// The two buckets.
pub type bucket
  One
  Two

pub fun bucket/(==)(a : bucket, b : bucket) : bool
  match (a, b)
    (One, One) -> True
    (Two, Two) -> True
    _ -> False

pub fun bucket/show(b : bucket) : string
  match b
    One -> "One"
    Two -> "Two"

// The outcome of a measurement: the number of moves taken, the bucket that ends up holding
// the goal amount, and how much is left in the other bucket.
pub struct measurement
  moves : int
  goal-bucket : bucket
  other-bucket : int

pub fun measurement/(==)(a : measurement, b : measurement) : bool
  a.moves == b.moves && a.goal-bucket == b.goal-bucket && a.other-bucket == b.other-bucket

pub fun measurement/show(m : measurement) : string
  "Measurement(" ++ m.moves.show ++ ", " ++ m.goal-bucket.show ++ ", " ++ m.other-bucket.show ++ ")"

// The states reachable in one move from (a, b), with buckets of sizes (x, y).
fun next-states((a, b) : (int, int), (x, y) : (int, int)) : list<(int, int)>
  val into-two = min(a, y - b)
  val into-one = min(b, x - a)
  [(x, b), (a, y), (0, b), (a, 0), (a - into-two, b + into-two), (a + into-one, b - into-one)]

// measure(bucket-one, bucket-two, goal, start-bucket) -> the fewest moves that measure `goal` liters
// with buckets of sizes `bucket-one` and `bucket-two`, filling `start-bucket` first;
// throws "impossible" if the goal can't be reached
pub fun measure(bucket-one : int, bucket-two : int, goal : int, start-bucket : bucket) : <div,exn> measurement
  val sizes = (bucket-one, bucket-two)
  val start = if start-bucket == One then (bucket-one, 0) else (0, bucket-two)
  // the rule: never leave the starting bucket empty while the other one is full
  val forbidden = if start-bucket == One then (0, bucket-two) else (bucket-one, 0)
  // breadth-first search, one layer of states per move
  fun search(layer : list<(int, int)>, seen : list<(int, int)>, moves : int) : <div,exn> measurement
    if layer.is-empty then throw("impossible")
    match layer.find(fn((a, b)) a == goal || b == goal)
      Just((a, b)) -> if a == goal then Measurement(moves, One, b) else Measurement(moves, Two, a)
      Nothing ->
        val next = layer.flatmap(fn(s) next-states(s, sizes))
                        .foldl([], fn(acc, s) if acc.contains(s) || seen.contains(s) || s == forbidden then acc else Cons(s, acc))
        search(next, seen ++ next, moves + 1)
  search([start], [start, forbidden], 1)
