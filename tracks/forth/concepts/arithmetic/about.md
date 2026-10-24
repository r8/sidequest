# About

## Single-cell arithmetic

| Word | Stack effect | Notes |
| --- | --- | --- |
| `+ - *` | `( a b -- c )` | wrap around silently on overflow |
| `/` | `( a b -- a/b )` | integer quotient; division by zero throws -10 |
| `mod` | `( a b -- rem )` | remainder |
| `/mod` | `( a b -- rem quot )` | both at once |
| `*/` | `( a b c -- a*b/c )` | double-width intermediate product |
| `*/mod` | `( a b c -- rem quot )` | the same, with the remainder |
| `negate abs` | `( n -- n' )` | |
| `min max` | `( a b -- c )` | |
| `1+ 1- 2* 2/` | `( n -- n' )` | `2/` is an arithmetic shift, so it rounds towards negative infinity |

## Rounding

The Forth standard leaves it to the system whether `/` rounds towards zero (symmetric) or towards negative infinity (floored).
gforth 0.7.3 floors: `-7 2 /` is -4 and `-7 2 mod` is 1, so the remainder always has the divisor's sign.
`sm/rem` and `fm/mod` choose explicitly, but take a double-cell dividend (see the double-cells concept).
With non-negative operands, as in most exercises, the two agree.

Rounding a quotient up is `a b 1- + b /` for positive numbers; rounding to the nearest is `a b 2/ + b /`.

## Scaling with `*/`

Forth traditionally avoids floating point by scaling: to take 37.5% of `n`, write `n 375 1000 */`.
Because `*/` keeps `n*375` at double width before dividing, it does not overflow where `n 375 * 1000 /` would.

## Overflow

Cells wrap around: `9223372036854775807 1+` is the most negative number, with no error.
Unsigned words (`u<`, `u.`, `um*`) treat the same bits as non-negative values.
