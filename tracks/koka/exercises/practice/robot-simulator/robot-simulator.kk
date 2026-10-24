// The four directions a robot can face.
pub type direction
  North
  East
  South
  West

pub fun direction/(==)(a : direction, b : direction) : bool
  match (a, b)
    (North, North) -> True
    (East, East) -> True
    (South, South) -> True
    (West, West) -> True
    _ -> False

pub fun direction/show(d : direction) : string
  match d
    North -> "North"
    East -> "East"
    South -> "South"
    West -> "West"

// A robot at `position` (x, y), facing `direction`.
pub struct robot
  position : (int, int)
  direction : direction

pub fun robot/(==)(a : robot, b : robot) : bool
  a.position == b.position && a.direction == b.direction

pub fun robot/show(r : robot) : string
  "Robot(" ++ r.position.show ++ ", " ++ r.direction.show ++ ")"

// create(position, direction) -> a robot at `position` facing `direction`
pub fun create(position : (int, int), direction : direction) : exn robot
  throw("implement me", ExnTodo)

// move(robot, instructions) -> the robot after following `instructions`, a string of
// 'R' (turn right), 'L' (turn left) and 'A' (advance one step)
pub fun move(robot : robot, instructions : string) : exn robot
  throw("implement me", ExnTodo)
