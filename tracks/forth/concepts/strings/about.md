# About

## The representation

A string is an address and a count on the stack, `( c-addr u )`.
Nothing marks its end in memory, unlike C's terminating zero, so a string can contain any character and taking a substring is free.
The cost is that every string takes two stack items, so the double-cell shuffles `2dup 2drop 2swap 2over` are the everyday tools.

Older code also uses _counted strings_: a single address whose first byte is the length.
`count ( c-addr -- c-addr+1 u )` turns one into the usual pair, and `c" text"` makes one; prefer `( c-addr u )` in new code.

## Literals

- `s" text"` — text up to the next `"`, no escapes.
- `s\" line\n"` — gforth and Forth 2012: backslash escapes such as `\n`, `\t`, `\"` and `\\`.
- `.( text)` and `." text"` print text instead of pushing it.

Literals compiled into a definition live in the dictionary for as long as the definition does.
At the interpreter, gforth puts them in a temporary buffer that the next interpreted `s"` may reuse, so interpreted literals are only good for a quick experiment or to be copied.

## Words for strings

| Word | Stack effect | Notes |
| --- | --- | --- |
| `type` | `( c-addr u -- )` | print |
| `/string` | `( c-addr u n -- c-addr+n u-n )` | drop `n` from the front; `n` may be negative to grow back |
| `-trailing` | `( c-addr u -- c-addr u2 )` | drop trailing spaces |
| `compare` | `( c-addr1 u1 c-addr2 u2 -- n )` | -1, 0 or 1, by character code |
| `search` | `( c-addr1 u1 c-addr2 u2 -- c-addr3 u3 flag )` | find the second string in the first; on success the rest of the first from the match |
| `bounds` | `( c-addr u -- end start )` | gforth: the limits for `?do` |
| `scan` `skip` | `( c-addr u c -- c-addr2 u2 )` | gforth: up to, or past, the characters `c` |
| `string-prefix?` | `( c-addr1 u1 c-addr2 u2 -- flag )` | gforth: is the second a prefix of the first |
| `capscompare` | `( c-addr1 u1 c-addr2 u2 -- n )` | gforth: case-insensitive `compare` |

## Ownership

A `( c-addr u )` pair is a view into memory that someone else owns.
Taking a substring, trimming or searching keeps pointing into the same memory, so the result is valid exactly as long as the original.
Producing _new_ text needs memory of your own to write it into; the string-buffers concept covers how this track's words do that.

## Idioms

- Walking: `bounds ?do i c@ … loop` (or `… 1 chars +loop` to be explicit about the step).
- Equality: `compare 0=`; ordering: `compare 0<`.
- Splitting at a character: find its index `k`, then `2dup drop k` is the part before and `k 1+ /string` the part after — as long as `k` is less than the length.
