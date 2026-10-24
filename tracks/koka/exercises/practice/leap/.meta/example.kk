fun divisible(n : int, d : int) : bool
  n % d == 0

// leap-year(year) -> whether `year` is a leap year in the Gregorian calendar
pub fun leap-year(year : int) : bool
  year.divisible(4) && (!year.divisible(100) || year.divisible(400))
