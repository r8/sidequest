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

alias point = (int, int)

fun at(grid : list<list<char>>, (x, y) : point) : maybe<char>
  if x < 0 || y < 0 then Nothing
  else grid.drop(y).head.default([]).drop(x).head

// Every point of `grid`, sorted by x, then by y.
fun points(grid : list<list<char>>) : list<point>
  val width = grid.head.default([]).length
  list(0, width - 1).flatmap(fn(x) list(0, grid.length - 1).map(fn(y) (x, y)))

fun neighbours((x, y) : point) : list<point>
  [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]

// The empty points connected to `frontier` (given those already `seen`), and the stones
// bordering them.
fun flood(grid : list<list<char>>, frontier : list<point>, seen : list<point>, stones : list<char>) : div (list<point>, list<char>)
  match frontier
    Nil -> (seen, stones)
    Cons(p, rest) ->
      if seen.any(fn(q) q == p) then flood(grid, rest, seen, stones)
      else match grid.at(p)
        Just(' ') -> flood(grid, p.neighbours ++ rest, Cons(p, seen), stones)
        Just(stone) -> flood(grid, rest, seen, Cons(stone, stones))
        Nothing -> flood(grid, rest, seen, stones)

fun region(grid : list<list<char>>, p : point) : div (owner, list<point>)
  if grid.at(p) != Just(' ') then (None, [])
  else
    val (area, stones) = grid.flood([p], [], [])
    val owner = if stones.is-nil then None
                elif stones.all(fn(s) s == 'B') then Black
                elif stones.all(fn(s) s == 'W') then White
                else None
    (owner, grid.points.filter(fn(q) area.any(fn(a) a == q)))

// territory(board, x, y) -> the owner of the territory containing the intersection (x, y) and
// all the intersections of that territory; (None, []) if (x, y) holds a stone. Throws
// "Invalid coordinate" if (x, y) is not on the board.
pub fun territory(board : list<string>, x : int, y : int) : <div,exn> (owner, list<(int, int)>)
  val grid = board.map(list)
  if grid.at((x, y)).is-nothing then throw("Invalid coordinate")
  grid.region((x, y))

// territories(board) -> every empty intersection of `board`, grouped by its territory's owner
pub fun territories(board : list<string>) : div territories
  val grid = board.map(list)
  val owned = grid.points.filter(fn(p) grid.at(p) == Just(' ')).map(fn(p) (p, grid.region(p).fst))
  fun owned-by(o : owner) owned.filter(fn((_, w)) w == o).map(fst)
  Territories(owned-by(Black), owned-by(White), owned-by(None))
