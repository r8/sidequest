# Introduction

## When one cell is not enough

A cell in gforth is 64 bits, so a single number reaches a little over nine quintillion (9 223 372 036 854 775 807).
That is a lot, but not everything: the distance to another galaxy in kilometres, or the product of two large numbers, does not fit.
When a number needs more room, Forth uses two cells for it: a _double-cell number_, or _double_ for short, with twice the range (about 1.7 × 10³⁸ in gforth).

A double occupies two places on the data stack, the low-order cell below and the high-order cell on top.
Stack-effect comments write it as `d` (or `ud` when it is unsigned), and it counts as one argument even though it is two cells.

## Writing doubles

A number written with a dot in it is a double literal:

```forth
1.        \ the double 1: cells 1 and 0
1000000.  \ the double one million
24001873208937997000.   \ too big for one cell, fine for two
```

The dot can be anywhere (`1.000.000` is one million too), but the convention is to put it at the end.
This is why a float literal needs its `e`: `1.5` is the double fifteen.

`d.` prints a double, and `s>d` turns a single into a double with the same value (it extends the sign into the high cell).
`d>s` goes the other way, keeping only the low cell, so it is only right when the value fits.

## Double arithmetic

Most single-cell words have a double twin with a `d` in front, taking doubles where the single word takes cells:

| Word | Stack effect |
| --- | --- |
| `d+ d-` | `( d1 d2 -- d3 )` |
| `dnegate dabs` | `( d -- d' )` |
| `d2* d2/` | `( d -- d' )` |
| `d< d=` | `( d1 d2 -- flag )` |
| `d0= d0<` | `( d -- flag )` |
| `2dup 2drop 2swap 2over` | shuffle doubles as pairs |

`2constant`, `2variable`, `2@` and `2!` name and store them:

```forth
384400. 2constant to-the-moon     \ km
to-the-moon 2dup d+ d.            \ prints 768800
```

## Mixed precision

Some of the most useful words mix singles and doubles.
They are how Forth multiplies and divides big numbers without losing digits:

| Word | Stack effect | |
| --- | --- | --- |
| `m*` | `( n1 n2 -- d )` | the full product of two singles |
| `um*` | `( u1 u2 -- ud )` | the same, unsigned |
| `m+` | `( d n -- d' )` | add a single to a double |
| `m*/` | `( d n1 n2 -- d' )` | multiply a double by `n1/n2`, with a triple-width intermediate |
| `um/mod` | `( ud u -- urem uquot )` | divide an unsigned double by a single |
| `*/` | `( n1 n2 n3 -- n4 )` | `n1*n2/n3`, with the product kept as a double |

```forth
3000000000 4000000000 m* d.    \ prints 12000000000000000000
1000000. 3 4 m*/ d.            \ prints 750000
12000000000000000000. 1000 um/mod . .   \ prints 12000000000000000 0
```

`um/mod` leaves the quotient on top and the remainder below; the quotient has to fit in one cell.

## Pitfalls

- **Two cells, one value.** A double is moved with `2dup`, `2swap` and `2drop`; `dup` or `swap` would split it.
- **Single or double?** Passing a single where a double is expected (or the other way round) silently uses the wrong cells. `s>d` converts; a literal with a dot is already a double.
- **Order of the cells.** The high cell is on top. To read a double from two separate cells, push the low one first.
- **Plain `*` overflows.** `n1 n2 *` keeps only the low 64 bits of the product, without warning; use `m*` when the product may not fit.
