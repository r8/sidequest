# About

## Loops are functions

Koka has no `for` or `while` keywords. The standard library defines them as higher-order functions, and trailing
lambdas make calls to them look like loops:

```koka
for(1, 10) fn(i)
  println(i)

while { n > 1 }
  n := n / 2
```

The `while` condition is a function too — `{ n > 1 }` is a lambda without parameters — because it must be
evaluated again before every round.

## The loop functions

| function | runs the body |
| --- | --- |
| `for(lo, hi, action)` | for each `i` from `lo` to `hi` inclusive (not at all when `hi < lo`) |
| `for-while(lo, hi, action)` | like `for`, but stops early when the body returns `Just(x)`, giving `Just(x)` |
| `xs.foreach(action)` | for each element of `xs`, in order |
| `xs.foreach-indexed(action)` | for each element and its index, from 0 |
| `xs.foreach-while(action)` | until the body returns a `Just` |
| `repeat(n, action)` | `n` times |
| `while(cond, action)` | while `cond()` is `True` |

Strings and vectors have their own `foreach` as well.

## Effects

A loop's effect is its body's effect. `for`, `foreach` and `repeat` always terminate, so a loop that only assigns
local variables keeps the function total. `while` adds `div`, because nothing guarantees that the condition ever
becomes false: write it in the type, as in `fun f(n : int) : div int`, or prefer a bounded loop when the number of
rounds is known.

## Leaving early

There is no `break`. Use `foreach-while` or `for-while`, which stop at the first `Just`, a `while` whose condition
checks a flag, or a recursive function. `return` inside a loop body returns from the lambda, not the enclosing
function.

## Loops or folds

A loop with a `var` and a `foldl` compute the same things:

```koka
var total := 0
xs.foreach fn(x)
  total := total + x

xs.foldl(0, fn(acc, x) acc + x)
```

The fold is the more common Koka idiom for a single result; loops read better when several values are updated per
step.
