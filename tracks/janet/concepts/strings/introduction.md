# Introduction

Strings are immutable sequences of bytes, written in double quotes with backslash escapes (`"a\tb\n"`) or between backticks with no escapes at all (`` `C:\temp` ``).
`length` counts bytes, and `(get s i)` returns the byte at index `i` as a number.

`string` concatenates its arguments, converting numbers and other values to text.
`string/slice` cuts out a piece by start and (exclusive) end index; a negative index counts from the end.
`string/find`, `string/has-prefix?` and `string/has-suffix?` search — the pattern comes first, the string to search second.
`string/ascii-upper`, `string/ascii-lower`, `string/trim` and `string/replace-all` return transformed copies.

`string/format` fills a template:

```janet
(string/format "%-8s|%5.2f" "tea" 3.5)   # => "tea     | 3.50"
```
