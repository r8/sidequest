# About

## The words

| Word | Stack effect | Notes |
| --- | --- | --- |
| `and or xor` | `( x1 x2 -- x3 )` | bit by bit |
| `invert` | `( x -- x' )` | ones' complement; `negate` is `invert 1+` |
| `lshift` | `( x u -- x' )` | shifts in zeros; `u` must be less than the cell width |
| `rshift` | `( x u -- x' )` | logical: shifts in zeros, so negative numbers become large positive ones |
| `2*` `2/` | `( x -- x' )` | one place; `2/` is arithmetic and keeps the sign |
| `0<>` `0=` | `( x -- flag )` | turn a masked value into a well-formed flag |

## Literals

gforth reads `%` as binary, `$` as hexadecimal (also `0x`), `&` and `#` as decimal, whatever `base` is.
`%`, `$` and `#` are Forth 2012 standard; `&` and `0x` are gforth's own.
The number-bases concept covers `base`, `hex` and `decimal` for printing.

## Idioms

- Bit `n` of `x`: `x n rshift 1 and` gives 0 or 1, handy for counting; `x 1 n lshift and 0<>` gives a flag.
- The lowest set bit: `x dup negate and`.
- Clearing the lowest set bit: `x dup 1- and` — repeating it until zero counts the set bits in as many steps as there are ones.
- A mask of the low `n` bits: `1 n lshift 1-`.
- Several bits at once: `%0110 or` sets two; the bits of a mask can be named with constants (`1 constant bold  2 constant italic`) and combined with `or`.

## Flags and bits

A well-formed flag is 0 or -1 (every bit set), so `and`, `or` and `xor` on flags behave like the logical operators.
A merely non-zero value is true to `if` but may not survive `and`: `4 2 and` is 0 although both are "true".
Convert with `0<>` before combining values that are not flags.
