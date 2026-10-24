# About

## char and [char]

Both read the next word of the source and give the code of its first character, but at different times:

- `char` ( "name" -- c ) parses when it runs. At the interpreter, that is right away.
- `[char]` is an immediate word that parses while compiling and compiles the code as a literal. It may only be used inside a definition.

Using `char` in a definition compiles a call to `char`, which parses at run time — a classic newcomer's bug, and one that gforth will not warn about.

## ASCII facts worth knowing

| Characters | Codes | Notes |
| --- | --- | --- |
| space (`bl`) | 32 | below it are control characters: tab 9, line feed 10, carriage return 13 |
| `0`–`9` | 48–57 | `[char] 0 -` gives the digit's value |
| `A`–`Z` | 65–90 | |
| `a`–`z` | 97–122 | 32 above the upper case: `32 xor` toggles the case of a letter |

Printable ASCII runs from 32 to 126.

## Words for characters

- `emit ( c -- )` prints one character; `space` and `spaces ( n -- )` print blanks; `cr` starts a new line.
- `toupper ( c -- c' )` is gforth's own upper-casing word (not standard); it is a fine choice once you know how it works.
- `digit? ( c -- u true | false )` in gforth converts a digit in the current base; note that it returns two items on success.
- `key ( -- c )` reads a key from the terminal.

## Characters and bytes

Strictly, the Forth standard distinguishes characters from address units, and memory words use `chars` and `char+` to step through text.
In gforth a character is one byte, so `chars` does nothing, but writing it keeps code portable and readable.

gforth reads source as bytes. Text outside ASCII is UTF-8, where one character can take two to four bytes; the `xchar` words (`xc@`, `xc-size`, `xemit`) handle that.
Exercises in this track keep to ASCII.
