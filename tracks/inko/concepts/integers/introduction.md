# Introduction

`Int` is Inko's 64-bit signed integer. Literals may use underscores (`1_000`), hexadecimal (`0xff`) or binary
(`0b101`). The operators are `+`, `-`, `*`, `/`, `%` and `**`.

Integer division rounds down, towards negative infinity, and `%` takes the sign of the divisor:

```inko
7 / 2  # => 3
7 % 2  # => 1
-7 / 2 # => -4
-7 % 3 # => 2
```

Division by zero and overflow panic. `to_float` converts an `Int` to a `Float`, and `absolute` drops the sign.
Operators have no precedence: `2 + 3 * 4` is 20.
