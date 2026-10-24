# About

## What a character is

A BQN character is a Unicode code point, from `@` (code point 0) to `@ + 1114111`. It is an atom, like a
number, but a different type: `•Type 'a'` is `2`, while `•Type 1` is `1`. Characters are not bytes; a string
read from a file is decoded from UTF-8, so `'é'` is one character.

## Literals

`'x'` writes a character. Any single code point can go between the quotes, including a space or a double quote
(`'"'`); a single quote is `'''`. Characters with no visible form, such as newline and tab, are written with
`@`: `@ + 10` is a newline, `@ + 9` a tab.

## Arithmetic

Only the operations that make sense on positions are allowed:

| expression | result |
| --- | --- |
| character `+` number, number `+` character | character |
| character `-` number | character |
| character `-` character | number |
| character `+` character | error |
| `×`, `÷` and the rest with a character | error |

Comparisons `< ≤ > ≥` order characters by code point, and every number comes before every character; `=` and
`≠` compare characters with anything.

## Case

There is no case-conversion primitive. For the English alphabet, small letters are 32 code points after
capitals, so `c - 32 × ('a' ≤ c) ∧ c ≤ 'z'` converts to capitals and leaves other characters alone. Beyond
ASCII, Unicode case is irregular and needs a table.

## Digits

`'7' - '0'` is `7`, and `'0' + 7` is `'7'`. This is the usual way to convert single digits; for whole numbers,
see the formatting lesson's `•Fmt` and `•ParseFloat`.
