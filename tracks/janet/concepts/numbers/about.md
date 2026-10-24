# About

## One number type

Janet's `:number` type is an IEEE 754 double.
Integers are simply doubles with no fractional part, so there is no separate integer type to convert to or from, and `(= 3 3.0)` is `true`.
Every integer between -2^53 and 2^53 is represented exactly; beyond that, doubles skip integers.
For exact 64-bit arithmetic, the core library has boxed integers, `int/s64` and `int/u64`, with their own arithmetic.

`int?` tells whether a number is a whole number in the 32-bit range, `nat?` whether it is a non-negative one, and `number?` whether a value is a number at all.

## Literals

```janet
42  -7  3.25  1e3  1_000_000
0xff      # hexadecimal
2r1011    # radix notation: base 2, here 11
36rZZ     # any base up to 36
```

## Division

| Expression | Result | Meaning |
| --- | --- | --- |
| `(/ 7 2)` | `3.5` | exact division |
| `(div 7 2)` | `3` | floored quotient |
| `(mod 7 2)` | `1` | remainder with the sign of the divisor |
| `(% 7 2)` | `1` | remainder with the sign of the dividend |
| `(/ 2)` | `0.5` | the reciprocal |

For negative operands the difference shows: `(div -7 2)` is `-4`, `(mod -7 2)` is `1`, `(% -7 2)` is `-1`.

Dividing by zero is not an error: `(/ 1 0)` is `inf`, `(/ -1 0)` is `-inf` and `(/ 0 0)` is `nan`, which `nan?` detects and which is not equal to anything, itself included.

## Rounding

`math/floor` and `math/ceil` round down and up, `math/trunc` towards zero, and `math/round` to the nearest whole number with halves away from zero (`(math/round 2.5)` is `3`, `(math/round -2.5)` is `-3`).
Rounding to a number of decimals is done by scaling: `(/ (math/round (* x 100)) 100)`.

## Floating-point surprises

Decimal fractions are approximated in binary, so `(+ 0.1 0.2)` is `0.30000000000000004` and not equal to `0.3`.
Janet's printer shows numbers with 15 significant digits, so the difference is invisible when printed; compare with a tolerance (`(< (math/abs (- a b)) 1e-9)`) when it matters, or keep amounts of money in whole cents.

## Useful functions

`inc`, `dec`, `max`, `min`, `math/abs`, `math/pow`, `math/sqrt`, `math/log`, `math/exp`, the trigonometric functions, the constants `math/pi`, `math/e` and `math/inf`, and the predicates `zero?`, `pos?`, `neg?`, `even?` and `odd?`.
`math/random` returns a number in `[0, 1)`, and `math/rng` makes a seeded generator.

## Comparisons

`=`, `<`, `>`, `<=`, `>=` and `not=` are variadic: `(< a b c)` is true when the arguments strictly increase.
`compare` returns `-1`, `0` or `1`, which sorting uses.
