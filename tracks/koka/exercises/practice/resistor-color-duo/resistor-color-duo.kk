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

// value(colors) -> the two-digit number that the first two bands in `colors` encode; further
// bands are ignored
pub fun value(colors : list<color>) : exn int
  throw("implement me", ExnTodo)
