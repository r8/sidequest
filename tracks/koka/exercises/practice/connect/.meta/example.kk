// A player of Hex: X connects the left and right edges, O the top and bottom ones.
pub type player
  X
  O

pub fun (==)(a : player, b : player) : bool
  match (a, b)
    (X, X) -> True
    (O, O) -> True
    _ -> False

pub fun show(p : player) : string
  match p
    X -> "X"
    O -> "O"

alias cell = (int, int)

fun neighbours((r, c) : cell) : list<cell>
  [(r, c - 1), (r, c + 1), (r - 1, c), (r - 1, c + 1), (r + 1, c - 1), (r + 1, c)]

// Every cell reachable from `frontier` through cells in `stones`, given those already `seen`.
fun reach(stones : list<cell>, frontier : list<cell>, seen : list<cell>) : div list<cell>
  match frontier
    Nil -> seen
    Cons(p, rest) ->
      if seen.any(fn(q) q == p) then reach(stones, rest, seen)
      else
        val next = p.neighbours.filter(fn(q) stones.any(fn(s) s == q))
        reach(stones, next ++ rest, Cons(p, seen))

// The cells of `board` holding `stone`, as (row, column) positions.
fun cells(board : list<list<char>>, stone : char) : list<cell>
  board.map-indexed(fn(r, row) row.map-indexed(fn(c, ch) (c, ch)).filter(fn((_, ch)) ch == stone).map(fn((c, _)) (r, c))).concat

// Whether the stones of `stone` connect the cells where `start` holds to those where `goal` holds.
fun connects(board : list<list<char>>, stone : char, start : cell -> bool, goal : cell -> bool) : div bool
  val stones = board.cells(stone)
  reach(stones, stones.filter(start), []).any(goal)

// winner(board) -> the player who connected their two edges of `board`, or Nothing. Each row
// of `board` is indented by one more space than the one above it, its cells ('X', 'O' or '.')
// separated by spaces; a cell touches the cells left and right of it and two in each
// neighbouring row.
pub fun winner(board : list<string>) : div maybe<player>
  val grid = board.map(fn(row) row.list.filter(fn(ch) ch != ' '))
  val height = grid.length
  val width = grid.head.default([]).length
  if grid.connects('X', fn((_, c)) c == 0, fn((_, c)) c == width - 1) then Just(X)
  elif grid.connects('O', fn((r, _)) r == 0, fn((r, _)) r == height - 1) then Just(O)
  else Nothing
