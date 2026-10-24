# Introduction

A cell is a row of bits, and Forth's bitwise words work on all of them at once:
`and`, `or`, `xor` and `invert` combine or flip bits, and `lshift` and `rshift` ( x u -- x' ) move them.
`%1010` is a binary literal and `$ff` a hexadecimal one.

A _mask_ selects bits: `1 n lshift` is bit `n` alone.

```forth
x mask and 0<>      \ is the bit set?
x mask or           \ set it
x mask invert and   \ clear it
x mask xor          \ toggle it
```

Flags are bit patterns too — true has every bit set — which is why the same `and`, `or` and `invert` combine flags.
