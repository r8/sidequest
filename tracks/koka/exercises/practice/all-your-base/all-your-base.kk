// rebase(input-base, digits, output-base) -> the digits, most significant first, of the number
// whose digits in `input-base` are `digits`, written in `output-base`; zero is [0].
// Throws "input base must be >= 2", "output base must be >= 2" or
// "all digits must satisfy 0 <= d < input base"
pub fun rebase(input-base : int, digits : list<int>, output-base : int) : exn list<int>
  throw("implement me", ExnTodo)
