# About

## Values and operators

`bool` is an ordinary data type in Koka's standard library with two constructors, `True` and `False` — which is
why they are capitalised. Its operators:

| operator | meaning | note |
| --- | --- | --- |
| `a && b` | and | `b` is evaluated only if `a` is `True` |
| `a \|\| b` | or | `b` is evaluated only if `a` is `False` |
| `!a`, `not(a)` | not | |
| `xor(a, b)` | exclusive or | |
| `a == b`, `a != b` | equal, different | `a != b` is also exclusive or |

Precedence from tight to loose: `!`, the comparisons, `&&`, `||`. So `x > 0 || y > 0 && z > 0` means
`x > 0 || (y > 0 && z > 0)`; parentheses make such mixes readable.

## Short-circuiting

Because the right side of `&&` and `||` may not run, a cheap or guarding test belongs on the left:
`n != 0 && total / n > 3` never divides by zero. The right side is still type-checked; it is only not evaluated.

## Comparisons

`==`, `!=`, `<`, `<=`, `>`, `>=` exist for the built-in types — `int`, `float64` (with its import), `char`,
`string` and `bool` itself (where `False < True`). Koka's comparison operators are non-associative, so
`a < b < c` is rejected with "Ambigious non-associative operator"; write `a < b && b < c`.

Types you define do not get `==` for free; a later lesson shows how to write it.

## No truthiness

Only a `bool` can be a condition. `if n then …` with `n : int` is a type error, and so is `if name then …` for a
string. Compare explicitly: `n != 0`, `name != ""`.

## Converting

`b.show` gives `"True"` or `"False"`, and `b.int` gives `1` or `0`.

## Style

Return a condition directly instead of wrapping it: a body of `age >= 18` rather than
`if age >= 18 then True else False`. Prefer positive names (`is-open`, not `is-not-closed`) so that `!` reads
naturally.
