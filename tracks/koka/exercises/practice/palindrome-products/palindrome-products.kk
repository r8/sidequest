// smallest(min-factor, max-factor) -> the smallest palindromic product of two factors from
// min-factor to max-factor, with all its factor pairs (a, b), a <= b, in ascending order of a;
// Nothing if there is none. Throws "min must be <= max"
pub fun smallest(min-factor : int, max-factor : int) : exn maybe<(int, list<(int, int)>)>
  throw("implement me", ExnTodo)

// largest(min-factor, max-factor) -> the largest palindromic product of two factors from
// min-factor to max-factor, with all its factor pairs (a, b), a <= b, in ascending order of a;
// Nothing if there is none. Throws "min must be <= max"
pub fun largest(min-factor : int, max-factor : int) : exn maybe<(int, list<(int, int)>)>
  throw("implement me", ExnTodo)
