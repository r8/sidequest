// Who owns a territory: the only colour bordering it, or None.
pub type owner
  Black
  White
  None

pub fun owner/(==)(a : owner, b : owner) : bool
  match (a, b)
    (Black, Black) -> True
    (White, White) -> True
    (None, None) -> True
    _ -> False

pub fun owner/show(o : owner) : string
  match o
    Black -> "Black"
    White -> "White"
    None -> "None"

// The empty intersections of a board grouped by owner, each list sorted.
pub struct territories
  black : list<(int, int)>
  white : list<(int, int)>
  none : list<(int, int)>

pub fun territories/(==)(a : territories, b : territories) : bool
  a.black == b.black && a.white == b.white && a.none == b.none

pub fun territories/show(t : territories) : string
  "Territories(black: " ++ t.black.show ++ ", white: " ++ t.white.show ++ ", none: " ++ t.none.show ++ ")"

// Boards are lists of rows of 'B' (black stone), 'W' (white stone) and ' ' (empty). Positions
// are (x, y) pairs, 0-based: x is the column, y the row. Lists of positions are sorted by x,
// then by y.

// territory(board, x, y) -> the owner of the territory containing the intersection (x, y) and
// all the intersections of that territory; (None, []) if (x, y) holds a stone. Throws
// "Invalid coordinate" if (x, y) is not on the board.
pub fun territory(board : list<string>, x : int, y : int) : exn (owner, list<(int, int)>)
  throw("implement me", ExnTodo)

// territories(board) -> every empty intersection of `board`, grouped by its territory's owner
pub fun territories(board : list<string>) : exn territories
  throw("implement me", ExnTodo)
