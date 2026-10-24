// Extends a chain that starts at `start`, whose last domino ends in `end`, with all of `rest`.
// `acc` holds the chain so far, last domino first.
fun extend(start : int, end : int, rest : list<(int, int)>, acc : list<(int, int)>) : div maybe<list<(int, int)>>
  if rest.is-empty then
    if start == end then Just(acc.reverse) else Nothing
  else
    list(0, rest.length - 1).find-maybe fn(i)
      val others = rest.take(i) ++ rest.drop(i + 1)
      match rest[i]
        Just((a, b)) | a == end -> extend(start, b, others, Cons((a, b), acc))
        Just((a, b)) | b == end -> extend(start, a, others, Cons((b, a), acc))
        _ -> Nothing

// chain(dominoes) -> the dominoes in an order (each possibly flipped) where neighbouring halves match
// and the two free ends match each other; Nothing if there is no such chain
pub fun chain(dominoes : list<(int, int)>) : div maybe<list<(int, int)>>
  match dominoes
    Nil -> Just([])
    Cons((a, b), rest) -> extend(a, b, rest, [(a, b)])
