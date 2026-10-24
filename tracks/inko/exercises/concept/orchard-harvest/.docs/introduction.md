# Introduction

Inko has two number types: `Int` for whole numbers and `Float` for numbers with a fractional part. Both are value
types: assigning or passing a number copies it.

## Integers

An `Int` is a 64-bit signed integer, from about -9.2 quintillion to 9.2 quintillion. Integer literals can use
underscores for readability, and hexadecimal or binary notation:

```inko
1_500   # => 1500
0xff    # => 255
0b101   # => 5
-42
```

The arithmetic operators are `+`, `-`, `*`, `/` (division), `%` (modulo) and `**` (power):

```inko
7 + 2   # => 9
7 * 2   # => 14
2 ** 10 # => 1024
```

Dividing two integers gives an integer: the result is rounded **down**, towards negative infinity, and `%` gives
what is left over:

```inko
7 / 2   # => 3
7 % 2   # => 1
-7 / 2  # => -4, not -3
```

`%` takes the sign of the divisor, so `-7 % 3` is `2`. When the inputs are never negative, as in this lesson,
`/` and `%` behave just like long division at school.

Dividing by zero, and an operation whose result does not fit in 64 bits, panic: the program stops with an error.

Some useful methods on `Int`:

```inko
-5.absolute # => 5
12.to_float # => 12.0
```

## Floats

A `Float` is a 64-bit floating point number. A float literal always has digits on both sides of the point, and may
use an exponent:

```inko
1.5
10.0
2.5e3 # => 2500.0
```

The same operators work on floats, and `/` keeps the fraction:

```inko
7.0 / 2.0 # => 3.5
```

Inko never converts between `Int` and `Float` behind your back. `1.5 * 2` is a compile-time error: both sides of
an operator must have the same type. Convert explicitly with `to_float` and `to_int`:

```inko
let apples = 7
let crates = 2

apples.to_float / crates.to_float # => 3.5
3.99.to_int                       # => 3, the fraction is dropped
```

To round a float, use one of:

```inko
3.7.floor    # => 3.0, rounds down
3.2.ceil     # => 4.0, rounds up
3.14159.round(2) # => 3.14, to the given number of decimals
2.5.round(0) # => 3.0, halves round away from zero
```

All three return a `Float`; follow them with `to_int` if you need an `Int`.

Floats are approximations: `0.1 + 0.2` is `0.30000000000000004`. Round the result when you need a fixed number of
decimals, and be careful comparing floats with `==`. Dividing a float by zero does not panic; it gives `Infinity`
(or `NaN` for `0.0 / 0.0`).

## Mixing operators

Remember that Inko's operators have no precedence and run from left to right. With numbers this matters a lot:

```inko
10 - 4 / 2   # => 3, because it means (10 - 4) / 2
10 - (4 / 2) # => 8
```
