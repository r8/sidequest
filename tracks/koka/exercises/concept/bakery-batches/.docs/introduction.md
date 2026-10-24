# Introduction

Koka has two kinds of numbers you will use every day: `int` for whole numbers and `float64` for numbers with a
fractional part.

## Integers

An `int` is a whole number of any size. It never overflows: Koka switches to a larger representation by itself
when a value outgrows a machine word, so

```koka
1_000_000 * 1_000_000 * 1_000_000   // 1000000000000000000
```

is exact. Underscores may separate digit groups, and `0x` starts a hexadecimal literal (`0xFF`).

A minus sign directly in front of a number makes a negative literal (`-5`), but Koka has no prefix minus for
other expressions: `-x` is a syntax error. Negate a name with `~x` (or `x.negate`, or `0 - x`).

Besides `+`, `-` and `*`, integers have `/` for division and `%` for the remainder. Division rounds down, so the
remainder is never negative when dividing by a positive number:

```koka
17 / 5     // 3
17 % 5     // 2
-17 / 5    // -4
-17 % 5    // 3
```

This is _Euclidean_ division, and it differs from many other languages, where `-17 / 5` is `-3` and `-17 % 5`
is `-2`. Dividing by zero does not crash: `x / 0` is `0` and `x % 0` is `x`.

`divmod(x, y)` gives both results at once as a pair, `(x / y, x % y)`. Other helpers include `abs`, `min`, `max`
and `pow` (also written `^`):

```koka
abs(-3)       // 3
min(4, 9)     // 4
pow(3, 4)     // 81
3 ^ 4         // 81
```

## Floating-point numbers

A `float64` is a 64-bit IEEE 754 floating-point number. Its literals always have a decimal point or an
exponent: `2.0`, `0.125`, `1.5e3`.

Floating-point arithmetic lives in the module `std/num/float64`, which a module must import before it can add,
compare or show floats:

```koka
import std/num/float64

fun area(width : float64, height : float64) : float64
  width * height
```

Without the import, `2.5 + 1.0` is an error saying that `+` cannot be resolved, because only the `+` for
integers and characters is in scope.

### No mixing

Koka never converts between `int` and `float64` behind your back: `2 * 1.5` is a type error. Convert explicitly
in one direction or the other.

- `.float64` turns an `int` into a `float64`: `7.float64 / 2.0` is `3.5`.
- `.int` turns a `float64` into the _nearest_ `int`: `2.7.int` is `3`. A value exactly halfway rounds to the even
  neighbour, so `2.5.int` is `2` and `3.5.int` is `4`.

To control the rounding, first round the float to a whole number and then convert it:

```koka
2.1.ceiling     // 3.0, the next whole number up
2.7.floor       // 2.0, the next whole number down
-2.7.truncate   // -2.0, the fraction dropped
2.5.round       // 2.0, the nearest, halves to even
2.1.ceiling.int // 3
```

`ceiling`, `floor`, `truncate` and `round` all return a `float64`; only `.int` gives an `int`.

### Showing floats

`show` turns a float into a string. Whole floats print without a fraction (`2.0.show` is `"2"`), and
`show(x, 2)` shows exactly two digits after the point:

```koka
show(2.0 / 3.0, 2)   // "0.67"
```

### Imprecision

Most decimal fractions cannot be stored exactly in binary, so float arithmetic is approximate:

```koka
0.1 + 0.2   // 0.30000000000000004
```

Comparing floats with `==` is therefore only safe for values that are exact in binary, such as `0.5`, `0.25` or
`0.125`. Money is usually counted in whole cents as `int` for this reason.

Dividing a float by zero gives infinity (`inf`) rather than an error. Other functions, such as `sqrt`, `abs`
and `max`, work on floats too once `std/num/float64` is imported.
