// encode(phrase, a, b) -> the affine cipher E(x) = (a * x + b) mod 26 of the letters and digits of `phrase`,
// lowercase, in groups of 5 separated by spaces; throws "a and m must be coprime." unless `a` is coprime to 26
pub fun encode(phrase : string, a : int, b : int) : exn string
  throw("implement me", ExnTodo)

// decode(phrase, a, b) -> the plain text of the affine cipher `phrase` with key (a, b), lowercase, without spaces;
// throws "a and m must be coprime." unless `a` is coprime to 26
pub fun decode(phrase : string, a : int, b : int) : exn string
  throw("implement me", ExnTodo)
