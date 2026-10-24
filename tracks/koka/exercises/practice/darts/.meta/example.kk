import std/num/float64

// score(x, y) -> the points scored by a dart landing at (x, y): 10, 5, 1 or 0
pub fun score(x : float64, y : float64) : int
  val d2 = x * x + y * y
  if d2 <= 1.0 then 10
  elif d2 <= 25.0 then 5
  elif d2 <= 100.0 then 1
  else 0
