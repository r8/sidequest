fun count-steps(n : int, acc : int) : div int
  if n == 1 then acc
  elif n.is-even then count-steps(n / 2, acc + 1)
  else count-steps(3 * n + 1, acc + 1)

// steps(n) -> the number of Collatz steps it takes to reach 1 from `n`;
// throws "Only positive integers are allowed" when `n` is not positive
pub fun steps(n : int) : <exn, div> int
  if n <= 0 then throw("Only positive integers are allowed")
  count-steps(n, 0)
