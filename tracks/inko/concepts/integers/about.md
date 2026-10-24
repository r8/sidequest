# About

`Int` is a 64-bit signed integer and a value type: it is copied when assigned or passed, never borrowed.

## Literals

```inko
42
-42
1_000_000 # underscores are ignored
0xff      # hexadecimal, 255
0b1010    # binary, 10
```

## Arithmetic

`+`, `-`, `*`, `/`, `%` and `**` are methods on `Int` (`Add`, `Subtract` and friends from `std.ops`), and binary
operators have no precedence: they are evaluated left to right, so always parenthesise mixed expressions.

`/` is floored division and `%` is the matching modulo, whose sign follows the divisor:

| Expression | Result |
| --- | --- |
| `7 / 2` | `3` |
| `-7 / 2` | `-4` |
| `7 % -3` | `-2` |
| `-7 % 3` | `2` |

That makes `%` handy for wrapping values around (`(hour + 25) % 24` is never negative). If you need division that
rounds towards zero, as C does, adjust the floored result yourself when the signs differ.

Overflow and division by zero panic. When wrapping arithmetic is what you want, use `wrapping_add`,
`wrapping_sub` and `wrapping_mul`; when you'd rather handle the error, `checked_add`, `checked_sub`, `checked_mul`,
`checked_div` and `checked_pow` return an `Option[Int]`.

The bitwise operators are `&`, `|`, `^`, `<<`, `>>` and `>>>` (an unsigned shift); `not` flips every bit.

## Useful methods

```inko
-5.absolute           # => 5
5.opposite            # => -5
-5.sign               # => -1
12.to_float           # => 12.0
255.format(16)        # => 'ff'
Int.parse('42', 10)   # => Option.Some(42)
1234.digits           # => 4
```

`std.cmp` provides `min` and `max` for any comparable values: `import std.cmp (max)` then `max(3, 7)`.
