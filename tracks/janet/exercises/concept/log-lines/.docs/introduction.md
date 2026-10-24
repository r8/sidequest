# Introduction

Most languages reach for regular expressions to pick text apart.
Janet has something more powerful built into its core: _Parsing Expression Grammars_, or PEGs.
A PEG is a pattern written as ordinary Janet data, and `peg/match` runs it against a string.

## Matching

`(peg/match pattern text)` tries the pattern at the start of the text.
If it matches, the result is an array of the values the pattern _captured_ — empty if it captured nothing.
If it does not match, the result is `nil`.

```janet
(peg/match "INFO" "INFO: started")  # => @[], it matched, nothing captured
(peg/match "INFO" "WARN: disk")     # => nil
```

The pattern only has to match a prefix of the text; the rest is ignored.
And it is anchored at the start: `(peg/match "INFO" "xINFO")` is `nil`.

## Patterns are data

The simplest patterns are values:

- a string matches exactly that text;
- a number `n` matches any `n` bytes, and `-1` matches only at the end of the text;
- the keywords `:d` (a digit), `:a` (a letter), `:w` (a letter or digit), `:s` (whitespace) and `:h` (a hexadecimal digit) match one such character; add `+` for one or more (`:d+`) or `*` for zero or more (`:s*`).

Bigger patterns are tuples whose first element names an operation.
Because a tuple like `(* "a" "b")` would otherwise be evaluated as a multiplication, patterns are written with the quasiquote `~` in front, which keeps the form as data:

```janet
(peg/match ~(* "[" :d+ "]") "[42] boot") # => @[]
```

Read the `~` as "this is a pattern, not code".

## Combining patterns

| pattern | matches |
| --- | --- |
| `(* a b …)` | `a`, then `b`, … in sequence |
| `(+ a b …)` | `a`, or else `b`, or else … — the first that matches |
| `(any p)` | `p` zero or more times |
| `(some p)` | `p` one or more times |
| `(opt p)` or `(? p)` | `p` or nothing |
| `(between min max p)` | `p` from `min` to `max` times |
| `(n p)` | `p` exactly `n` times, as in `(2 :d)` |
| `(set "chars")` | one of the characters in the string |
| `(range "az")` | one character in the range; `(range "az" "AZ")` allows several ranges |
| `(! p)` | succeeds, consuming nothing, only where `p` does **not** match |
| `(to p)` | everything up to where `p` matches, not including it |
| `(thru p)` | everything up to and including `p` |

Repetition is greedy and never backtracks: `(* (any :a) "a")` can never match, because `any` eats every letter.

Choice is _ordered_: `(+ "a" "ab")` tries `"a"` first and, finding it, never considers `"ab"`.
Put the longer alternative first.

## Capturing

A pattern wrapped in `(<- p)`, short for `(capture p)`, pushes the text that `p` matched onto the result array:

```janet
(peg/match ~(* "[" (<- :d+) "]") "[42] boot")             # => @["42"]
(peg/match ~(* (<- :a+) "=" (<- :d+)) "width=80")       # => @["width" "80"]
```

Captures are always strings; turn digits into a number with `scan-number`, as in `(scan-number "42")`.

To collect every occurrence of something anywhere in a text, combine a choice with "skip one character": `(any (+ (<- p) 1))` captures each `p` and steps over everything else.

```janet
(peg/match ~(any (+ (<- :d+) 1)) "a1b22c333")  # => @["1" "22" "333"]
```

## Finding and replacing

`(peg/find pattern text)` returns the index of the first position where the pattern matches, or `nil`:

```janet
(peg/find "ERROR" "ok ok ERROR bad") # => 6
```

`(peg/replace-all pattern replacement text)` replaces every match with the replacement, and `peg/replace` only the first.
Both return a buffer; `string` turns it into a string.

```janet
(string (peg/replace-all :d "#" "pin 1234"))  # => "pin ####"
```

## Compiling once

`peg/match` compiles its pattern every time it is called.
For a pattern used often, `(def digits (peg/compile ~(some :d)))` compiles it once, and the compiled value can be passed wherever a pattern is expected.

## Pitfalls

- A successful match with no captures is `@[]`, which is truthy; only a failed match is `nil`.
- A pattern matches a prefix: add `-1` at the end to require the whole text to match.
- Strings are bytes, so `1` skips one byte, and `:a` only knows ASCII letters.
