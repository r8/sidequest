# About

## base

`base` holds the radix used by the text interpreter to read numbers and by `.`, `u.`, `#` and the other output words to print them.
It is an ordinary variable: `base @` reads it and `n base !` sets it.
`hex` and `decimal` are standard; gforth adds no `binary` or `octal`, so `2 base !` and `8 base !` are the way.

Because the interpreter reads numbers with the same `base`, `hex` at the top level changes how the following source is read: `10` is then sixteen.
Code that is loaded by someone else must leave `base` as it found it.

## Restoring the base

```forth
: .hex ( u -- )  base @ >r  hex  u.  r> base ! ;
```

If the work in between can throw, the restore is skipped; the exceptions concept shows how `catch` makes it safe:
`base @ >r  hex ['] u. catch  r> base !  throw`.

## Prefixes

gforth reads `$` and `0x` as hexadecimal, `%` as binary, `#` and `&` as decimal, regardless of `base`; `'a'` is a character literal.
`$`, `%`, `#` and `'a'` are standard since Forth 2012.
Prefixes make source independent of the current base and are the clearest way to write bit patterns and addresses.

## Converting text to numbers

`>number ( ud1 c-addr1 u1 -- ud2 c-addr2 u2 )` accumulates digits in the current base until a non-digit, and gforth's `s>number? ( c-addr u -- d flag )` converts a whole string, with prefixes and sign.
Both follow `base`.

## Digits above 9

Bases above 10 use letters: `A` is 10, up to `Z` for 35.
gforth prints them in upper case and reads either case.
