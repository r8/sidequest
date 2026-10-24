# About

## Patterns

| Pattern | Matches |
| --- | --- |
| `0`, `"north"`, `'x'` | exactly that literal |
| `n` | anything, and binds it to `n` |
| `_` | anything, binding nothing |
| `(p1, p2)` | a tuple whose parts match `p1` and `p2` |
| `Nil` or `[]` | the empty list |
| `Cons(p1, p2)` | a non-empty list: head `p1`, tail `p2` |
| `[p1, p2]` | a list of exactly two elements |
| `Just(p)`, `Nothing`, … | the constructors of any data type (later lessons) |
| `name as p` | whatever `p` matches, binding the whole value to `name` as well |

Patterns nest: `Cons(a, Cons(b, _))` matches a list of at least two elements and names the first two.

## Guards

`pattern | condition -> …` chooses the branch only when the condition holds; otherwise matching goes on with the
next line. Several lines may share the same pattern with different guards.

## Order and coverage

Branches are tried top to bottom, so specific patterns go before general ones; a pattern that can never be
reached because an earlier one catches everything is a mistake the compiler may point out.

When no branch fits, the program fails with a pattern-match exception. Koka is honest about it: a function
with an incomplete `match` has the `exn` effect in its type, and a function annotated as total (`: string`) is
rejected. Matching on a type with a fixed set of constructors, such as `list` or `bool`, is complete once every
constructor is covered; numbers and strings have endless values, so they always need a final `_` or name.

## Unused names

A name in a pattern that the branch never uses gets a warning ("pattern variable x is unused"). Write `_`, or a
name starting with an underscore such as `_rest`, for the parts you mean to ignore.

## Matching in other places

Patterns also appear in `val (a, b) = …` and in parameters `fun f((x, y) : (int, int))`. Those must be
irrefutable — always fit — which tuple patterns of names are.
