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

fun count(dice : list<int>, face : int) : int
  dice.filter(fn(d) d == face).length

// (count, face) for each face shown, faces on three or more dice first.
fun counts(dice : list<int>) : list<(int, int)>
  val present = list(1, 6).filter(fn(face) dice.count(face) > 0).map(fn(face) (dice.count(face), face))
  present.filter(fn((n, _)) n >= 3) ++ present.filter(fn((n, _)) n < 3)

fun faces(dice : list<int>, face : int) : int
  face * dice.count(face)

fun straight(dice : list<int>, faces : list<int>) : int
  if faces.all(fn(face) dice.count(face) == 1) then 30 else 0

// score(dice, category) -> the score of the five `dice` (each 1 to 6) in `category`
pub fun score(dice : list<int>, category : category) : int
  match category
    Ones -> dice.faces(1)
    Twos -> dice.faces(2)
    Threes -> dice.faces(3)
    Fours -> dice.faces(4)
    Fives -> dice.faces(5)
    Sixes -> dice.faces(6)
    FullHouse -> match dice.counts
      [(3, _), (2, _)] -> dice.sum
      _ -> 0
    FourOfAKind -> match dice.counts
      Cons((n, face), _) | n >= 4 -> 4 * face
      _ -> 0
    LittleStraight -> dice.straight(list(1, 5))
    BigStraight -> dice.straight(list(2, 6))
    Choice -> dice.sum
    Yacht -> if dice.count(dice.head.default(0)) == 5 then 50 else 0
