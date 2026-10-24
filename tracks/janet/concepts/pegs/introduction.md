# Introduction

Janet's core library parses text with Parsing Expression Grammars (PEGs) instead of regular expressions.
A pattern is Janet data, usually written with `~` in front so its tuples are not evaluated:

```janet
(peg/match ~(* "[" (<- :d+) "]") "[42] boot")  # => @["42"]
(peg/match "INFO" "WARN: disk")                # => nil
```

`peg/match` matches at the start of the text and returns an array of captures, or `nil` when it fails.
Strings match literally, `:d`, `:a`, `:w`, `:s` match one character of a class (`:d+` one or more, `:s*` zero or more), a number `n` skips `n` bytes and `-1` matches the end.
`(* a b)` is a sequence, `(+ a b)` an ordered choice, `(any p)`, `(some p)`, `(opt p)` and `(n p)` repeat, `(set "abc")` and `(range "az")` match one character, `(to p)` and `(thru p)` skip ahead, and `(<- p)` captures what `p` matched.

`peg/find` returns the position of the first match, `peg/replace-all` replaces every match (returning a buffer), and `peg/compile` prepares a pattern once for repeated use.
