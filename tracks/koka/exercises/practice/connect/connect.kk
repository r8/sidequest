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

// winner(board) -> the player who connected their two edges of `board`, or Nothing. Each row
// of `board` is indented by one more space than the one above it, its cells ('X', 'O' or '.')
// separated by spaces; a cell touches the cells left and right of it and two in each
// neighbouring row.
pub fun winner(board : list<string>) : exn maybe<player>
  throw("implement me", ExnTodo)
