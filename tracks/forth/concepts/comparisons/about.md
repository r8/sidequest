# About

## The words

| Word | Stack effect | Standard |
| --- | --- | --- |
| `= <> < >` | `( n1 n2 -- flag )` | core (`<>` core extension) |
| `<= >=` | `( n1 n2 -- flag )` | gforth, not standard: portable code writes `> 0=` and `< 0=` |
| `0= 0< 0<> 0>` | `( n -- flag )` | core / core extension |
| `u< u>` | `( u1 u2 -- flag )` | unsigned comparison |
| `within` | `( n lo hi -- flag )` | core extension |
| `min max` | `( n1 n2 -- n3 )` | often replace a comparison and a branch |

## Signed and unsigned

`<` compares cells as signed numbers; `u<` as unsigned ones, so `-1 1 u<` is false (`-1` is the largest unsigned cell).
Addresses and sizes are unsigned; counts and measurements usually signed.

## `within`

`within` is usually defined as `over - >r - r> u<`: it subtracts the lower bound and compares unsigned.
That makes it work for signed and unsigned ranges alike, and even for ranges that wrap around, as long as `lo` and `hi` are given in the right order.
When `lo` equals `hi`, the range is empty.

## Clamping and ranges

A value outside a range is often clamped rather than rejected: `lo max hi min` clamps `n` into `lo..hi`.
That needs no flag at all.

## Comparing several things

Comparisons combine with `and` and `or`.
Arrange the stack so each comparison has its own copy: `dup 0> swap 100 < and` checks `0 < n < 100`, and `1 100 within` says the same in one word.
