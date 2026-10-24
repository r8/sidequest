# Introduction

## Tacit functions

You have built functions from other functions with combinators: `32⊸+∘(1.8⊸×)` has no block and never names
its argument. Functions written this way are called **tacit** (or point-free). BQN has a second, often
neater way to write them: **trains**, a sequence of functions in parentheses or on the right of `←`, with no
modifier joining them.

A train is just functions written next to each other, with nothing to their right to be applied to:

```bqn
Mean ← +´ ÷ ≠        # a train of three functions
Mean 2‿4‿9           # 5
```

Without an argument, `+´ ÷ ≠` cannot be evaluated, so BQN treats it as a new function.

## The 3-train, or fork

`(F G H) x` applies `F` and `H` to the argument, then `G` to both results:

```bqn
(F G H) x  ←→  (F x) G (H x)
w (F G H) x  ←→  (w F x) G (w H x)
```

So `+´ ÷ ≠` is "the sum divided by the length", which is the mean. Read a 3-train by its middle function: it
says how the two outer results are combined.

```bqn
(⌈´ - ⌊´) 3‿9‿1      # 9 - 1, which is 8
3 (+ - ×) 2          # (3+2) - (3×2), which is ¯1
```

## The 2-train, or atop

`(G H) x` is `G (H x)`, and `w (G H) x` is `G (w H x)`: the same as `G∘H`. It is often the tidiest way to
apply one more function to the result:

```bqn
Count ← +´ <         # with two arguments: +´ (w < x)
5 Count 3‿7‿9‿5      # 2
```

## Longer trains

A longer train is split into 3-trains from the **right**. `F G H I J` is `F G (H I J)`, and `G H I J` is
`G (H I J)`. A train therefore alternates: functions in odd positions from the right are applied to the
arguments, and the ones between them combine results.

```bqn
Deviations ← ⊢ - +´ ÷ ≠    # ⊢ - (+´ ÷ ≠): each value minus the mean
Deviations 2‿4‿9           # ¯3‿¯1‿4
```

Here `⊢` stands for the argument itself. `⊢` and `⊣` are the most common train parts: `⊢` is the right
argument and `⊣` the left one, so in a train called with two arguments, `+´∘⊣` is the sum of the left
argument.

Named functions are ordinary train parts too, so a long train can be split into readable pieces:

```bqn
Spread ← ⌈´ - ⌊´
Relative ← ⊢ ÷ Spread
```

## Constants

The leftmost part of a 3-train may be a subject instead of a function. It is then used as is:

```bqn
(1 + ⊢) 5            # 6
(2 × ⊢) 3            # 6
```

Only the left part may be a constant. `(⊢ + 1)` is not a train at all: `+ 1` has an argument, so it is
evaluated straight away, and `(⊢ + 1) 5` fails with "Double subjects". Write the constant on the left, or bind
it with `⊸` or `⟜`.

## Modifiers inside trains

Modifiers bind before trains are formed, so `+´`, `×˜∘G`, `2⊸×` and `≠¨` are each a single train part:

```bqn
SumSquares ← +´ ×˜     # a 2-train: +´ (×˜ x)
SumSquares 1‿2‿3       # 14
```

Combinators and trains mix freely. A train is often the clearest way to say "this combined with that", and a
combinator the clearest way to say "do this first".

## Pitfalls

- A train is formed only when there is no argument to its right. `+´ ÷ ≠ 1‿2‿3` is `+´ (÷ (≠ 1‿2‿3))`, the
  sum of the number `÷3`, which is an error; put the train in parentheses or name it first.
- Count the parts. `⊢ - +´ ÷ ≠` has five parts and means `⊢ - (+´ ÷ ≠)`; `+´ ÷ ≠ - ⊢` would mean
  `+´ ÷ (≠ - ⊢)`, which is something else entirely.
- Functions in a train see the same arguments. In `w (F G H) x`, both `F` and `H` get both `w` and `x`.
