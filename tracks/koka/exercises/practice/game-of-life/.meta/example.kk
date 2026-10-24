// `vector.at` does not check for negative indices, so guard against them here.
fun alive(grid : vector<vector<int>>, r : int, c : int) : int
  if r < 0 || c < 0 then 0
  else match grid.at(r)
    Just(row) -> row.at(c).default(0)
    Nothing -> 0

fun live-neighbours(grid : vector<vector<int>>, r : int, c : int) : int
  [-1, 0, 1].flatmap(fn(dr) [-1, 0, 1].map(fn(dc) (dr, dc)))
    .filter(fn((dr, dc)) dr != 0 || dc != 0)
    .map(fn((dr, dc)) grid.alive(r + dr, c + dc))
    .sum

fun next(cell : int, neighbours : int) : int
  match (cell, neighbours)
    (1, 2) -> 1
    (_, 3) -> 1
    _ -> 0

// tick(matrix) -> the next generation of Conway's Game of Life for `matrix`, a list of rows
// where 1 is a live cell and 0 a dead one; cells beyond the edges count as dead
pub fun tick(matrix : list<list<int>>) : list<list<int>>
  val grid = matrix.map(vector).vector
  matrix.map-indexed fn(r, row)
    row.map-indexed fn(c, cell)
      next(cell, grid.live-neighbours(r, c))
