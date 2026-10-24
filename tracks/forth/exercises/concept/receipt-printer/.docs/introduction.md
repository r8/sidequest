# Introduction

`.` prints a number, but often you want the digits as a string — to pad them, to put a decimal point among them, or to hand them to another word.
Forth builds that string with _pictured numeric output_, and prints in whatever number base you choose.

## Pictured numeric output

A picture is built between `<#` and `#>`, from the _rightmost_ digit to the leftmost:

| Word   | Stack effect          | What it does                                             |
| ------ | --------------------- | -------------------------------------------------------- |
| `<#`   | `( -- )`              | start an empty picture                                   |
| `#`    | `( ud -- ud' )`       | divide by the base and add the remainder as the next digit |
| `#s`   | `( ud -- 0 0 )`       | add digits until the number is zero (at least one digit) |
| `hold` | `( c -- )`            | add a character                                          |
| `sign` | `( n -- )`            | add a `-` if `n` is negative                             |
| `#>`   | `( ud -- c-addr u )`  | finish, dropping the number, and leave the string        |

The number being converted is a _double-cell_ number: two cells, with the high half on top.
Double cells get a lesson of their own; for now it is enough to know that a non-negative number `n` becomes one by pushing a 0 above it: `n 0`.

```forth
: percent ( n -- c-addr u )
  0 <# [char] % hold #s #> ;

42 percent type   \ prints 42%
```

Because the picture grows leftwards, the first thing added ends up last: here the `%` comes before `#s` in the code and after the digits in the result.

`#` adds exactly one digit, even when the number has already reached zero, which is how leading zeros are made: `7 0 <# # # # #>` gives `007`.
`#s` adds as many as are needed and always at least one, so 0 becomes `0`.

## Negative numbers

The digits words work on unsigned numbers, so a negative number is converted by its absolute value, with the sign added at the end.
`sign` looks at a single cell, which the original number provides if it is kept below the double:

```forth
: celsius ( n -- c-addr u )
  dup abs 0 <# [char] C hold #s rot sign #> ;

-5 celsius type   \ prints -5C
```

`rot` brings the original number up from under the two cells of the double for `sign`; `#>` then drops the double.

## Whose buffer?

`#>` leaves the address of a buffer that belongs to the system, the same one every picture uses.
The result is valid until the next picture is built — exactly the "valid until the next call" rule of the Sign Painter lesson.

## Number bases

`base` is a variable that holds the radix Forth uses to read and print numbers, normally 10.
`hex` stores 16 in it and `decimal` stores 10; any other base from 2 to 36 can be stored directly:

```forth
255 hex . decimal   \ prints FF
2 base !  5 .  decimal   \ prints 101
```

The pictured-output words use `base` too, so the same `<# #s #>` produces hexadecimal digits after `hex`.
Digits above 9 are the letters `A`, `B`, … in upper case.

Changing `base` affects everything that follows, including how the rest of your source is read.
A word that needs a different base should put it back as it was, and the return stack is the natural place to keep the old value while it works:

```forth
: .octal ( n -- )
  base @ >r  8 base !  .  r> base ! ;
```

Whatever base is current, a number written with a prefix is read in a fixed base: `$ff` is hexadecimal, `%101` binary and `#10` decimal.

## Pitfalls

- **Forgetting the 0.** `<#` … `#>` work on a double; a single number on its own makes `#s` consume an item that is not part of it.
- **The order of `hold`s.** Characters added later appear further left.
- **Leaving the base changed.** After `hex`, `10` means sixteen. Restore `base` before the word ends.
- **Using the result too late.** Another `.`, or another picture, overwrites the buffer.
