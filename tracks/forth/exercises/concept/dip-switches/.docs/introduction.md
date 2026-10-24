# Introduction

A cell is not only a number: it is a row of bits, 64 of them in gforth on a modern machine.
Forth gives you direct access to those bits, which is one reason it is at home on microcontrollers, where a single cell often stands for a row of switches, lights or flags.

## Writing bit patterns

A number with a prefix is read in another base, whatever the current one:

| Literal  | Base        | Value |
| -------- | ----------- | ----- |
| `%1010`  | binary      | 10    |
| `$ff`    | hexadecimal | 255   |
| `#10`    | decimal     | 10    |

Binary is the clearest way to write a pattern of switches: `%00000101` has bits 0 and 2 set.
Bits are numbered from the right, starting at 0, so bit `n` stands for the value 2 to the power `n`.

## The bitwise words

Each of these works on every bit of the cell at once:

| Word     | Stack effect        | A bit of the result is set when …          |
| -------- | ------------------- | ------------------------------------------ |
| `and`    | `( x1 x2 -- x3 )`   | it is set in both                          |
| `or`     | `( x1 x2 -- x3 )`   | it is set in either                        |
| `xor`    | `( x1 x2 -- x3 )`   | it is set in exactly one                   |
| `invert` | `( x -- x' )`       | it was clear                               |
| `lshift` | `( x u -- x' )`     | moves every bit `u` places to the left     |
| `rshift` | `( x u -- x' )`     | moves every bit `u` places to the right    |

```forth
%1100 %1010 and .   \ 8   (%1000)
%1100 %1010 or .    \ 14  (%1110)
%1100 %1010 xor .   \ 6   (%0110)
1 4 lshift .        \ 16  (%10000)
%1000 3 rshift .    \ 1
```

`lshift` fills with zeros from the right and `rshift` from the left, so `rshift` treats the cell as unsigned: `-1 60 rshift` is 15.
(`2/` is the arithmetic shift that keeps the sign.)

These are the same words that combine flags.
That works because a true flag is a cell with every bit set: `true` and any pattern is that pattern, and `invert` turns true into false and false into true.

## Masks

A _mask_ is a pattern with only the bits you care about set.
`1 n lshift` makes a mask for bit `n` alone: `1 3 lshift` is `%1000`.
With a mask, four idioms cover almost everything:

| To …                 | write                | example on `%0101`        |
| -------------------- | -------------------- | ------------------------- |
| test a bit           | `mask and 0<>`       | `%0101 %0010 and 0<>` is false |
| set a bit            | `mask or`            | `%0101 %0010 or` is `%0111` |
| clear a bit          | `mask invert and`    | `%0101 %0100 invert and` is `%0001` |
| toggle a bit         | `mask xor`           | `%0101 %0001 xor` is `%0100` |

Testing leaves the masked value itself, which is non-zero but not a well-formed flag: `%0101 %0100 and` is 4.
That is fine for `if`, but not for `and`-ing with another flag, so turn it into a real flag with `0<>` when you return it.

To look at every bit in turn, shift the value right one place at a time and look at the lowest bit with `1 and`, or build each mask in a counted loop.

## Pitfalls

- **`invert` is not `negate`.** `5 invert` is -6 and `5 negate` is -5. `invert` flips bits; `negate` changes the sign.
- **`invert` is not `0=` either.** `0=` turns any non-zero value into false; `invert` turns 4 into -5, which is still true.
- **Counting from zero.** The rightmost bit is bit 0, so the eighth switch is bit 7.
- **Operand order of shifts.** The value comes first and the distance on top: `1 3 lshift`, not `3 1 lshift`.
