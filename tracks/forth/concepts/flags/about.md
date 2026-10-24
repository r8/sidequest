# About

## Well-formed flags

The standard defines a flag as a cell that is either all bits clear (false) or all bits set (true).
Every standard word that returns a flag returns a well-formed one, and every word that _consumes_ a flag (`if`, `until`, `while` in later lessons) treats any non-zero cell as true.

That asymmetry is the source of most flag bugs:

- `1 2 and` is `0`: both are "true" to `if`, but their bitwise `and` is false.
- `1 invert` is `-2`, still "true".

Normalise a value to a flag with `0<>` (or `0= 0=`) before combining it with `and`, `or` or `invert`.

## Flags as numbers

A well-formed flag is a mask, which makes branch-free code easy:

| Idiom | Meaning |
| --- | --- |
| `flag negate` | `1` or `0` |
| `flag and` | `n flag and` is `n` when true, `0` when false |
| `flag +` | subtract one when true |
| `f1 f2 + f3 + negate` | how many of three are true |

`n flag and` selects without a conditional: `price member? 10 and -` takes 10 off for members.

## Names

The convention is a trailing `?` for words that leave a flag: `even?`, `empty?`, `may-ride?`.
`true` and `false` are constants in gforth and in Forth 2012 (core extension).

## Logical versus bitwise

Forth has no separate short-circuit `&&` or `||`: both sides are always computed.
When the second test is expensive or unsafe (dividing by a number that may be zero), use a conditional instead (see the conditionals concept).
