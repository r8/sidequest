// A scoring category of the Yacht dice game.
pub type category
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht

fun index(c : category) : int
  match c
    Ones -> 0
    Twos -> 1
    Threes -> 2
    Fours -> 3
    Fives -> 4
    Sixes -> 5
    FullHouse -> 6
    FourOfAKind -> 7
    LittleStraight -> 8
    BigStraight -> 9
    Choice -> 10
    Yacht -> 11

pub fun (==)(a : category, b : category) : bool
  a.index == b.index

pub fun show(c : category) : string
  match c
    Ones -> "Ones"
    Twos -> "Twos"
    Threes -> "Threes"
    Fours -> "Fours"
    Fives -> "Fives"
    Sixes -> "Sixes"
    FullHouse -> "FullHouse"
    FourOfAKind -> "FourOfAKind"
    LittleStraight -> "LittleStraight"
    BigStraight -> "BigStraight"
    Choice -> "Choice"
    Yacht -> "Yacht"

// score(dice, category) -> the score of the five `dice` (each 1 to 6) in `category`
pub fun score(dice : list<int>, category : category) : exn int
  throw("implement me", ExnTodo)
