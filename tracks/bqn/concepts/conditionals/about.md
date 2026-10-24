# About

## How a body is chosen

A block's bodies are tried from left to right. For each one, BQN checks its header (if it has one) against the
arguments: the number of arguments, literal values, and list patterns of the right length. If the header
matches, the body runs statement by statement; a predicate `cond ?` that gives `0` abandons it, and BQN tries
the next body. Statements before a failed predicate have run, but their names are gone. If no body is left,
the error is "No header matched argument".

A body without a header accepts any arguments, so it belongs last. A header-less body uses `𝕩` and `𝕨` for
its arguments.

## Predicates

- The condition must be exactly `0` or `1`; a list or other number is the error "Expected boolean". To branch
  on "any" or "all" of a list, reduce it first (`∨´` and `∧´`, from the fold lesson).
- A body can have several predicates; each must hold for it to continue.
- Only the chosen path is evaluated, so predicates guard calculations that would fail: `{𝕩 = 0 ? 0 ; 1 ÷ 𝕩}`.

## Patterns in headers

Literal numbers, characters and strings, and lists of patterns, can stand in a header: `𝕊 0:`, `𝕊 'a':`,
`𝕊 "stop":`, `𝕊 x‿0:`. A name in a pattern matches anything and names it. Matching uses `≡`, so `"stop"`
matches only that exact string.

## One or two arguments

`{𝕊 𝕩: … ; 𝕨 𝕊 𝕩: …}` gives a function different behaviour when called with one or two arguments, its two
_valences_. Order matters: a `𝕨 𝕊 𝕩:` header matches a one-argument call too (with `𝕨` empty, so `𝕨 + 𝕩`
becomes `+ 𝕩`), and a `𝕊 𝕩:` body placed after it is rejected as an "Unreachable body". A header whose left
argument is a name or a literal (`a 𝕊 𝕩:`, `0 𝕊 𝕩:`) matches only two-argument calls.

## Without branching

Many decisions need no conditional at all. When both outcomes are numbers, arithmetic on a boolean is usually
shorter and works on whole lists: `price × ¬ free`, or `a + (b - a) × cond` to choose between `a` and `b`.
Selecting from a list by a boolean index (`cond ⊑ a‿b`, from the selection lesson) is another common idiom.
Reach for predicates when the results have different types, when one branch must not run, or for recursion.

## Other control structures

BQN has no `if` or `while` keywords. Besides predicates, there is the modifier `◶` (choose a function by an
index) and recursion for loops, covered in the next lesson. The control flow page shows how to build
`If`, `While` and similar from blocks.
