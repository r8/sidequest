# About

## The interface

| Word | Stack effect | Notes |
| --- | --- | --- |
| `source` | `( -- c-addr u )` | the current input buffer |
| `>in` | `( -- addr )` | offset of the next character in it |
| `parse-name` | `( "name" -- c-addr u )` | skips leading whitespace; Forth 2012 |
| `parse` | `( char "text<char>" -- c-addr u )` | no skipping; the delimiter is consumed |
| `word` | `( char "text" -- c-addr )` | older: skips delimiters, returns a counted string in a transient buffer |
| `refill` | `( -- flag )` | reads the next line of the input source |
| `source-id` | `( -- 0 \| -1 \| fileid )` | where the input comes from |

Stick to `parse-name` and `parse` in new code; `word`'s buffer is shared with the system and its counted string is limited to 255 characters.

## Idioms

- **Rest of line:** `source >in @ /string` is the unread text; `source nip >in !` skips it (this is `\`).
- **Look ahead:** `>in @ >r parse-name … r> >in !`.
- **Multi-line text:** parse to the end of the line, then `refill` and continue, as `(` does in files.
- **Keeping a name:** parsed strings live in the input buffer; copy them (`here` and `allot`, `allocate`, or a buffer) before the line goes away.

## Parsing and compilation

A non-immediate parsing word in a definition parses when the definition runs, from whatever input is current then; this is what lets `create` inside a defining word take the child's name from the caller's line.
An immediate parsing word, like `[char]` or `[']`, parses while the definition is compiled and usually compiles what it read as a literal.
Pairs such as `char`/`[char]` and `'`/`[']` exist because of this difference.

## Parsing words and `evaluate`

Inside `evaluate`, the input source is the string, so parsing words read from it; they cannot read past its end into the outer source.
