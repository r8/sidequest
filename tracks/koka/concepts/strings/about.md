# About

## Representation

Strings are immutable, UTF-8 encoded sequences of Unicode code points. `count` gives the number of characters
(code points), not bytes: `"café".count` is `4`. Every string function returns a new string.

## Literals

| literal | meaning |
| --- | --- |
| `"a\tb\n"` | escapes: `\n`, `\r`, `\t`, `\"`, `\\`, `\u00E9` (four hex digits) |
| `r"C:\new"` | raw: backslashes are ordinary characters |
| `r#"say "hi""#` | raw with `#`s, so it may contain `"` |

## Building strings

`++` concatenates; `show` converts numbers, booleans and many other values; `repeat(n)` repeats; `join(sep)`
joins a list of strings (see the lesson on lists). Building text in a loop with `++` is fine for small strings.

`a || b` on strings gives `a` unless it is empty, in which case `b`: a compact way to write a fallback,
`nickname || name`.

## Inspecting and transforming

From `std/core/string` and `std/core/sslice`:

- `is-empty`, `is-notempty`, `count`, `contains(sub)`, `count(sub)` (occurrences of `sub`);
- `to-upper`, `to-lower`, `capitalize` — ASCII letters only, other characters are left alone;
- `trim`, `trim-left`, `trim-right` (whitespace), and `trim-left(s, prefix)`, `trim-right(s, suffix)`;
- `pad-left(width, fill = ' ')`, `pad-right(width, fill = ' ')` — the fill is a `char`;
- `replace-all(pattern, replacement)`;
- `split(sep)` into a `list<string>` (empty pieces are kept: `"a,,b".split(",")` has three), and `lines`;
- `truncate(n)`, the first `n` characters; `head` and `tail`, the first character and the rest, as strings.

## Searching

`starts-with`, `ends-with` and `find` return a `maybe<sslice>`: `Nothing` when the text is not there, otherwise a
_slice_ — a view into the original string — after the prefix, before the suffix, or of the match. Use
`.is-just` for a yes/no answer; the lesson on maybe shows how to use the slice, and `.string` turns a slice back
into a string:

```koka
"hello".starts-with("he").is-just     // True
```

## Comparing

`==`, `!=` compare contents. `<`, `<=`, `>`, `>=` and `cmp` order strings by code point, character by character,
so `"Zoe" < "adam"` (capitals come first) and `"apple" < "apples"`. For case-insensitive comparisons, compare
`a.to-lower` with `b.to-lower` (which, again, only folds ASCII).

## Characters

A string is made of `char`s, written in single quotes. Converting between strings and lists of characters is the
subject of the lesson on characters.
