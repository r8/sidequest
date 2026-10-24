# About

## Why PEGs

A PEG is a deterministic, recursive-descent matcher.
Unlike a regular expression it never backtracks into a repetition, and choices are ordered, so a pattern means exactly one thing.
Patterns are plain Janet values — strings, numbers, keywords, tuples, structs — so they can be built by functions, stored in definitions and combined like any other data.
They are also strictly more powerful than regular expressions: with grammars (named, recursive rules) they parse nested structures such as balanced brackets or arithmetic.

## The core functions

| function | returns |
| --- | --- |
| `(peg/match pattern text &opt start & args)` | an array of captures, or `nil` |
| `(peg/find pattern text &opt start)` | the index of the first position where the pattern matches, or `nil` |
| `(peg/find-all pattern text)` | an array of indices where the pattern matches |
| `(peg/replace pattern subst text)` | a buffer with the first match replaced |
| `(peg/replace-all pattern subst text)` | a buffer with every match replaced |
| `(peg/compile pattern)` | a compiled pattern, usable wherever a pattern is |

`peg/match` is anchored at `start` (default 0) and succeeds on a prefix; add `-1` to require the whole text.
In `peg/replace` and `peg/replace-all`, `subst` may be a string or a function of the matched text and the captures.

## Primitive patterns

| pattern | matches |
| --- | --- |
| `"text"` | exactly that text |
| `n` (positive) | any `n` bytes |
| `-n` | succeeds only if fewer than `n` bytes remain; `-1` is end of input |
| `:d :a :w :s :h` | one digit, letter, letter-or-digit, whitespace, hex digit (ASCII) |
| `:D :A :W :S :H` | one character _not_ in that class |
| `:d+ :d*` etc. | one or more, zero or more of the class |
| `(set "chars")` | one of those bytes |
| `(range "az" …)` | one byte in any of the ranges |

## Combinators

| pattern | meaning |
| --- | --- |
| `(* a b …)` | sequence |
| `(+ a b …)` | ordered choice: the first alternative that matches wins |
| `(any p)`, `(some p)` | zero or more, one or more, greedy |
| `(opt p)`, `(? p)` | optional |
| `(between lo hi p)`, `(at-least n p)`, `(at-most n p)`, `(n p)`, `(repeat n p)` | counted repetition |
| `(! p)`, `(not p)` | negative lookahead: succeeds without consuming where `p` fails |
| `(> 0 p)`, `(look 0 p)` | positive lookahead |
| `(if cond p)`, `(if-not cond p)` | `p`, only where `cond` does / does not match |
| `(to p)`, `(thru p)` | skip ahead to before / past the next match of `p` |

Because repetition is greedy without backtracking, `(* (any :a) "a")` never matches; write the stop condition into the loop, as in `(any (if-not "a" 1))`, or restructure the pattern.

## Captures

`(<- p)` (or `(capture p)`) pushes the matched text.
Captures are strings; `scan-number` converts digits.
Many more capture forms exist — `(number p)`, `(/ p f)` to transform captures with a function, `(constant v)`, `(group p)`, `(position)`, `(line)` and `(column)` — which the grammars lesson covers along with named rules.

## Idioms

- Every occurrence anywhere: `~(any (+ (<- p) 1))`.
- A whole-string check: `(truthy? (peg/match ~(* p -1) s))`.
- Split on a separator pattern: `(peg/match ~(any (* (<- (any (if-not "," 1))) (? ","))) s)`, or simply `string/split` when the separator is a fixed string.

## Bytes, not characters

PEGs work on bytes.
`1` skips one byte, so a UTF-8 character outside ASCII spans several; the character classes only recognise ASCII.
