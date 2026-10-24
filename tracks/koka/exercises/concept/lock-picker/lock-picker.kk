// A lock-picking program asks the machine for a digit with `pick-digit`, choosing among `options`, and
// gives up on the current attempt with `dead-end`. The handlers below decide which digits get tried.
pub effect pick
  ctl pick-digit(options : list<int>) : int
  ctl dead-end() : a

// all-outcomes(action) -> the results of `action` for every digit it could pick, in the order of the options
pub fun all-outcomes(action : () -> <pick,exn|e> a) : <exn|e> list<a>
  throw("implement me", ExnTodo)

// count-outcomes(action) -> how many ways of picking digits let `action` finish
pub fun count-outcomes(action : () -> <pick,exn|e> a) : <exn|e> int
  throw("implement me", ExnTodo)

// first-outcome(action) -> the first result of `action` in the order of the options, or Nothing if every attempt is a dead end
pub fun first-outcome(action : () -> <pick,exn|e> a) : <exn|e> maybe<a>
  throw("implement me", ExnTodo)

// combination(length, digits) -> a combination of `length` digits, each picked from `digits`
pub fun combination(length : int, digits : list<int>) : <pick,div,exn> list<int>
  throw("implement me", ExnTodo)

// opening(length, digits, fits) -> a combination of `length` digits from `digits` for which `fits` holds
pub fun opening(length : int, digits : list<int>, fits : (list<int>) -> bool) : <pick,div,exn> list<int>
  throw("implement me", ExnTodo)
