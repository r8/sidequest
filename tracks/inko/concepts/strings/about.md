# About

`String` is an immutable, UTF-8 encoded sequence of bytes. It is a value type that uses atomic reference counting
internally, so copying or sending a string to another process is cheap and never copies the text.

## Literals

Single and double quotes are equivalent; both support escapes (`\n`, `\t`, `\r`, `\\`, `\'`, `\"`, `\$`, `\e`,
`\0`, `\u{…}`) and interpolation with `${expression}`. A literal may span several lines; the newlines are part of
the string. Interpolated values must implement `ToString`.

## Bytes, scalars and characters

| Method | Counts or yields |
| --- | --- |
| `size` | bytes |
| `bytes` | an iterator over the bytes, as `Int` |
| `scalars` | an iterator over Unicode scalar values |
| `chars` | an iterator over extended grapheme clusters, as `String` |

`chars` follows Unicode's definition of what a reader sees as one character, so `'👍🏽'` is one char, two scalars and
eight bytes. `substring(start, end)` slices by characters (linear time); `slice(start, end)` slices by bytes
(constant time) and returns a `Slice`, a view that `to_string` turns back into a `String`.

## Building strings

Every `+` creates a new string. To build a long string from many pieces, push them into a
`std.string.StringBuffer` and call `into_string` once, or collect them and use
`String.join(iterator, separator)`:

```inko
import std.string (StringBuffer)

let buf = StringBuffer.new

buf.push('one')
buf.push(', two')
buf.into_string # => 'one, two'

String.join(['a', 'b', 'c'].into_iter, ', ') # => 'a, b, c'
```

## Searching and splitting

`starts_with?`, `ends_with?`, `contains?` and `index_of(value, starting_at: 0)` search; `strip_prefix` and
`strip_suffix` return an `Option[String]` without the prefix or suffix; `split(separator)` returns an iterator of
the parts, and `split_once` splits at the first separator only.

## Case and comparison

`to_upper` and `to_lower` handle non-ASCII letters (`'é'.to_upper` is `'É'`). `==` compares contents; `<`, `>` and
`cmp` compare bytes, which matches alphabetical order only for text in a single case of ASCII letters.
`equals_while_ignoring_case?` compares ASCII letters regardless of case.

## Numbers from strings

`Int.parse('42', 10)` and `Float.parse('2.5')` return an `Option`, which is `None` for text that isn't a number.
