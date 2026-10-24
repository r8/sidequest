// recite(pieces) -> the lines of the proverb built from `pieces`
pub fun recite(pieces : list<string>) : list<string>
  match pieces
    Nil -> Nil
    Cons(first, rest) ->
      zipwith(pieces, rest, fn(wanted, lost) "For want of a " ++ wanted ++ " the " ++ lost ++ " was lost.")
        ++ ["And all for the want of a " ++ first ++ "."]
