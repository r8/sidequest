# About

## Layout

A double on the stack is `( lo hi )`, the high cell on top; in memory (`2@`, `2!`, `2variable`) the high cell is at the lower address.
The sign of a signed double is the sign of its high cell, so `s>d` is "push 0, or -1 if the number is negative" — `dup 0<`.
An unsigned single becomes an unsigned double by pushing 0 above it.

## The words

| Group | Words |
| --- | --- |
| arithmetic | `d+ d- dnegate dabs d2* d2/ dmax dmin` |
| comparison | `d< d= d0< d0= du<` |
| conversion | `s>d d>s` |
| mixed | `m* um* m+ m*/ um/mod sm/rem fm/mod ud/mod` |
| memory | `2@ 2! 2variable 2constant 2literal` |
| output | `d. ud. d.r` and pictured output (`<# #s #>` work on doubles) |

There is no `d*` or `d/` in the standard; `m*/` and `ud/mod` (gforth) cover most needs.

## Division

`um/mod ( ud u -- urem uquot )` is the primitive; `sm/rem` rounds towards zero and `fm/mod` towards negative infinity, both for signed doubles.
All three need the quotient to fit in a single cell; a quotient that does not fit is an error (or a wrong answer, depending on the system).
`/`, `mod` and `*/` are defined in terms of them, which is why `*/` keeps its intermediate product as a double.

## Where doubles show up

- Fixed-point arithmetic: amounts in thousandths, scaled with `*/` and `m*/`, the traditional Forth alternative to floats.
- Pictured numeric output: `<# #s #>` take a double, so a single is converted with `s>d` (or `0` for an unsigned one) first.
- `>number` parses into an unsigned double.
- Results that overflow a cell, such as the full product of two cells.

On a 64-bit system singles are already large, so doubles appear less often than on the 16-bit machines Forth grew up on; the conventions, though, are everywhere.
