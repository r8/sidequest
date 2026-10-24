# Introduction

## String literals

A `string` is a sequence of Unicode characters, written in double quotes:

```koka
val greeting = "Hello, World!"
```

A backslash starts an _escape_ for characters that cannot be typed directly: `\n` (a new line), `\t` (a tab),
`\"` (a double quote), `\\` (a backslash) and `\u00E9` (any character by its hexadecimal code, here `é`).

A _raw string_ starts with `r` and treats backslashes literally, which helps with paths and patterns:
`r"C:\new"` is six characters, not a line break. To put a double quote inside a raw string, add `#`s around it:
`r#"say "hi""#`.

## Joining strings

`++` joins two strings into a new one:

```koka
"Ana" ++ " " ++ "Lima"     // "Ana Lima"
```

Strings are immutable: every operation returns a new string and leaves the original as it was.

Other values become strings with `show`: `42.show` is `"42"`. Koka has no string interpolation, so text is
built with `++` and `show`:

```koka
"Table " ++ 7.show       // "Table 7"
```

## Working with strings

The standard library's string functions are usually called with dot-selection.

| expression | result |
| --- | --- |
| `"café".count` | `4`, the number of characters |
| `"".is-empty` | `True` |
| `"Hello".to-upper` | `"HELLO"` |
| `"Hello".to-lower` | `"hello"` |
| `"  hi  ".trim` | `"hi"`, without the spaces at both ends |
| `"hello world".capitalize` | `"Hello world"` |
| `"ha".repeat(3)` | `"hahaha"` |
| `"hello".contains("ell")` | `True` |
| `"a-b-c".replace-all("-", "+")` | `"a+b+c"` |

`to-upper`, `to-lower` and `capitalize` only change the ASCII letters a–z and A–Z: `"café".to-upper` is
`"CAFé"`.

### Padding

`pad-left(width, fill)` adds `fill` characters at the start until the string is `width` characters long, and
`pad-right` adds them at the end. A string that is already long enough is returned unchanged. The fill is a
single _character_, written in single quotes — `'0'`, `'.'` — and defaults to a space; characters have a lesson
of their own later.

```koka
"7".pad-left(3, '0')      // "007"
"ab".pad-right(4, '.')    // "ab.."
"12345".pad-left(3, '0')  // "12345"
```

### Prefixes and suffixes

`starts-with` and `ends-with` do not return a `bool`: when the string does start (or end) with the text, they
return the rest of it, and otherwise "nothing" — a _maybe_ value, which a later lesson explains. To just ask the
question, follow them with `.is-just`:

```koka
"hello".starts-with("he").is-just    // True
"hello".ends-with("he").is-just      // False
```

## Comparing strings

`==` and `!=` compare strings character by character, and `<`, `<=`, `>`, `>=` order them by their characters'
codes. That order puts every capital letter before every lower-case one, so `"Zoe" < "adam"` is `True`.

## Pitfalls

- `count` counts characters, not bytes: `"café".count` is `4`.
- `"5" ++ 5` is a type error: show the number first.
- Every function returns a new string; `name.trim` on its own line does not change `name`. Bind the result:
  `val clean = name.trim`.
