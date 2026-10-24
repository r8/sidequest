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

// measure(bucket-one, bucket-two, goal, start-bucket) -> the fewest moves that measure `goal` liters
// with buckets of sizes `bucket-one` and `bucket-two`, filling `start-bucket` first;
// throws "impossible" if the goal can't be reached
pub fun measure(bucket-one : int, bucket-two : int, goal : int, start-bucket : bucket) : exn measurement
  throw("implement me", ExnTodo)
