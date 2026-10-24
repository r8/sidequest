// The state of a game of tic-tac-toe.
pub type game-state
  Win
  Draw
  Ongoing

pub fun (==)(a : game-state, b : game-state) : bool
  match (a, b)
    (Win, Win) -> True
    (Draw, Draw) -> True
    (Ongoing, Ongoing) -> True
    _ -> False

pub fun show(s : game-state) : string
  match s
    Win -> "Win"
    Draw -> "Draw"
    Ongoing -> "Ongoing"

// The eight lines of three cells, as (row, column) positions.
val lines : list<list<(int, int)>> =
  val rows = list(0, 2).map(fn(r) list(0, 2).map(fn(c) (r, c)))
  val columns = list(0, 2).map(fn(c) list(0, 2).map(fn(r) (r, c)))
  val diagonals = [list(0, 2).map(fn(i) (i, i)), list(0, 2).map(fn(i) (i, 2 - i))]
  rows ++ columns ++ diagonals

fun wins(cells : list<list<char>>, player : char) : bool
  lines.any fn(line)
    line.all(fn((r, c)) cells.drop(r).head.default([]).drop(c).head == Just(player))

// game-state(board) -> the state of the game on `board`, three rows of 'X', 'O' and ' ';
// X plays first. Throws "Wrong turn order: O started", "Wrong turn order: X went twice" or
// "Impossible board: game should have ended after the game was won" for an invalid board.
pub fun game-state(board : list<string>) : exn game-state
  val cells = board.map(list)
  val xs = cells.concat.filter(fn(ch) ch == 'X').length
  val os = cells.concat.filter(fn(ch) ch == 'O').length
  val x-wins = cells.wins('X')
  val o-wins = cells.wins('O')
  if os > xs then throw("Wrong turn order: O started")
  if xs > os + 1 then throw("Wrong turn order: X went twice")
  if (x-wins && o-wins) || (x-wins && xs == os) || (o-wins && xs > os) then
    throw("Impossible board: game should have ended after the game was won")
  if x-wins || o-wins then Win
  elif xs + os == 9 then Draw
  else Ongoing
