# About

## Immutable bytes

A Janet string is an immutable byte sequence of type `:string`.
It may hold any bytes, including zero bytes, and has no notion of encoding: UTF-8 text works, but `length`, indexing and slicing count bytes, so `(length "é")` is `2` and slicing can cut a multi-byte character in half.
The mutable counterpart is the _buffer_, written `@"…"`, covered in a later lesson.

Because strings are immutable, equal strings are interchangeable: `=` compares them by contents, and they make good table keys.
`<`, `>` and `compare` order them byte by byte, which is alphabetical for ASCII.

## Literals

| Literal | Meaning |
| --- | --- |
| `"…"` | escapes: `\n` `\t` `\r` `\0` `\"` `\\` `\e`, `\xHH` for a byte, `\uXXXX` and `\UXXXXXX` for a code point in UTF-8 |
| `` `…` `` | a long string: no escapes; use more backticks to include backticks, as in ``` `` a ` b `` ``` |

A long string that starts with a newline drops it, and its common indentation is removed, which suits multi-line text in source code.

## Conversion

`string` converts and concatenates any values: numbers print as they would at the REPL, keywords and symbols lose their prefix, and `nil` becomes the empty string.
`describe` returns the printed representation of a value, quotes included for strings.
`string/bytes` returns the bytes as a tuple of numbers and `string/from-bytes` builds a string from them.

## The `string/` module

- Searching: `string/find`, `string/find-all`, `string/has-prefix?`, `string/has-suffix?`, `string/check-set`.
- Pieces: `string/slice`, `string/split` (returns an array), `string/join` (from a list of strings).
- Transforming: `string/ascii-upper`, `string/ascii-lower`, `string/reverse`, `string/repeat`, `string/replace` (first match), `string/replace-all`, `string/trim`, `string/triml`, `string/trimr`.
- Formatting: `string/format`.

The pattern or separator generally comes first and the string being worked on last, which reads well with the threading macro `->>` from a later lesson.

`string/slice` accepts negative indexes, counting from the end: `-1` is the end of the string, so `(string/slice s 0 -2)` drops the last byte.
An index beyond the string is an error.

## `string/format`

The directives follow C's `printf`: `%s` for strings (and other byte sequences), `%d` and `%i` for integers (a number with a fraction is an error), `%f`, `%e` and `%g` for floating point, `%x` for hexadecimal, `%c` for a byte, and `%%` for a literal percent sign.
Some are Janet's own: `%q` pretty-prints any value as Janet source (`%Q` does the same in colour), `%p` and `%P` the same with a depth limit, and `%v` describes a value the way `describe` does.

Flags and sizes go between the `%` and the letter: `-` aligns left, `0` pads numbers with zeros, `+` always shows the sign, a number sets the minimum width, and `.n` the precision — decimals for `%f`, the maximum length for `%s`.

```janet
(string/format "%05.1f" 3.14159)   # => "003.1"
(string/format "%-6.3s|" "abcdef") # => "abc   |"
```

## Not covered here

Parsing structured text is what Janet's PEGs are for (`peg/match`), and building a string piece by piece is what buffers are for; both have lessons of their own.
