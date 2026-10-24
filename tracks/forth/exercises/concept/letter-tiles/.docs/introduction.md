# Introduction

Forth has no separate character type.
A character is a number on the stack: its code in the character set, which for the letters, digits and punctuation of English is ASCII.
`A` is 65, `a` is 97, `0` is 48 and a space is 32.

## Getting a character's code

You rarely want to write 65 when you mean `A`, so Forth has two words that read the next word of the source and push the code of its first character:

```forth
char A .          \ prints 65 — use char outside definitions

: a-code ( -- c )
  [char] a ;      \ use [char] inside definitions

a-code .          \ prints 97
```

The two differ in _when_ they read the character.
`[char]` reads it while the definition is being compiled, and compiles the code as a number, which is what you want inside `:` … `;`.
`char` reads it when it runs, so inside a definition it would read whatever word comes after the call at run time.
Outside definitions, use `char`; inside, use `[char]`.

`bl` pushes the code of a space, 32.

## Printing a character

`emit ( c -- )` prints the character with that code:

```forth
char * emit       \ prints *
72 emit 105 emit  \ prints Hi
```

## Characters are numbers

Because they are numbers, everything from the earlier lessons applies to characters.
The ASCII letters and digits each come in one unbroken run, in order:

| Range       | Codes      |
| ----------- | ---------- |
| `0` … `9`   | 48 … 57    |
| `A` … `Z`   | 65 … 90    |
| `a` … `z`   | 97 … 122   |

So the value of a digit is its distance from `0`, and a letter's place in the alphabet is its distance from `A` (or `a`):

```forth
: digit-value ( c -- n )
  [char] 0 - ;

char 7 digit-value .   \ prints 7
```

Upper- and lower-case letters are the same distance apart all the way through the alphabet: `[char] a [char] A -` is 32.
Converting a letter between cases is adding or subtracting that distance — but only for letters; other characters must be left alone.

Comparisons work as for any number.
`within ( n lo hi -- flag )` is true when `lo <= n < hi`; the upper bound is _excluded_, so the test for a digit is:

```forth
: digit? ( c -- flag )
  [char] 0 [char] 9 1+ within ;
```

`case` from the Weather Station lesson works too, with `[char]` for each value:

```forth
: bracket? ( c -- flag )
  case
    [char] ( of true endof
    [char] ) of true endof
    false swap
  endcase ;
```

## Pitfalls

- **`char` inside a definition** does not do what it looks like; write `[char]`.
- **The upper bound of `within`** is excluded: `[char] a [char] z within` misses `z`.
- **Only ASCII is one character per code.** Accented letters and other non-English characters take several bytes in UTF-8, the encoding gforth reads its source in, so `[char] é` gives only the first byte. This track's exercises stick to ASCII.
- **Case conversion of non-letters.** Subtracting 32 from `[` or `1` gives a different, unrelated character. Check the range first.
