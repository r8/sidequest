# Introduction

`float64` is Koka's 64-bit floating-point number. Its literals have a decimal point or an exponent (`2.0`,
`1.5e3`), and its arithmetic, comparisons and `show` come from `std/num/float64`, which must be imported:

```koka
import std/num/float64

fun flour(rolls : int) : float64
  rolls.float64 * 0.125
```

Koka never mixes `int` and `float64`: convert with `.float64`, and back with `.int`, which rounds to the nearest
integer (halves to even). `floor`, `ceiling`, `truncate` and `round` give whole floats, so `x.ceiling.int`
rounds up. Float arithmetic is approximate: `0.1 + 0.2` is `0.30000000000000004`.
