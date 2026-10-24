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

// label(colors) -> the resistance that the first three bands in `colors` encode, such as
// "33 ohms" or "2 kiloohms"; further bands are ignored
pub fun label(colors : list<color>) : exn string
  throw("implement me", ExnTodo)
