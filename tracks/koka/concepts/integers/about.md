# About

## Arbitrary precision

`int` is Koka's only everyday integer type, and it is unbounded: small values are stored directly in a machine
word and larger ones switch to a big-integer representation automatically, so arithmetic is always exact.

```koka
1_000_000 * 1_000_000 * 1_000_000   // 1000000000000000000
pow(2, 100)                         // 1267650600228229401496703205376
```

Fixed-size integers exist for interfacing with C (`int32`, `int64` in `std/num/int32` and `std/num/int64`), but
ordinary code uses `int`.

## Literals

Decimal literals may group digits with underscores (`1_000_000`); hexadecimal literals start with `0x` (`0xFF`).
A negative literal is written with a minus directly in front (`-5`).

## Negation

There is no prefix `-` for expressions: `val y = -x` is a syntax error ("unexpected operator"). Negation is
`~x` (for `int` and `float64` alike), or `x.negate` for an `int`. The binary `x - y` is ordinary subtraction, and
needs spaces around it because names may contain dashes.

## Division

`/` and `%` follow Euclidean division: for `x / y` and `x % y`, the remainder satisfies `0 <= x % y < abs(y)` and
`x == (x / y) * y + x % y`.

| expression | Koka | C, Java, JavaScript |
| --- | --- | --- |
| `-17 / 5` | `-4` | `-3` |
| `-17 % 5` | `3` | `-2` |
| `7 / -2` | `-3` | `-3` |
| `7 % -2` | `1` | `1` |

A non-negative remainder is what you want for wrapping around a clock or a circle: `(hour + offset) % 24` stays
between 0 and 23 even when `offset` is negative.

Division by zero is total: `x / 0 == 0` and `x % 0 == x`. Guard the divisor when zero means a mistake.

`divmod(x, y)` returns the pair `(x / y, x % y)`.

## Helpers

`std/core/int` provides, among others:

- `abs(x)`, `min(x, y)`, `max(x, y)`, `sign(x)` (an `order`: `Lt`, `Eq` or `Gt`);
- `pow(x, n)`, also written `x ^ n`;
- `is-even`, `is-odd`, `is-zero`, `is-pos`, `is-neg`;
- `inc` and `dec` (add or subtract one);
- `show` (to a string) and `parse-int` (from a string, giving a `maybe<int>`).

All of them can be called with dot-selection: `x.abs`, `n.is-even`.
