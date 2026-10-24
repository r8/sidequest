// Where a word was found: the (row, column) positions, 1-based, of its first and last letters.
pub struct word-location
  start : (int, int)
  end : (int, int)

pub fun (==)(a : word-location, b : word-location) : bool
  a.start == b.start && a.end == b.end

pub fun show(l : word-location) : string
  "Word-location(" ++ l.start.show ++ ", " ++ l.end.show ++ ")"

// search(grid, words) -> each of `words`, in the given order, paired with where it appears in
// `grid` (a list of rows), read in a straight line in any of the eight directions, or Nothing
pub fun search(grid : list<string>, words : list<string>) : exn list<(string, maybe<word-location>)>
  throw("implement me", ExnTodo)
