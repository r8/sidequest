# About

## Patterns

| pattern | matches | binds |
| --- | --- | --- |
| `42`, `"hi"`, `:ok`, `true`, `nil` | an equal value | nothing |
| `name` | anything | `name` |
| `_` | anything | nothing |
| `[p1 p2]` | an array or tuple with at least two elements matching `p1` and `p2` | what `p1`, `p2` bind |
| `[p1 & rest]` | an array or tuple with at least one element | `rest` to a tuple of the remaining elements |
| `{:k p}` | a struct or table whose `:k` is non-nil and matches `p` | what `p` binds |
| `(p cond …)` | what `p` matches, when every `cond` is truthy | what `p` binds, visible in the conditions |
| `(@ name)` | a value equal to the current value of `name` | nothing |

Patterns nest to any depth: `[:move {:x x :y y}]`, `{:to {:city (c (string? c))}}`.

A string is not an indexed collection for `match`: `[a]` does not match `"abc"`.

## Evaluation

`match` evaluates its subject once, then tries the cases top to bottom.
The result expression of the first matching case is evaluated and returned.
If the number of forms after the subject is odd, the last one is a default returned when no case matches; otherwise the default is `nil`.
A final `_` case is the clearer way to write it.

## Prefix matching

Bracket patterns check a minimum length, not an exact one.
`[:rect w h]` matches `[:rect 2 5 9]`, and `[:fragile]` matches `[:fragile "glass"]`.
To distinguish shapes of different lengths, list the longer pattern first, or use a guard that checks `length` or `empty?` on a `& rest` binding.

Struct patterns likewise ignore extra keys, and since a key mapped to `nil` is absent, `{:k _}` is a way to require that `:k` is present.

## Guards

A parenthesised pattern is a guard: `(x (> x 0) (< x 10))` matches a number between 1 and 9.
The conditions run only after the inner pattern has matched, with its names bound, so they can use them freely.
A guard may wrap a bracket or struct pattern — `([a b] (< a b))` — or appear inside one: `[:letter (g (<= g 20))]`.

## `match` and other branching

- Use `case` when you only compare a value with constants: it is simpler and says so.
- Use `cond` when the conditions are unrelated tests.
- Use `match` when the value's _shape_ decides — tagged tuples, records with optional fields, nested data — and you want the parts bound as names in the same step.

Tagged tuples (`[:ok value]`, `[:error message]`) and `match` are a common pairing in Janet for results that can be one of several kinds.
