# Introduction

A single PEG pattern is fine for a date or a log level, but real input has structure: a file is made of lines, a line of fields, a field of smaller pieces, and some things — parentheses, lists inside lists — contain themselves.
For that, Janet's PEGs have _grammars_: named rules that refer to one another.
This lesson also covers the captures that turn matched text into values rather than strings.

## Grammars

A grammar is a struct (or table) used as a pattern.
Its keys are rule names, its values are patterns, and inside any pattern a keyword refers to the rule of that name.
Matching starts at the rule called `:main`.

```janet
(def date
  ~{:year (* :d :d :d :d)
    :two (* :d :d)
    :main (* (<- :year) "-" (<- :two) "-" (<- :two))})

(peg/match date "2024-03-15") # => @["2024" "03" "15"]
```

The built-in classes you already know, such as `:d` and `:a`, are rules too; a grammar may use them alongside its own.
Naming a rule that the grammar does not define and that is not built in is an error when the pattern is compiled.

Rules may be listed in any order, and a rule may refer to itself, directly or through other rules.
That is how a PEG matches nested structure, something a single flat pattern cannot do:

```janet
(def nested
  ~{:item (+ :a+ :list)
    :list (* "[" (any (* :item (? ","))) "]")
    :main (* :list -1)})

(peg/match nested "[a,[b,c],[[d]]]") # => @[]
(peg/match nested "[a,[b]")          # => nil
```

`-1` in the last example is a negative number used as a pattern: `-n` matches only when fewer than `n` bytes remain, so `-1` means "the end of the input".
Without it, `peg/match` succeeds as soon as a prefix of the input matches, and the rest is ignored.

`peg/match` compiles its pattern every time it is called.
`peg/compile` does that once, and the compiled pattern can be passed to `peg/match` instead:

```janet
(def date-peg (peg/compile date))
(peg/match date-peg "1999-12-31") # => @["1999" "12" "31"]
```

## Captures that make values

`<-` captures the matched text as a string.
Other captures push other values onto the capture stack, and `peg/match` returns that stack as an array.

- `(number patt)` matches `patt` and captures the matched text converted to a number.

  ```janet
  (peg/match ~(number :d+) "42")              # => @[42]
  (peg/match ~(number (* :d+ "." :d+)) "2.5") # => @[2.5]
  ```

- `(constant value)` matches nothing and captures `value`. Combined with `*`, it tags what was matched:

  ```janet
  (peg/match ~(+ (* "yes" (constant true)) (* "no" (constant false))) "no") # => @[false]
  ```

- `(/ patt value)` matches `patt` and replaces its captures. When `value` is a function, it is called with the captures as arguments and its result is captured instead; otherwise `value` itself is captured.

  ```janet
  (peg/match ~(/ "on" :enabled) "on")                    # => @[:enabled]
  (peg/match ~(/ (* (number :d+) "x" (number :d+)) ,*) "3x4") # => @[12]
  ```

  The `,` before `*` puts the value of `*` — the multiplication function — into the quasiquoted pattern; without it, the pattern would contain the symbol `*`, which a PEG reads as its own sequence operator.

- `(group patt)` collects the captures `patt` makes into one array, so a sequence of fields becomes one value:

  ```janet
  (peg/match ~(any (* (group (* (<- :a+) "=" (number :d+))) (? ";"))) "w=3;h=4")
  # => @[@["w" 3] @["h" 4]]
  ```

Captures nest: a rule's captures are whatever its patterns capture, so a rule that is used inside a `group` or `/` hands its values up to it.
A function given to `/` can therefore combine values that inner rules have already converted, which lets a grammar compute a result while it parses.

## Pitfalls

- A number used as a pattern is not a literal: `1` matches any single byte and `-1` the end of input. To match the text `"1"`, write it as a string.
- `/` with a function calls it with exactly the captures of its pattern. A pattern with no captures calls the function with no arguments.
- A PEG never backtracks into a repetition that has already succeeded: `(* (any :d) :d)` never matches, because `any` takes every digit.
- A rule that calls itself before consuming any input, such as `:e (+ (* :e "+" :d) :d)`, recurses forever; Janet stops it with an error. Put something that consumes input first.
