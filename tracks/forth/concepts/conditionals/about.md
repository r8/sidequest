# About

## The words

| Word | Stack effect | |
| --- | --- | --- |
| `if` | `( flag -- )` | compile-only: starts a conditional |
| `else` | `( -- )` | the false branch |
| `then` | `( -- )` | ends the conditional (gforth also accepts `endif`) |
| `exit` | `( -- )` | return from the current word |
| `?dup` | `( n -- n n \| 0 )` | duplicate if non-zero |
| `?exit` | `( flag -- )` | gforth: `if exit then` in one word |

## Stack discipline

A conditional is easiest to get right when both branches have the same stack effect.
Write the stack at `if`, at `else`, and at `then` as comments while learning:

```forth
: describe ( n -- n' )
  dup 0< if      \ n
    negate       \ -n
  else           \ n
    2*           \ 2n
  then ;         \ n'
```

A word whose stack effect depends on the data (`( n -- n | )`) is legal, but its caller then has to branch the same way; `?dup` is the one common example.

## Guard clauses

Several `if … exit then` lines in a row read like a decision table and avoid deep nesting.
Every early path must leave the word's documented stack effect, so drop what it does not return.
`exit` cannot be used inside a counted loop without `unloop` first (see the counted-loops concept).

## Avoiding branches

Many conditionals pick between values and can be written without one:

- `min`, `max`, and `lo max hi min` for clamping;
- `n flag and` is `n` or `0`;
- `flag negate` is `1` or `0`, `flag +` subtracts one when true.

Branch-free code is not always clearer; use whichever reads better.

## Compile-only

`if`, `else` and `then` are _compile-time_ words: they build the branch while the definition is compiled, so they work only inside `:` … `;`.
At the top level of a file, gforth's `[if] … [else] … [then]` does conditional interpretation instead.
