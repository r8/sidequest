// The colors of the resistor bands.
pub type color
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White

pub fun color/show(c : color) : string
  match c
    Black -> "Black"
    Brown -> "Brown"
    Red -> "Red"
    Orange -> "Orange"
    Yellow -> "Yellow"
    Green -> "Green"
    Blue -> "Blue"
    Violet -> "Violet"
    Grey -> "Grey"
    White -> "White"

pub fun color/(==)(a : color, b : color) : bool
  a.show == b.show

fun code(c : color) : int
  match c
    Black -> 0
    Brown -> 1
    Red -> 2
    Orange -> 3
    Yellow -> 4
    Green -> 5
    Blue -> 6
    Violet -> 7
    Grey -> 8
    White -> 9

// value(colors) -> the two-digit number that the first two bands in `colors` encode; further
// bands are ignored
pub fun value(colors : list<color>) : exn int
  match colors
    Cons(first, Cons(second, _)) -> first.code * 10 + second.code
    _ -> throw("a resistor needs at least two bands")
