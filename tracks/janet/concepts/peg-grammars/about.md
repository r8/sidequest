# About

## Grammars

A grammar is a table or struct whose keys are keywords and whose values are patterns.
`peg/compile` (or `peg/match`, which compiles its pattern on every call) starts at the `:main` rule; any keyword inside a pattern names a rule of the grammar, or, if the grammar does not define it, one of the built-in rules (`:d`, `:a`, `:w`, `:s`, `:h`, `:D`, `:a+`, `:s*` and so on).
An unknown rule is reported when the grammar is compiled.

Because rules are looked up by name, they can be written in any order and can be recursive.
Recursion is what lets a PEG match balanced brackets, nested lists or arithmetic with parentheses — languages that no regular expression can describe.
A rule must consume input before it calls itself again (no _left recursion_): `:e (+ (* :e "+" :d) :d)` recurses without making progress, and Janet aborts with "peg/match recursed too deeply".
Rewrite such a rule as a repetition: `:e (* :d (any (* "+" :d)))`.

Grammars nest: a value in a grammar can itself be a grammar, with its own `:main` and its own rule names.

## Anchors and look-ahead

- A non-negative integer `n` matches exactly `n` bytes; a negative `-n` matches only when fewer than `n` bytes remain, so `-1` is "end of input".
- `(! patt)` (or `(not patt)`) succeeds, consuming nothing, when `patt` does not match; `(> patt)` (look-ahead) succeeds when it does.
- `(to patt)` and `(thru patt)` skip ahead to (or past) the next match of `patt`.

`peg/match` takes an optional start index, and a successful match need not consume the whole input — anchor with `-1` when it must.

## Value captures

| Pattern | Captures |
| --- | --- |
| `(<- patt)` | the matched text |
| `(number patt &opt base)` | the matched text as a number (`scan-number`); fails if it is not one |
| `(constant v)` | `v`, consuming nothing |
| `(/ patt f)` | `(f ;captures)` when `f` is a function, a table or struct lookup when `f` is one, `f` itself otherwise |
| `(cmt patt f)` | like `/` with a function, but the match fails when `f` returns `nil` or `false` |
| `(group patt)` | an array of `patt`'s captures |
| `(position)` / `($)` | the current byte index |
| `(line)`, `(column)` | the current line and column, from 1 |
| `(capture patt tag)` / `(backref tag)` | a tagged capture and a later reference to it |
| `(drop patt)` | nothing: matches `patt` and discards its captures |

A function used with `/` or `cmt` is put into a quasiquoted pattern with `,`: `~(/ :d+ ,scan-number)`.
Without the comma the pattern holds a symbol, and symbols such as `*` and `+` are PEG operators.

Captures flow upwards: a rule's captures become part of whatever pattern uses the rule, so `/` and `group` around a rule see the values its sub-rules produced.
That makes it natural to compute while parsing — an arithmetic grammar can return the result itself rather than a tree.

## Compiling once

`(peg/compile pattern)` returns a `core/peg` value.
Compile at the top level when a pattern is used repeatedly; `peg/match`, `peg/find`, `peg/find-all`, `peg/replace` and `peg/replace-all` all accept compiled PEGs.

## Debugging

Build a grammar up one rule at a time and try each rule at the REPL with a `:main` that is just that rule.
When a whole-input match returns `nil`, drop the `-1` to see how far the prefix match got, or add `(position)` captures.
