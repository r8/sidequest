# Introduction

`Float` is a 64-bit floating point number. Its literals always have digits on both sides of the point: `1.5`,
`10.0`, `2.5e3`.

`Int` and `Float` never mix: `1.5 * 2` doesn't compile. Convert with `to_float` and `to_int` (which drops the
fraction):

```inko
7.to_float / 2.0 # => 3.5
3.99.to_int      # => 3
```

`floor`, `ceil` and `round(decimals)` round a float and return a `Float`:

```inko
3.7.floor        # => 3.0
3.2.ceil         # => 4.0
3.14159.round(2) # => 3.14
```

Floats are approximations (`0.1 + 0.2` is `0.30000000000000004`), so round before comparing, and expect `Infinity`
rather than a panic from dividing by zero.
