// Where a word was found: the (row, column) positions, 1-based, of its first and last letters.
pub struct word-location
  start : (int, int)
  end : (int, int)

pub fun (==)(a : word-location, b : word-location) : bool
  a.start == b.start && a.end == b.end

pub fun show(l : word-location) : string
  "Word-location(" ++ l.start.show ++ ", " ++ l.end.show ++ ")"

val directions : list<(int, int)> =
  [-1, 0, 1].flatmap(fn(dr) [-1, 0, 1].map(fn(dc) (dr, dc))).filter(fn((dr, dc)) dr != 0 || dc != 0)

// `vector.at` does not check for negative indices, so guard against them here.
fun letter(grid : vector<vector<char>>, r : int, c : int) : maybe<char>
  if r < 0 || c < 0 then Nothing
  else grid.at(r).maybe(Nothing, fn(row) row.at(c))

// Whether `word` reads from (r, c) in direction (dr, dc).
fun reads(grid : vector<vector<char>>, word : list<char>, r : int, c : int, dr : int, dc : int) : bool
  match word
    Nil -> True
    Cons(ch, rest) -> grid.letter(r, c) == Just(ch) && grid.reads(rest, r + dr, c + dc, dr, dc)

fun locate(grid : vector<vector<char>>, word : string) : maybe<word-location>
  val letters = word.list
  val n = letters.length
  val starts = list(0, grid.length - 1).flatmap fn(r)
    list(0, grid.at(r).maybe(0, length) - 1).map(fn(c) (r, c))
  starts.find-maybe fn((r, c))
    directions.find((fn((dr, dc)) grid.reads(letters, r, c, dr, dc))).map fn((dr, dc))
      Word-location((r + 1, c + 1), (r + 1 + (n - 1) * dr, c + 1 + (n - 1) * dc))

// search(grid, words) -> each of `words`, in the given order, paired with where it appears in
// `grid` (a list of rows), read in a straight line in any of the eight directions, or Nothing
pub fun search(grid : list<string>, words : list<string>) : list<(string, maybe<word-location>)>
  val g = grid.map(fn(row) row.list.vector).vector
  words.map(fn(word) (word, g.locate(word)))
