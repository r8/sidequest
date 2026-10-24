// The team gives up: the game ends.
pub effect ctl give-up(reason : string) : a

// The team asks the game master for a hint on a puzzle.
pub effect ctl hint(puzzle : string) : string

// attempt(action) -> Just the result of `action`, or Nothing if the team gives up
pub fun attempt(action : () -> <give-up|e> a) : e maybe<a>
  with final ctl give-up(_) Nothing
  Just(action())

// with-hints(book, action) -> Just the result of `action` with every hint taken from `book`, or Nothing if the
// book has no hint for a puzzle the team asks about
pub fun with-hints(book : list<(string, string)>, action : () -> <hint|e> a) : e maybe<a>
  with ctl hint(puzzle)
    match book.lookup(fn(p) p == puzzle)
      Just(help) -> resume(help)
      Nothing -> Nothing
  Just(action())

// counting-hints(action) -> the result of `action` and the number of hints it asked for, passing them on
pub fun counting-hints(action : () -> <hint|e> a) : <hint|e> (a, int)
  with override ctl hint(puzzle)
    val (result, count) = resume(hint(puzzle))
    (result, count + 1)
  (action(), 0)

// strict(action) -> the result of `action`, where asking for a hint gives up
pub fun strict(action : () -> <hint,give-up|e> a) : <give-up|e> a
  with ctl hint(puzzle) give-up("asked for a hint on " ++ puzzle)
  action()
