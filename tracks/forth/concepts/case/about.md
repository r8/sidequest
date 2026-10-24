# About

## How `case` works

`case`, `of`, `endof` and `endcase` are compile-time words that build an ordinary chain of tests:

| Word | Run-time stack effect | |
| --- | --- | --- |
| `case` | `( -- )` | marks the start |
| `of` | `( x1 x2 -- \| x1 )` | equal: drop both and run the branch; otherwise keep `x1` and skip it |
| `endof` | `( -- )` | jump to after `endcase` |
| `endcase` | `( x -- )` | drop the selector (reached only from the default) |

So `n 3 of … endof` is just `n dup 3 = if drop … else`, and the whole structure is a nested `if … else … then` written flat.

## The default

The default branch is everything between the last `endof` and `endcase`.
It sees the selector on top, and `endcase` drops whatever is on top when it is reached.
Results therefore go under the selector:

- `0 swap` for a constant result;
- `dup f swap` for one computed from the selector;
- `nip` first to get rid of an item below the selector the default does not need.

A default that leaves nothing, or `drop` and then something, is a common bug: `drop 0` leaves a 0 that `endcase` then drops, and the word returns nothing.

## Ranges and other conditions

The standard `of` tests equality only.
gforth 0.7.3 has no range `of`; write a range as comparisons and `if`, test it in the default, or compute the result arithmetically.
Newer gforth versions add `?of ( flag -- )`, which runs the branch when a flag is true.

## Style

- Line the branches up so each `of` reads as a row of a table.
- When all branches are just "value maps to value", a table in memory (see the arrays concept) can be shorter than a `case`.
- Every branch must have the same stack effect, as with `if … else … then`.
