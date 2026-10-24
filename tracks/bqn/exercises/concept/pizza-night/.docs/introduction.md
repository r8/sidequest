# Introduction

## Expressions and numbers

A BQN program is a sequence of expressions. Numbers are written as usual, `3` or `2.5`, except that a
negative number is written with a high minus: `¯4`. A comment starts with `#` and runs to the end of the line.

```bqn
3 + 4      # 7
10 - 12    # ¯2
6 × 7      # 42
7 ÷ 2      # 3.5
```

The four arithmetic functions are `+`, `-`, `×` and `÷`. Each of them can also be called with only a right
argument: `-5` is `¯5` (negation) and `÷4` is `0.25` (reciprocal).

## Right to left

BQN has no precedence rules. Every function takes as its right argument **the whole expression to its
right**, so expressions are read from right to left:

```bqn
2 × 3 + 4     # 14: 3 + 4 first, then 2 × 7
(2 × 3) + 4   # 10: parentheses group as usual
10 - 3 - 2    # 9: 3 - 2 is 1, then 10 - 1
```

This takes a moment to get used to, but it is one simple rule instead of a table of priorities. When the
order in your head is "multiply, then add", write the addition on the left: `4 + 2 × 3` is `10`.

## Names

`←` defines a name:

```bqn
pizzas ← 3
slices ← 8 × pizzas    # 24
```

Names are made of letters, digits and underscores, and are not case sensitive: `pizzas`, `Pizzas` and
`PIZZAS` are the same name. What the spelling changes is the name's **role**. A name starting with a
lowercase letter is a _subject_, a value that functions work on. A name starting with an uppercase letter
is a _function_, something you call. (Names starting with `_` are modifiers, which come later.) BQN's
grammar is decided by spelling alone, so always give a function a capitalised name.

## Functions are blocks

A block in curly braces that mentions `𝕩` is a function. `𝕩` is its right argument; `𝕨`, when the block
uses it, is its left argument:

```bqn
Double ← {2 × 𝕩}
Double 21         # 42

Average ← {(𝕨 + 𝕩) ÷ 2}
3 Average 8       # 5.5
```

A function is called with its argument on the right (`Double 21`) or between its two arguments
(`3 Average 8`). The right-to-left rule still holds: in `Double 3 + 4` the argument is `3 + 4`, so the
result is `14`. A function's result is the value of the last expression in its block.

Functions can use other functions and names defined before them:

```bqn
perPizza ← 8
Slices ← {perPizza × 𝕩}
Leftover ← {(Slices 𝕨) - 𝕩}
3 Leftover 20     # 4: 24 slices, 20 eaten
```

## Files and exports

A solution is a file of definitions. A definition made with `⇐` instead of `←` is _exported_: the tests load
your file with `•Import` and can only see the exported names.

```bqn
perPizza ← 8           # private to the file
Slices ⇐ {perPizza × 𝕩}  # what the tests call
```

The stub you start from defines each function as `{𝕊 𝕩: "implement me" ! 0}`, a placeholder that raises an
error. Replace the whole block with your own.

## Typing the symbols

BQN's symbols are typed with a prefix key: in the online REPL and most editor plugins, `\` followed by a
letter gives a symbol, such as `\x` for `𝕩`, `\w` for `𝕨`, `\=` for `×`, `\-` for `÷`, `\9` for `¯`,
`\[` for `←` and `\?` for `⇐`.
The keyboard map is on the BQN site.
