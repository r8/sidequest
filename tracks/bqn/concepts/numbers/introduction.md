# Introduction

BQN has one number type, a double-precision float, so `7 ÷ 2` is `3.5` and whole numbers are exact up to
`2⋆53`. `∞`, `¯∞` and `π` are numbers too.

Most arithmetic symbols do one thing with one argument and a related thing with two:

| symbol | one argument | two arguments |
| --- | --- | --- |
| `⌊` | floor (towards `¯∞`) | minimum |
| `⌈` | ceiling | maximum |
| `\|` | absolute value | modulus: `𝕨 \| 𝕩` is `𝕩` modulo `𝕨` |
| `⋆` | `e` to the power `𝕩` | `𝕨` to the power `𝕩` |
| `√` | square root | `𝕨`-th root |

```bqn
⌊ 7 ÷ 2    # 3
0 ⌈ ¯4     # 0
24 | 27    # 3
2 ⋆ 10     # 1024
```

The modulus takes the divisor on the left, and its result has the sign of the divisor: `3 | ¯10` is `2`.
