import std/num/float64

// Whether the sides are all positive and satisfy the triangle inequality.
fun triangle(a : float64, b : float64, c : float64) : bool
  a > 0.0 && b > 0.0 && c > 0.0 && a + b >= c && b + c >= a && a + c >= b

// The number of distinct side lengths.
fun distinct-sides(a : float64, b : float64, c : float64) : int
  if a == b && b == c then 1
  elif a == b || b == c || a == c then 2
  else 3

// equilateral(a, b, c) -> whether the sides form a triangle with all three sides equal
pub fun equilateral(a : float64, b : float64, c : float64) : bool
  triangle(a, b, c) && distinct-sides(a, b, c) == 1

// isosceles(a, b, c) -> whether the sides form a triangle with at least two sides equal
pub fun isosceles(a : float64, b : float64, c : float64) : bool
  triangle(a, b, c) && distinct-sides(a, b, c) <= 2

// scalene(a, b, c) -> whether the sides form a triangle with all three sides different
pub fun scalene(a : float64, b : float64, c : float64) : bool
  triangle(a, b, c) && distinct-sides(a, b, c) == 3
