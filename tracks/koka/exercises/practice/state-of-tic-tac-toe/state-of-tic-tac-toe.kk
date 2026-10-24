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

// game-state(board) -> the state of the game on `board`, three rows of 'X', 'O' and ' ';
// X plays first. Throws "Wrong turn order: O started", "Wrong turn order: X went twice" or
// "Impossible board: game should have ended after the game was won" for an invalid board.
pub fun game-state(board : list<string>) : exn game-state
  throw("implement me", ExnTodo)
