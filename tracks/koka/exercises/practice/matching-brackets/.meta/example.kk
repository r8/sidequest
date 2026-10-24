fun closer(c : char) : maybe<char>
  match c
    '(' -> Just(')')
    '[' -> Just(']')
    '{' -> Just('}')
    _ -> Nothing

fun is-closer(c : char) : bool
  c == ')' || c == ']' || c == '}'

// `expected` holds the closers still owed, innermost first.
fun check(cs : list<char>, expected : list<char>) : bool
  match cs
    Nil -> expected.is-empty
    Cons(c, rest) ->
      match closer(c)
        Just(close) -> check(rest, Cons(close, expected))
        Nothing ->
          if !c.is-closer then check(rest, expected)
          else match expected
            Cons(e, owed) | e == c -> check(rest, owed)
            _ -> False

// is-paired(value) -> whether every bracket, brace and parenthesis in `value` is closed by its
// matching partner in the right order; other characters are ignored
pub fun is-paired(value : string) : bool
  check(value.list, [])
