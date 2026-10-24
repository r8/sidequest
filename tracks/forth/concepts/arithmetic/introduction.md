# Introduction

Forth's numbers are _cells_: signed integers as wide as a machine word (64 bits in gforth on modern machines).
Arithmetic words take their operands from the stack in written order and leave the result:

```forth
10 3 -      \ 7
7 2 /       \ 3, the integer quotient
7 2 mod     \ 1, the remainder
7 2 /mod    \ 1 3: remainder below, quotient on top
5 negate    \ -5
-5 abs      \ 5
3 8 min     \ 3
3 8 max     \ 8
1000 3 4 */ \ 750: multiply, then divide, without overflow in between
```

There is no precedence: `(2 + 3) * 4` is `2 3 + 4 *`.
Integer division drops the fraction; to round a division up, add one less than the divisor first.
