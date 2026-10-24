# About

## Representation

Every BQN number is an IEEE 754 double. Integers are exact up to `2⋆53` (`9.007199254740992e15`); beyond that,
adding `1` may change nothing. Fractions such as `0.1` are not exact, so `0.1 + 0.2` is
`0.30000000000000004`; compare fractional results with a tolerance rather than with `=`. Division by zero
gives `∞` (or `¯∞`), and `0 ÷ 0` gives `NaN`.

Literals: `¯` for a negative number (`¯2.5`), `e` or `E` for an exponent (`1.5e3`, `2e¯3`), and `∞`, `π`.
Underscores in a number are ignored, so `1_000_000` is a million.

## Floor, ceiling, minimum and maximum

`⌊` rounds towards negative infinity, so `⌊ ¯0.5` is `¯1`; to round towards zero, use the sign: there is no
truncation primitive. `⌊ 0.5 + n` rounds to the nearest whole number, halves upwards. Dyadic `⌊` and `⌈` are
the minimum and maximum; `lo ⌈ hi ⌊ n` clamps `n` between `lo` and `hi`. `∞` and `¯∞` are their identities:
`¯∞ ⌈ n` is `n`.

## Modulus

`𝕨 | 𝕩` is `𝕩 - 𝕨 × ⌊ 𝕩 ÷ 𝕨`. The result has the sign of `𝕨`, which makes it the right tool for wrapping
indices and clocks: `7 | ¯1` is `6`. It works with fractions too: `1 | 3.75` is `0.75`, the fractional part.
`2 | n` is `1` exactly when `n` is odd.

## Powers, roots and logarithms

`𝕨 ⋆ 𝕩` is the power, `⋆ 𝕩` the exponential `e⋆𝕩`. `√ 𝕩` is the square root and `n √ 𝕩` the `n`-th root.
Logarithms are written with undo (`⁼`, a later lesson): `⋆⁼ 𝕩` is the natural log and `2 ⋆⁼ 8` is `3`.

## Other arithmetic

`×` with one argument is the sign (`¯1`, `0` or `1`), and `-` and `÷` with one argument negate and take the
reciprocal. All arithmetic functions extend to lists element by element, as the lists lesson shows.
