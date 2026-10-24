# Introduction

Janet has one everyday number type: every number you write, `3` or `2.5`, is a 64-bit floating-point number (a _double_), the same kind JavaScript and Lua use.
Numbers without a fractional part behave like integers, and Janet prints them without a decimal point.

```janet
(type 3)     # => :number
(type 2.5)   # => :number
(= 2 2.0)    # => true, they are the same number
```

A double holds every integer up to 2^53 exactly, which is plenty for counting apples.
(For the rare program that needs exact 64-bit integers, the `int/s64` and `int/u64` types exist; this lesson does not need them.)

## Writing numbers

```janet
42          # an integer
-7          # a negative number
3.25        # a fractional number
1e3         # 1000, scientific notation
1_000_000   # underscores may separate digits
0xff        # 255, hexadecimal
```

## Arithmetic

`+`, `-` and `*` work as you would expect and take any number of arguments.
Division is where newcomers stumble: `/` always divides exactly, so it can produce a fraction even from two integers.

```janet
(/ 10 4)     # => 2.5
(/ 12 4)     # => 3
(/ 1 3)      # => 0.333333333333333
```

For whole-number division there are separate functions:

```janet
(div 17 5)   # => 3, the quotient rounded down
(mod 17 5)   # => 2, the remainder
(% 17 5)     # => 2, also the remainder
```

`mod` and `%` differ only for negative numbers: `mod` takes the sign of the divisor and `%` the sign of the dividend, so `(mod -7 2)` is `1` while `(% -7 2)` is `-1`.

## Rounding

The `math` module has the rounding functions.
Each returns a number with no fractional part.

```janet
(math/floor 3.7)   # => 3, down
(math/ceil 3.2)    # => 4, up
(math/round 3.5)   # => 4, to the nearest, halves away from zero
(math/trunc -3.7)  # => -3, towards zero
```

To round to a number of decimal places, scale the number up, round it and scale it back down: for one decimal place, multiply by 10 before rounding and divide by 10 after.

## Other useful functions

```janet
(inc 5)            # => 6
(dec 5)            # => 4
(math/abs -3)      # => 3
(max 4 9 2)        # => 9
(min 4 9 2)        # => 2
(math/pow 2 10)    # => 1024
(math/sqrt 16)     # => 4
math/pi            # => 3.14159265358979
```

## Comparing numbers

`=`, `<`, `>`, `<=` and `>=` compare numbers.
Like arithmetic, they take any number of arguments, which reads naturally for ranges:

```janet
(< 1 2)         # => true
(< 1 5 3)       # => false, the arguments must be in increasing order
(<= 0 7 10)     # => true, 7 is between 0 and 10
(not= 1 2)      # => true
```

## Pitfalls

- `/` never rounds. If you want a count of whole things, use `div`, or round the result yourself.
- Floating-point numbers are binary fractions, so some decimals are not exact: `(+ 0.1 0.2)` is `0.30000000000000004`, which is not `=` to `0.3`, even though Janet prints it as `0.3`.
- Dividing by zero is not an error: `(/ 1 0)` is `inf` and `(/ 0 0)` is `nan`.
