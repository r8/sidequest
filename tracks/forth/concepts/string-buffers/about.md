# About

## Why buffers

The stack holds cells, so a string result is always an address and a length pointing at characters somewhere in memory.
For text that already exists — a literal, a substring of the input — that is free.
For new text, some memory has to be written, and the design question is who owns it.

## Three conventions

| Convention | Shape | Lifetime |
| --- | --- | --- |
| The word owns a buffer (this track) | `( c-addr u -- c-addr2 u2 )` | until the next call of that word |
| The caller passes a buffer | `( c-addr u buf size -- c-addr2 u2 )` | as long as the caller's buffer |
| The word allocates | `( c-addr u -- c-addr2 u2 )`, caller must `free` | until freed (the heap-memory concept) |

The first is the lightest for the caller, and the way gforth's own words behave: interpreted `s"`, pictured numeric output (`<# … #>`) and `pad` are all transient.
Its costs are that results must be used or copied promptly, and a word cannot be given its own previous result.
This track's exercises use it, with buffers sized to the documented limits, or grown with `resize` where no limit is given.

## Building blocks

- `move ( from to u -- )` copies bytes and handles overlap; `cmove` copies upward byte by byte (and so can smear a pattern), `cmove>` downward.
- `fill ( c-addr u c -- )`, `blank ( c-addr u -- )` and `erase` initialise.
- `c! ( c c-addr -- )` writes one character.
- `place ( c-addr u buf -- )` and `+place ( c-addr u buf -- )` are gforth words for counted strings, where the first byte holds the length (at most 255).

A buffer with its length in front, as `create name 0 , n chars allot`, keeps the length and text together and lets a handful of general words (`text`, `wipe`, `+text`, `+char`) serve every buffer in a program.

## Capacity

Every write needs a check against the room left: `room min` before a `move`, `room 0>` before a `c!`.
Whether to cut the text short, throw an error (`-24 throw` in this track) or grow the buffer depends on what the exercise documents.

## Pitfalls

- Passing a word its own previous result reads memory while it is being overwritten.
- Keeping a result past the next call: copy it into memory of your own if it must survive.
- Forgetting to reset the length at the start, so results accumulate across calls.
