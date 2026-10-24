# About

## Representation

gforth's floats are IEEE 754 doubles (64 bits): about 15 significant decimal digits, a range up to about 1.8e308, and the special values infinity and NaN.
`1e 0e f/` is infinity, not an error, and `-1e fsqrt` is NaN.
Decimal fractions such as 0.1 are not exact in binary, so compare results to within a tolerance (`f~` with a negative third argument compares relatively) instead of with exact equality.

## Literals and conversion

- A float literal needs an exponent marker: `1e`, `1.5e`, `1.5e0`, `15e-1`. When `base` is not decimal, float literals are not recognised.
- `s>f` / `f>s`, and `d>f` / `f>d` for double-cell integers.
- `f>s` truncates towards zero; round first with `fround` (to nearest, halves to even), `floor` (towards negative infinity) or `ftrunc` (towards zero, keeping a float). Rounding up is `fnegate floor fnegate`.

## The words

| Group | Words |
| --- | --- |
| arithmetic | `f+ f- f* f/ fnegate fabs fmin fmax f** fsqrt` |
| functions | `fexp fln flog fsin fcos ftan fatan2 …` |
| stack | `fdup fdrop fswap fover frot fdepth` |
| comparison | `f< f0< f0=` (standard), `f> f<= f>= f= f<>` (gforth) |
| memory | `f@ f! fvariable fconstant floats float+ faligned` |
| output | `f. fe. fs. f.s`, and `f>str-rdp` for a formatted string |

## Arrays of floats

`floats` is the float version of `cells`: `create samples 10 floats allot`, then `samples 3 floats + f@`.
gforth needs float addresses to be float-aligned; `falign` before `allot` and `faligned` on computed addresses take care of it.

## Style

Classic Forth avoids floating point where integers will do, scaling with `*/` instead (prices in cents, distances in millimetres).
Floats are the right tool for geometry, physics and anything with a wide range of magnitudes.
Keeping floats on their own stack means a word's integer and float arguments do not have to be shuffled past each other.
