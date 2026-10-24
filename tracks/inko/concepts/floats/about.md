# About

`Float` is an IEEE 754 64-bit floating point number, and a value type like `Int`.

## Literals and conversion

```inko
1.5
-0.25
1.0e-3
Float.infinity
Float.not_a_number
```

A literal needs a digit before and after the point: `.5` and `5.` are not floats. There is no implicit conversion
between `Int` and `Float`, in arithmetic or in comparisons; `to_float` and `to_int` convert explicitly, and
`to_int` truncates towards zero (`-3.7.to_int` is `-3`). `Float.parse('2.5')` returns an `Option[Float]`.

## Arithmetic

`+`, `-`, `*`, `/` and `%` take another `Float`; `**` takes an `Int` exponent (`2.0 ** 3` is `8.0`). Division by
zero produces `Infinity`, `-Infinity` or `NaN` instead of panicking; check with `infinite?` and `not_a_number?`.

## Rounding

| Method | Result for `2.5` | Result for `-2.5` |
| --- | --- | --- |
| `floor` | `2.0` | `-3.0` |
| `ceil` | `3.0` | `-2.0` |
| `round(0)` | `3.0` | `-3.0` |
| `to_int` | `2` | `-2` |

`round(decimals)` rounds halves away from zero; `round(2)` keeps two decimals. `fractional` returns the part after
the point, and `absolute` drops the sign.

## Precision

Most decimal fractions have no exact binary representation, so results such as `0.1 + 0.2` come out as
`0.30000000000000004`. Round results before showing or comparing them, keep money in whole cents as an `Int` where
you can, and remember that `NaN` is not equal to anything, itself included. Floats can't be used in `match`
patterns for the same reason.
