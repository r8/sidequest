import std/num/random

// A character's six abilities and hit points.
pub struct character
  strength : int
  dexterity : int
  constitution : int
  intelligence : int
  wisdom : int
  charisma : int
  hitpoints : int

pub fun character/(==)(a : character, b : character) : bool
  a.strength == b.strength && a.dexterity == b.dexterity && a.constitution == b.constitution &&
  a.intelligence == b.intelligence && a.wisdom == b.wisdom && a.charisma == b.charisma && a.hitpoints == b.hitpoints

pub fun character/show(c : character) : string
  "Character(" ++ [c.strength, c.dexterity, c.constitution, c.intelligence, c.wisdom, c.charisma, c.hitpoints].map(show).join(", ") ++ ")"

// modifier(score) -> the modifier for an ability `score`
pub fun modifier(score : int) : exn int
  throw("implement me", ExnTodo)

// ability() -> a random ability score: the sum of the three highest of four six-sided dice rolls
// (std/num/random's `random-int()` gives random numbers under the `random` effect)
pub fun ability() : <random,exn> int
  throw("implement me", ExnTodo)

// character() -> a random character: each ability rolled with `ability()`, and hit points
// of 10 plus the constitution modifier
pub fun character() : <random,exn> character
  throw("implement me", ExnTodo)
