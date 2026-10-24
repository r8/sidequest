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

// Scales `ohms` down by thousands while it divides evenly and a larger unit is left.
fun scaled(ohms : int, units : list<string>) : string
  match units
    Cons(unit, rest) ->
      if ohms > 0 && ohms % 1000 == 0 && rest.is-cons then scaled(ohms / 1000, rest)
      else ohms.show ++ " " ++ unit
    Nil -> ohms.show

// label(colors) -> the resistance that the first three bands in `colors` encode, such as
// "33 ohms" or "2 kiloohms"; further bands are ignored
pub fun label(colors : list<color>) : exn string
  match colors
    Cons(a, Cons(b, Cons(zeros, _))) ->
      val ohms = (a.code * 10 + b.code) * 10.pow(zeros.code)
      scaled(ohms, ["ohms", "kiloohms", "megaohms", "gigaohms"])
    _ -> throw("a resistor needs at least three bands")
