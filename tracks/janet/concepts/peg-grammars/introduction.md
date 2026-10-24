# Introduction

A PEG _grammar_ is a struct of named rules used as a pattern.
Inside any rule, a keyword refers to another rule (or a built-in class such as `:d`), rules may refer to themselves, and matching starts at `:main`:

```janet
(def nested
  ~{:item (+ :a+ :list)
    :list (* "[" (any (* :item (? ","))) "]")
    :main (* :list -1)})

(peg/match nested "[a,[b,c]]") # => @[]
```

`-1` matches only at the end of the input.
`peg/compile` turns a pattern into a compiled PEG once, for reuse.

Captures can produce values, not just strings:

- `(number patt)` captures the matched text as a number;
- `(constant v)` captures `v` without consuming input;
- `(/ patt f)` replaces `patt`'s captures with `(f ;captures)`, or with `f` itself when it is not a function;
- `(group patt)` collects `patt`'s captures into one array.

```janet
(peg/match ~(/ (* (number :d+) "x" (number :d+)) ,*) "3x4") # => @[12]
```
