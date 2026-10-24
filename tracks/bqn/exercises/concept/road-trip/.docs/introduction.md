# Introduction

## One kind of number

BQN has a single number type: every number is a double-precision floating-point value, so whole numbers and
fractions mix freely. Division always gives the exact quotient, never a rounded one:

```bqn
7 ÷ 2      # 3.5
1 ÷ 3      # 0.3333333333333333
```

Whole numbers are exact up to about nine thousand million million (`2⋆53`). Fractions are not always exact,
as in every language with floats: `0.1 + 0.2` is `0.30000000000000004`. Infinity is written `∞` (and `¯∞`),
and `π` is a number too.

## Rounding: floor and ceiling

`⌊` (floor) rounds down to a whole number and `⌈` (ceiling) rounds up. "Down" means towards negative infinity,
not towards zero:

```bqn
⌊ 3.7      # 3
⌈ 3.2      # 4
⌊ ¯3.2     # ¯4
⌊ 7 ÷ 2    # 3: whole-number division
```

## Minimum and maximum

The same two symbols with a left argument give the smaller (`⌊`) or larger (`⌈`) of two numbers:

```bqn
3 ⌊ 8      # 3
3 ⌈ 8      # 8
0 ⌈ ¯4     # 0: a common way to say "never below zero"
```

## Absolute value and modulus

`|` with one argument is the absolute value. With two, it is the remainder after division, the modulus:

```bqn
| ¯5       # 5
3 | 10     # 1
24 | 27    # 3
```

Notice the order: `𝕨 | 𝕩` divides `𝕩` by `𝕨`. The divisor is on the **left**, the opposite of `%` or `mod` in
many languages. This order reads well with the right-to-left rule: `24 | hour + 5` wraps the whole sum. The
result always has the sign of the divisor, so with a positive divisor it is never negative, which makes
`|` good for wrapping around:

```bqn
3 | ¯10    # 2, not ¯1
```

## Powers and roots

`⋆` with two arguments raises `𝕨` to the power `𝕩`; with one argument it is the exponential, `e` to the
power `𝕩`. `√` is the square root, and with a left argument the root of that degree:

```bqn
2 ⋆ 10     # 1024
10 ⋆ ¯1    # 0.1
2 ⋆ 0.5    # 1.4142135623730951
√ 16       # 4
3 √ 27     # 3: the cube root
```

`n ⋆ 2` squares a number; `n × n` does the same.

## Comparing floats in tests

Because fractions are approximate, some results are very slightly off what you would write by hand. When a
task's answer is a fraction, the tests allow a small difference; when it is a whole number, they expect it
exactly, and you may need `⌊` or `⌈` to get there.

## The symbols at a glance

| symbol | one argument | two arguments |
| --- | --- | --- |
| `⌊` | floor | minimum |
| `⌈` | ceiling | maximum |
| `\|` | absolute value | modulus (`𝕨 \| 𝕩`) |
| `⋆` | exponential | power |
| `√` | square root | root |

On the keyboard, `\b` gives `⌊`, `\B` gives `⌈`, `\+` gives `⋆`, `\_` gives `√` and `\8` gives `∞`; `|` is
the ordinary key.
