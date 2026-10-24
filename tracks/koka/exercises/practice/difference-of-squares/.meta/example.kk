fun square(n : int) : int
  n * n

// square-of-sum(n) -> the square of the sum of the first `n` natural numbers
pub fun square-of-sum(n : int) : int
  list(1, n).sum.square

// sum-of-squares(n) -> the sum of the squares of the first `n` natural numbers
pub fun sum-of-squares(n : int) : int
  list(1, n).map(square).sum

// difference-of-squares(n) -> square-of-sum(n) minus sum-of-squares(n)
pub fun difference-of-squares(n : int) : int
  square-of-sum(n) - sum-of-squares(n)
