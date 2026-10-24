# Introduction

So far every number has lived on the stack, and disappeared once a word used it up.
A program that must remember something between calls — a balance, a setting, a high score — stores it in memory, under a name.

## Variables

`variable` creates a named cell of memory:

```forth
variable score
```

`score` does not push the score: it pushes the _address_ of the cell.
Two words move numbers between the stack and an address:

| Word | Stack effect       | Meaning                            |
| ---- | ------------------ | ---------------------------------- |
| `!`  | `( x addr -- )`    | "store": write `x` into the cell   |
| `@`  | `( addr -- x )`    | "fetch": read the cell             |
| `+!` | `( n addr -- )`    | add `n` to the cell                |
| `?`  | `( addr -- )`      | print the cell (for interactive use) |

```forth
variable score
0 score !        \ score is 0
10 score +!      \ score is 10
score @ 2 * .    \ prints 20
score ?          \ prints 10
```

Read `score !` as "store into score" and `score @` as "score's value".
The value comes first and the address second, so `!` and `+!` read like the arithmetic words: `10 score +!`.

`variable` is used at the top level of a file, not inside a definition.
Words defined afterwards use it like any other word:

```forth
variable visits
: visit ( -- ) 1 visits +! ;
: visits? ( -- n ) visits @ ;
```

Do not rely on a new variable holding zero: store a starting value before using it, or give the program a word that resets it.

## Constants

A number that never changes gets a name with `constant`:

```forth
60 constant minutes-per-hour
: hours>minutes ( h -- m ) minutes-per-hour * ;
```

`constant` takes the number from the stack when the definition is made; afterwards the name pushes that number itself, not an address.
Constants make code read as what it means, and put every "magic number" in one place.

## Values

A `value` is between the two: it pushes its number like a constant, but it can be changed with `to`:

```forth
100 value speed-limit
speed-limit .      \ prints 100
80 to speed-limit
speed-limit .      \ prints 80

: slow-zone ( -- ) 30 to speed-limit ;
```

`to name` takes the new number from the stack; it works at the top level and inside definitions.
A value suits a setting that is read often and changed rarely; a variable suits a number that is updated in place, especially with `+!`.

## Choosing

| | pushes | change with |
| --- | --- | --- |
| `constant` | its number | (never) |
| `value` | its number | `n to name` |
| `variable` | an address | `n name !`, `n name +!` |

## Pitfalls

- **Forgetting `@`.** `score 1+` adds one to the address, not to the score; `score @ 1+` is what you mean.
- **Order of `!`.** It is `value address !`. `score 5 !` tries to store the address into cell number 5, which fails or corrupts memory.
- **`@` on a constant or value.** They already push their number; fetching from it treats the number as an address.
- **State between calls.** Because variables remember, one call can affect the next. The tests start from a known state by calling the word that resets it first.
