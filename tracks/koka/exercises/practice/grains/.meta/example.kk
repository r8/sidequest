// square(n) -> the number of grains on square `n` of the chessboard;
// throws "square must be between 1 and 64" otherwise
pub fun square(n : int) : exn int
  if n < 1 || n > 64 then throw("square must be between 1 and 64")
  2.pow(n - 1)

// total() -> the number of grains on the whole chessboard
pub fun total() : int
  2.pow(64) - 1
