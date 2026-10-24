# Introduction

`match` compares a value against patterns, tried from the top, and evaluates the branch of the first that fits:

```koka
fun summary(xs : list<string>) : string
  match xs
    [] -> "nothing"
    [x] -> "just " ++ x
    Cons(x, rest) | rest.length > 3 -> x ++ " and many more"
    Cons(x, _) -> x ++ " and a few more"
```

A pattern is a literal (`0`, `"north"`), a name that binds whatever is there, `_` that matches anything, a tuple
of patterns, or a constructor such as `Nil` and `Cons(head, tail)`, with list shorthands like `[]`, `[x]` and
`[x, y]`. A guard `| condition` adds a test. A match that does not cover every value can fail at run time, and
Koka puts that in the function's type, so finish with a catch-all `_` when the other patterns are not exhaustive.
