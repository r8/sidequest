# Introduction

## Booleans

The type `bool` has exactly two values, `True` and `False` (with capitals: they are constructors, as later
lessons explain). Three operators combine them:

| operator | meaning | example |
| --- | --- | --- |
| `&&` | and: both are true | `True && False` is `False` |
| `\|\|` | or: at least one is true | `True \|\| False` is `True` |
| `!` | not | `!True` is `False` |

`&&` binds more tightly than `||`, so `a || b && c` means `a || (b && c)`. Use parentheses whenever you mix them;
it costs nothing and reads better.

Both `&&` and `||` are _short-circuiting_: the right side is evaluated only when it can still change the result.
In `n > 0 && 10 / n > 2`, the division never happens when `n` is not positive.

## Comparisons

Comparing two values gives a `bool`:

| operator | meaning |
| --- | --- |
| `==` | equal |
| `!=` | not equal |
| `<`, `<=` | less than, less than or equal |
| `>`, `>=` | greater than, greater than or equal |

```koka
fun is-adult(age : int) : bool
  age >= 18
```

Comparisons do not chain: `1 < x < 10` is an error. Write `1 < x && x < 10`.

## Conditionals

`if … then … else` chooses between two expressions:

```koka
fun describe(age : int) : string
  if age >= 18 then "adult" else "minor"
```

`if` is an expression, like everything in Koka: it has a value, so it can be the result of a function, be bound
with `val`, or sit in the middle of a calculation (in parentheses):

```koka
val price = 10 + (if member then 0 else 5)
```

More than two cases chain with `elif`, which is checked from top to bottom; the first condition that holds
chooses the branch:

```koka
fun size(n : int) : string
  if n < 10 then "small"
  elif n < 100 then "medium"
  else "large"
```

A branch can be a whole indented block, whose last expression is the branch's value:

```koka
fun bonus(points : int) : int
  if points > 100 then
    val extra = points - 100
    extra * 2
  else
    0
```

### Both branches, one type

Because the `if` has a value, every branch must have the same type: `if ok then 1 else "no"` is a type error,
because one branch is an `int` and the other a `string`.

For the same reason, an `if` without `else` is only allowed where nothing is produced — when the `then` branch is
an action of type `()` (the _unit_ type, whose only value is `()`), such as printing. Leaving out the `else` of a
function that must return an `int` is an error: Koka would not know what to return when the condition is false.

## Pitfalls

- `=` is not a comparison; it only appears in definitions (`val x = …`). Compare with `==`.
- There is no "truthiness": `if 0 then …` is a type error, because the condition must be a `bool`.
- A function that returns `if c then True else False` can return `c` itself.
