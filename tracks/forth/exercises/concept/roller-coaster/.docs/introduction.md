# Introduction

## Flags

Forth has no separate boolean type.
A _flag_ is an ordinary cell on the data stack: `0` means false, and any other value counts as true.
The comparison words always leave a _well-formed_ flag: `0` for false and `-1` for true, a cell with every bit set.
gforth names them `false` and `true`:

```forth
true .    \ prints -1
false .   \ prints 0
```

## Comparisons

The comparison words take two numbers and leave a flag.
Like the arithmetic words, they read in written order: `a b <` asks "is `a` less than `b`?".

| Word | Stack effect          | True when               |
| ---- | --------------------- | ----------------------- |
| `=`  | `( a b -- flag )`     | `a` equals `b`          |
| `<>` | `( a b -- flag )`     | `a` differs from `b`    |
| `<`  | `( a b -- flag )`     | `a` is less than `b`    |
| `>`  | `( a b -- flag )`     | `a` is greater than `b` |
| `<=` | `( a b -- flag )`     | `a` is at most `b`      |
| `>=` | `( a b -- flag )`     | `a` is at least `b`     |

Comparing with zero is so common that it has its own words: `0=`, `0<>`, `0<` and `0>` take one number.

```forth
3 5 < .     \ prints -1
3 5 > .     \ prints 0
7 7 >= .    \ prints -1
-4 0< .     \ prints -1
```

`within ( n lo hi -- flag )` is true when `lo <= n < hi`.
The lower bound is included and the upper bound is not:

```forth
5 1 10 within .    \ -1
10 1 10 within .   \ 0: 10 is not below 10
```

To test a range that includes its upper end, pass one more than it as `hi`.

## Combining flags

`and`, `or`, `xor` and `invert` work bit by bit on whole cells.
Because a well-formed true has every bit set, they work as logical operators on flags:

```forth
true false and .   \ 0
true false or .    \ -1
true true xor .    \ 0
true invert .      \ 0
```

A word that checks two conditions computes both flags and combines them.
Shuffle the stack so that each comparison gets its own copy of the number it needs:

```forth
: teenager? ( age -- flag )
  dup 13 >= swap 20 < and ;
```

`0=` also negates a flag, and it works whatever non-zero value the "true" is, where `invert` only works on well-formed flags.

## Flags are numbers

Because true is `-1`, a flag can be used in arithmetic.
`negate` turns a well-formed flag into `1` or `0`, and adding flags counts the true ones, negatively:

```forth
true true false + + .   \ prints -2
```

That is often handier than a conditional, which comes in a later lesson.

## Pitfalls

- **Operand order.** `5 3 <` is false: it asks whether 5 is less than 3.
- **`within` excludes its upper bound.** A range from 1 to 10 inclusive is `1 11 within`.
- **`invert` on a non-flag.** `invert` of `1` is `-2`, which is still "true". Use `0=` when a value may be any non-zero number.
- **`and` on non-flags.** `1 2 and` is `0`, even though both are "true". Combine only well-formed flags with `and`, or turn a number into a flag first with `0<>`.
