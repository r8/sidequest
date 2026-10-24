# About

## The import

Floating-point support is a library, `std/num/float64`. The type `float64` and its literals are always
available, but `+`, `*`, `<`, `==`, `show` and the rest are defined in that module. A module that does float
arithmetic without importing it gets errors such as "identifier (+) cannot be resolved", because only the
integer and character versions of `+` are in scope. Every module that uses the operations needs its own import —
including a test file that compares floats.

## Literals

A float literal needs a decimal point or an exponent: `2.0`, `0.125`, `1.5e3` (1500), `1e-3`. `2` is always an
`int`, and there is no automatic conversion: `2 * 1.5` is a type error.

## Converting

| from | to | how | example |
| --- | --- | --- | --- |
| `int` | `float64` | `.float64` | `7.float64 == 7.0` |
| `float64` | `int` | `.int` (nearest, halves to even) | `2.7.int == 3`, `2.5.int == 2` |
| `float64` | whole `float64` | `floor`, `ceiling`, `truncate`, `round` | `2.1.ceiling == 3.0` |
| `string` | `float64` | `parse-float64` (a `maybe`) | `parse-float64("2.5") == Just(2.5)` |

So rounding down, up or towards zero to an `int` is two steps: `x.floor.int`, `x.ceiling.int`, `x.truncate.int`.

## Showing

`show` gives enough digits (up to 17 significant ones) to read back as the same number, without trailing zeros
or a `.0` for whole values: `2.0.show == "2"`, `12.5.show == "12.5"`. `show(x, d)` (or `x.show-fixed(d)`) shows exactly `d` digits
after the point: `show(2.0 / 3.0, 2) == "0.67"`.

## Precision

Floats are binary fractions with 53 bits of precision. Values such as `0.1` cannot be stored exactly, so results
pick up tiny errors: `0.1 + 0.2` is `0.30000000000000004`. Compare floats with `==` only when the values are exact
in binary (halves, quarters, eighths, whole numbers in range), or compare within a tolerance:
`abs(x - y) < 1e-9`. Quantities that must be exact, like money, are better counted in whole units as `int`.

## Special values

Dividing by zero gives infinity (`1.0 / 0.0` shows as `inf`), and undefined results such as `0.0 / 0.0` are
NaN (`nan`, tested with `is-nan`). Neither is an error, and NaN is not equal to anything, itself included.

## More functions

`std/num/float64` also has `sqrt`, `abs`, `min`, `max`, `pi`, `exp`, `ln`, trigonometry, and more.
