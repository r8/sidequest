# Introduction

A Koka `string` is an immutable sequence of Unicode characters in double quotes, with escapes such as `\n`,
`\"` and `\\`; a raw string `r"…"` takes backslashes literally. `++` joins strings and `show` turns other values
into strings — there is no interpolation:

```koka
fun badge(name : string, table : int) : string
  name.trim ++ " (table " ++ table.show ++ ")"
```

The standard library's functions are used with dot-selection: `count`, `is-empty`, `to-upper`, `to-lower`
(ASCII letters only), `trim`, `contains`, `repeat`, `replace-all`, `pad-left`. `starts-with` and `ends-with`
return a maybe; `.is-just` turns it into a `bool`.
