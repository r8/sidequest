// move(pos, direction) -> the position one step from `pos` towards `direction`
pub fun move((x, y) : (int, int), direction : string) : (int, int)
  match direction
    "north" -> (x, y + 1)
    "south" -> (x, y - 1)
    "east" -> (x + 1, y)
    "west" -> (x - 1, y)
    _ -> (x, y)

// region(pos) -> the region of the island `pos` is in
pub fun region(pos : (int, int)) : string
  match pos
    (0, 0) -> "camp"
    (_, y) | y > 5 -> "mountains"
    (x, _) | x < 0 -> "swamp"
    _ -> "beach"

// paces(from, to) -> the steps along the grid from `from` to `to`
pub fun paces((x1, y1) : (int, int), (x2, y2) : (int, int)) : int
  abs(x2 - x1) + abs(y2 - y1)

// read-clues(clues) -> what the parrot says about `clues`
pub fun read-clues(clues : list<string>) : string
  match clues
    [] -> "No clues!"
    [clue] -> "Only " ++ clue ++ "!"
    [first, second] -> first ++ " then " ++ second ++ "!"
    Cons(first, rest) -> first ++ " then " ++ rest.length.show ++ " more!"
