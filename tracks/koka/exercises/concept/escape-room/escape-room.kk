// The team gives up: the game ends.
pub effect ctl give-up(reason : string) : a

// The team asks the game master for a hint on a puzzle.
pub effect ctl hint(puzzle : string) : string

// attempt(action) -> Just the result of `action`, or Nothing if the team gives up
pub fun attempt(action : () -> <give-up,exn|e> a) : <exn|e> maybe<a>
  throw("implement me", ExnTodo)

// with-hints(book, action) -> Just the result of `action` with every hint taken from `book`, or Nothing if the
// book has no hint for a puzzle the team asks about
pub fun with-hints(book : list<(string, string)>, action : () -> <hint,exn|e> a) : <exn|e> maybe<a>
  throw("implement me", ExnTodo)

// counting-hints(action) -> the result of `action` and the number of hints it asked for, passing them on
pub fun counting-hints(action : () -> <hint,exn|e> a) : <hint,exn|e> (a, int)
  throw("implement me", ExnTodo)

// strict(action) -> the result of `action`, where asking for a hint gives up
pub fun strict(action : () -> <hint,give-up,exn|e> a) : <give-up,exn|e> a
  throw("implement me", ExnTodo)
