// `vector.at` does not check for negative indices, so guard against them here.
fun is-flower(grid : vector<vector<char>>, r : int, c : int) : bool
  if r < 0 || c < 0 then False
  else match grid.at(r)
    Just(row) -> row.at(c) == Just('*')
    Nothing -> False

fun neighbours(r : int, c : int) : list<(int, int)>
  [-1, 0, 1].flatmap(fn(dr) [-1, 0, 1].map(fn(dc) (r + dr, c + dc))).filter(fn(p) p != (r, c))

fun cell(grid : vector<vector<char>>, r : int, c : int, ch : char) : char
  if ch == '*' then '*'
  else
    val n = neighbours(r, c).filter(fn((nr, nc)) grid.is-flower(nr, nc)).length
    if n == 0 then ' ' else ('0'.int + n).char

// annotate(garden) -> the garden (a list of rows, '*' for a flower and ' ' for an empty square)
// with each empty square that touches flowers, also diagonally, replaced by their count
pub fun annotate(garden : list<string>) : list<string>
  val grid = garden.map(fn(row) row.list.vector).vector
  garden.map-indexed fn(r, row)
    row.list.map-indexed(fn(c, ch) grid.cell(r, c, ch)).string
