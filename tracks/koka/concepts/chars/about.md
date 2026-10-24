# About

## Literals

`'a'`, `'7'`, `' '`; escapes `'\n'`, `'\t'`, `'\r'`, `'\''`, `'\\'`, `'\"'`; `'\x41'` for a code point given in
two hexadecimal digits and `'€'` in four. Any Unicode character may also be written directly: `'é'`, `'€'`.
`show` (and so `println`) displays a character with its quotes and escapes, as `'A'` or `'€'`; use
`.string` to get the bare character as a string.

## Code points

`c.int` is the code point and `n.char` the character for a code point. `+` and `-` between two characters add
or subtract their code points and return a character, so `('c' - 'a').int` is `2`; converting to `int` first is
usually clearer. The classic letter arithmetic:

```koka
fun shift(c : char, n : int) : char
  if c.is-lower then ((c.int - 'a'.int + n) % 26 + 'a'.int).char else c
```

Koka's `%` never returns a negative number, so shifting backwards (`n` negative) wraps correctly too.

## Classification

`is-lower`, `is-upper`, `is-alpha`, `is-digit`, `is-hex-digit`, `is-alpha-num`, `is-white` (space, tab,
newline, carriage return), `is-ascii` and `is-control` are all defined on ASCII only. Letters outside ASCII
(`'é'`, `'Ж'`) are not `is-alpha`, and there is no single-character `to-upper`/`to-lower` in `std/core`:
the string functions `to-upper` and `to-lower` change only ASCII letters as well. Programs that need full
Unicode case mapping must provide their own tables.

## Strings as characters

A Koka string is a sequence of characters, and `count` counts characters, not bytes. To work character by
character:

| Code | Result |
| --- | --- |
| `s.list` | `list<char>` |
| `cs.string` | a string from a `list<char>` |
| `c.string` | a one-character string |
| `s.map(f)` | the string with `f` applied to every character |
| `s.count(p)` | how many characters satisfy `p` |
| `s.foreach(f)` | run `f` on every character |
| `s.head-char` | the first character, as a maybe |

Converting to a list is the most flexible, since every list function applies, and the right choice whenever
characters must be compared with their neighbours, reordered or dropped.
