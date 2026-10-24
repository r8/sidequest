# Introduction

A `char` is a single Unicode character, written in single quotes: `'a'`, `'\n'`, `'€'`. Double quotes make
a string, so `'a'` and `"a"` have different types.

A character is a code point, a number: `'a'.int` is `97`, and `98.char` is `'b'`. Letters and digits are
consecutive, so arithmetic on code points finds a letter's position (`c.int - 'a'.int`) or a digit's value
(`c.int - '0'.int`). Characters compare with `==` and `<`, match as literal patterns, and are classified by
`is-lower`, `is-upper`, `is-alpha`, `is-digit`, `is-alpha-num` and `is-white` (ASCII only).

`s.list` turns a string into a `list<char>`, `.string` turns a list of characters (or one character) back into
a string, and `s.map(f)` and `s.count(p)` work on the characters of a string directly.
