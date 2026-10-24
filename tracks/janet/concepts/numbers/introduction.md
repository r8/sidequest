# Introduction

Every Janet number is a 64-bit floating-point number; numbers without a fractional part behave like integers and print without a decimal point, and `(= 2 2.0)` is `true`.

`+`, `-` and `*` take any number of arguments.
`/` divides exactly, so `(/ 10 4)` is `2.5`; for whole-number division use `div` (the quotient rounded down) and `mod` or `%` (the remainder):

```janet
(div 17 5)   # => 3
(mod 17 5)   # => 2
```

The `math` module rounds: `math/floor`, `math/ceil`, `math/round` and `math/trunc` all return whole numbers.
To round to two decimal places, multiply by 100, round, and divide by 100.

Comparisons (`=`, `<`, `<=`, `>`, `>=`, `not=`) also take any number of arguments: `(<= 0 x 10)` asks whether `x` lies between 0 and 10.
