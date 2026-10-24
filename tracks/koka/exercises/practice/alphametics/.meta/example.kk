// Adds `w` to the weight of letter `c`.
fun add-weight(weights : list<(char, int)>, c : char, w : int) : list<(char, int)>
  match weights
    Nil -> [(c, w)]
    Cons((d, v), rest) -> if c == d then Cons((d, v + w), rest) else Cons((d, v), add-weight(rest, c, w))

// Adds the place values of `word`'s letters, times `sign`, to their weights.
fun word-weights(weights : list<(char, int)>, word : string, sign : int) : list<(char, int)>
  val (ws, _) = word.list.reverse.foldl((weights, sign), fn((acc, place), c) (add-weight(acc, c, place), place * 10))
  ws

fun insert-by(x : a, xs : list<a>, before : (a, a) -> bool) : list<a>
  match xs
    Cons(y, rest) | !before(x, y) -> Cons(y, insert-by(x, rest, before))
    _ -> Cons(x, xs)

fun sort-by(xs : list<a>, before : (a, a) -> bool) : list<a>
  xs.foldl([], fn(acc, x) insert-by(x, acc, before))

// A letter to assign: its weight, whether it may be zero, and the least and greatest total the
// letters after it can still add.
struct slot
  letter : char
  weight : int
  nonzero : bool
  low : int
  high : int

// The slot for letter `c` with weight `w`, followed by the slots `rest`.
fun make-slot(c : char, w : int, nonzero : bool, rest : list<slot>) : slot
  match rest
    Cons(next, _) -> Slot(c, w, nonzero, next.low + min(0, 9 * next.weight), next.high + max(0, 9 * next.weight))
    Nil -> Slot(c, w, nonzero, 0, 0)

// Assigns distinct digits to `slots` so the weighted sum, starting from `total`, ends at zero.
fun assign(slots : list<slot>, used : list<int>, total : int) : maybe<list<(char, int)>>
  match slots
    Nil -> if total == 0 then Just([]) else Nothing
    Cons(s, rest) ->
      list(if s.nonzero then 1 else 0, 9).find-maybe fn(d)
        val t = total + d * s.weight
        if used.contains(d) || t + s.low > 0 || t + s.high < 0 then Nothing
        else match assign(rest, Cons(d, used), t)
          Just(sol) -> Just(Cons((s.letter, d), sol))
          Nothing -> Nothing

// solve(puzzle) -> the digit for each letter, as a list of (letter, digit) sorted by letter, that makes
// a puzzle like "SEND + MORE == MONEY" true, with a different digit per letter and no leading zeros;
// Nothing if there is no solution
pub fun solve(puzzle : string) : maybe<list<(char, int)>>
  match puzzle.split("==")
    [lhs, rhs] ->
      val left = lhs.split("+").map(trim)
      val right = rhs.split("+").map(trim)
      val weights = right.foldl(left.foldl([], fn(ws, w) word-weights(ws, w, 1)), fn(ws, w) word-weights(ws, w, -1))
      val leading = (left ++ right).filter(fn(w) w.count > 1).flatmap(fn(w) w.list.take(1))
      // biggest weights first, so the bounds prune early
      val sorted = weights.sort-by(fn(a, b) a.snd.abs >= b.snd.abs)
      val slots = sorted.foldr([], fn((c, w), acc) Cons(make-slot(c, w, leading.contains(c), acc), acc))
      match assign(slots, [], 0)
        Just(sol) -> Just(sol.sort-by(fn(a, b) a.fst <= b.fst))
        Nothing -> Nothing
    _ -> Nothing
