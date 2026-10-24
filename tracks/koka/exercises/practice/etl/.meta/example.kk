fun lower(c : char) : char
  if c.is-upper then c - 'A' + 'a' else c

fun insert(p : (char, int), ps : list<(char, int)>) : list<(char, int)>
  match ps
    Cons(q, qs) | q.fst < p.fst -> Cons(q, insert(p, qs))
    _ -> Cons(p, ps)

// transform(legacy) -> the scores of `legacy`, given as (score, upper-case letters) pairs,
// turned into (lower-case letter, score) pairs sorted by letter
pub fun transform(legacy : list<(int, list<char>)>) : list<(char, int)>
  legacy.flatmap(fn((score, letters)) letters.map(fn(c) (c.lower, score)))
        .foldr([], insert)
