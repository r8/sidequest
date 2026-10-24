// A game of bowling in progress: the rolls so far, oldest first.
// You may change this type to whatever your solution needs; the tests only use the functions below.
pub struct game
  rolls : list<int>

// The most pins the next roll can knock down in the tenth frame, or Nothing once the game is over.
fun tenth-frame(rolls : list<int>) : maybe<int>
  match rolls
    [] -> Just(10)
    [a] -> Just(if a == 10 then 10 else 10 - a)
    [a, b] ->
      if a == 10 then Just(if b == 10 then 10 else 10 - b)
      elif a + b == 10 then Just(10)
      else Nothing
    _ -> Nothing

// The most pins the next roll can knock down, or Nothing once the game is over.
fun pins-standing(rolls : list<int>, frame : int) : maybe<int>
  if frame == 10 then tenth-frame(rolls)
  else match rolls
    Nil -> Just(10)
    Cons(10, rest) -> pins-standing(rest, frame + 1)
    Cons(a, Nil) -> Just(10 - a)
    Cons(_, Cons(_, rest)) -> pins-standing(rest, frame + 1)

fun frame-scores(rolls : list<int>, frame : int) : int
  if frame > 10 then 0
  else match rolls
    Cons(10, rest) -> 10 + rest.take(2).sum + frame-scores(rest, frame + 1)
    Cons(a, Cons(b, rest)) ->
      val bonus = if a + b == 10 then rest.take(1).sum else 0
      a + b + bonus + frame-scores(rest, frame + 1)
    _ -> rolls.sum

// new-game() -> a game with no rolls yet
pub fun new-game() : game
  Game([])

// roll(game, pins) -> the game after knocking down `pins` pins; throws "Negative roll is invalid",
// "Pin count exceeds pins on the lane" or "Cannot roll after game is over" for an invalid roll
pub fun roll(game : game, pins : int) : exn game
  if pins < 0 then throw("Negative roll is invalid")
  match pins-standing(game.rolls, 1)
    Nothing -> throw("Cannot roll after game is over")
    Just(standing) ->
      if pins > standing then throw("Pin count exceeds pins on the lane")
      Game(game.rolls ++ [pins])

// score(game) -> the total score of a finished game; throws
// "Score cannot be taken until the end of the game" if it isn't finished
pub fun score(game : game) : exn int
  if pins-standing(game.rolls, 1).is-just then throw("Score cannot be taken until the end of the game")
  frame-scores(game.rolls, 1)
