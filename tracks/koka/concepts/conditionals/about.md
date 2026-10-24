# About

## `if` is an expression

Koka has no separate conditional statement: `if c then x else y` evaluates to `x` or `y`. That makes these all
natural:

```koka
fun abs-diff(a : int, b : int) : int
  if a > b then a - b else b - a

fun total(price : int, member : bool) : int
  val discount = if member then 5 else 0
  price - discount + (if price > 100 then 0 else 4)
```

In the middle of an expression, an `if` needs parentheses, as in the last line above.

## `elif`

`elif` is short for `else if` and lets a chain read flat:

```koka
fun grade(score : int) : string
  if score >= 90 then "A"
  elif score >= 75 then "B"
  elif score >= 50 then "C"
  else "F"
```

The conditions are tested in order, so later ones may assume the earlier ones failed: the `"B"` branch above
knows `score < 90`.

## Blocks as branches

Each branch may be an indented block (or a `{ … }` block); its value is its last expression. `then` must still
appear after the condition, and `else` on its own line closes the first block:

```koka
fun bonus(points : int) : int
  if points > 100 then
    val extra = points - 100
    extra * 2
  else
    0
```

## Types

All branches must have one type, which is the type of the whole `if`; otherwise Koka reports that the
"branch has not the same type as previous branches". Without an `else`, the missing branch is the unit value `()`,
so `if c then println("hi")` is fine but `if c then 1` in a function returning `int` is a type error.

## Beyond `if`

Long chains that compare one value against fixed alternatives are often clearer as a `match`, which a later
lesson introduces.
