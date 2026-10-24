// Insertion sort, highest first.
fun insert-desc(x : a, xs : list<a>, ?cmp : (a, a) -> order) : list<a>
  match xs
    Cons(y, rest) | cmp(y, x) == Gt -> Cons(y, insert-desc(x, rest))
    _ -> Cons(x, xs)

fun sort-desc(xs : list<a>, ?cmp : (a, a) -> order) : list<a>
  xs.foldl([], fn(acc, x) insert-desc(x, acc))

fun rank-value(rank : string) : int
  match rank
    "J" -> 11
    "Q" -> 12
    "K" -> 13
    "A" -> 14
    _ -> rank.parse-int.default(0)

// A card as (rank value, suit).
fun parse-card(card : string) : (int, char)
  val cs = card.list
  (cs.init.string.rank-value, cs.last.default(' '))

// Groups of equal ranks as (count, rank), biggest and then highest group first.
fun groups(ranks : list<int>) : list<(int, int)>
  val distinct = ranks.foldl([], fn(acc, r) if acc.contains(r) then acc else Cons(r, acc))
  val counted = distinct.map(fn(r) (ranks.filter(fn(x) x == r).length, r))
  counted.sort-desc

// A list that compares higher for a better hand: the category, then the tie-breaking ranks.
fun hand-key(hand : string) : list<int>
  val cards = hand.split(" ").map(parse-card)
  val ranks = cards.map(fst).sort-desc
  val flush = cards.all(fn(c) c.snd == cards.head(c).snd)
  val ace-low = ranks == [14, 5, 4, 3, 2]
  val high = if ace-low then [5, 4, 3, 2, 1] else ranks
  val straight = ace-low || (groups(ranks).length == 5 && ranks.head(0) - ranks.last.default(0) == 4)
  val gs = groups(ranks)
  val counts = gs.map(fst)
  val tie = gs.map(snd)
  if straight && flush then Cons(8, high)
  elif counts == [4, 1] then Cons(7, tie)
  elif counts == [3, 2] then Cons(6, tie)
  elif flush then Cons(5, ranks)
  elif straight then Cons(4, high)
  elif counts == [3, 1, 1] then Cons(3, tie)
  elif counts == [2, 2, 1] then Cons(2, tie)
  elif counts == [2, 1, 1, 1] then Cons(1, tie)
  else Cons(0, ranks)

// best-hands(hands) -> the winning hands, in their original order; each hand is five cards
// such as "4S 5S 7H 8D JC" (rank 2-10, J, Q, K or A, then suit C, D, H or S)
pub fun best-hands(hands : list<string>) : list<string>
  val keyed = hands.map(fn(h) (h.hand-key, h))
  val best = keyed.foldl([], fn(acc, (k, _)) if cmp(k, acc) == Gt then k else acc)
  keyed.filter(fn((k, _)) k == best).map(snd)
