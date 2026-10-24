# Introduction

A double-cell number, or double, is one value held in two cells: the low cell below, the high cell on top.
In gforth that doubles the range from 64 to 128 bits.
A literal with a dot in it is a double (`1000000.`), `d.` prints one, and `s>d` / `d>s` convert.

Double words carry a `d`: `d+ d- dnegate dabs d< d= d0=`, with `2dup 2swap 2drop 2over` to shuffle them and `2constant 2variable 2@ 2!` to name them.
Mixed-precision words combine singles and doubles: `m*` multiplies two singles into a double, `m+` adds a single to a double, `m*/` scales a double by a fraction, and `um/mod` divides a double by a single.

```forth
3000000000 4000000000 m* d.   \ prints 12000000000000000000
```
