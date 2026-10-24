# Introduction

BQN numbers are written as usual, except that a negative number takes a high minus: `¯4`. The arithmetic
functions are `+`, `-`, `×` and `÷`; called with only a right argument, `-` negates and `÷` takes the
reciprocal. Comments start with `#`.

There are no precedence rules: a function's right argument is the whole expression to its right, so
`2 × 3 + 4` is `14`. Parentheses group as usual.

`←` defines a name. Names are not case sensitive, but the spelling sets the role: a lowercase first letter
makes a _subject_ (a value), an uppercase one a _function_. A block that mentions `𝕩` is a function, with `𝕩`
its right argument and `𝕨` its left:

```bqn
Average ← {(𝕨 + 𝕩) ÷ 2}
3 Average 8    # 5.5
```

In a file, `⇐` defines a name and exports it, so that other files loading it with `•Import` can use it.
