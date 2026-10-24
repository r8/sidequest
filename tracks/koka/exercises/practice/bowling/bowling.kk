// A game of bowling in progress: the rolls so far, oldest first.
// You may change this type to whatever your solution needs; the tests only use the functions below.
pub struct game
  rolls : list<int>

// new-game() -> a game with no rolls yet
pub fun new-game() : exn game
  throw("implement me", ExnTodo)

// roll(game, pins) -> the game after knocking down `pins` pins; throws "Negative roll is invalid",
// "Pin count exceeds pins on the lane" or "Cannot roll after game is over" for an invalid roll
pub fun roll(game : game, pins : int) : exn game
  throw("implement me", ExnTodo)

// score(game) -> the total score of a finished game; throws
// "Score cannot be taken until the end of the game" if it isn't finished
pub fun score(game : game) : exn int
  throw("implement me", ExnTodo)
