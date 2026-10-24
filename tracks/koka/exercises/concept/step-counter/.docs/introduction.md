# Introduction

## Variables that change

Every name so far has been a `val`, bound once and never changed. Sometimes it is clearer to keep a running value
and update it step by step. Koka allows that with `var`, which declares a _mutable local variable_, and `:=`, which
assigns it a new value:

```koka
fun sum-to(n : int) : int
  var total := 0
  for(1, n) fn(i)
    total := total + i
  total
```

Note the two operators: a `var` is declared with `:=` (not `=`), and every later assignment uses `:=` too. Reading
the variable needs nothing special — `total` is its current value.

A variable can hold any type: a number, a string, a list that grows with `Cons`, a struct you replace with a
copy.

## Local, and only local

A `var` belongs to the function that declares it. Lambdas inside the function can read and assign it, as the loop
body above does, but the variable cannot outlive the call: returning a function that still refers to it is a
compile error ("abstract type(s) escape(s) into the context"). That is what makes it safe — no other part of the
program can ever see the variable change.

It is also why `sum-to` is still declared as returning a plain `int`. Updating a local variable is an effect, but
Koka can see that it never leaves the function, so the function stays total: called with the same argument it
always gives the same answer.

## Loops

Koka has no loop keywords; loops are ordinary functions from the standard library that take the loop body as a
function, usually written as a trailing lambda.

`for(lo, hi) fn(i) …` runs the body for each integer from `lo` to `hi`, both included; when `hi < lo` it does
nothing.

```koka
var squares := 0
for(1, 3) fn(i)
  squares := squares + i * i      // 1 + 4 + 9
```

`xs.foreach fn(x) …` runs the body for each element of a list, in order, and `xs.foreach-indexed fn(i, x) …` also
passes each element's position, counting from 0:

```koka
fun best-position(xs : list<int>) : int
  var best := 0
  var best-value := -1
  xs.foreach-indexed fn(i, x)
    if x > best-value then
      best-value := x
      best := i
  best
```

`repeat(n) { … }` runs a block `n` times.

`while { condition } { body }` runs the body as long as the condition holds; with layout, the body is the indented
block below:

```koka
fun halvings(start : int) : div int
  var n := start
  var count := 0
  while { n > 1 }
    n := n / 2
    count := count + 1
  count
```

Both the condition and the body are functions: the braces around the condition matter, because it is evaluated
again before every round.

## `while` and `div`

Look at the type of `halvings`: `div int`. Koka cannot know that a `while` loop ever stops — it depends on the
condition — so a function containing one has the `div` (divergence) effect, just like a function recursing on a
number. `for`, `foreach` and `repeat` always stop, so they add no `div`.

## When to use them

Lists, recursion and higher-order functions remain the usual way to compute in Koka; a `var` and a loop are for
the cases where they read more simply, such as tracking several running values at once. The two styles mix
freely: the body of a `foreach` is just a lambda.

## Pitfalls

- `var x = 0` is a syntax error: declare with `var x := 0`.
- `val` names cannot be assigned; only `var`s can.
- A `while` needs `div` in the function's type, and a condition that becomes false, or it runs forever.
- Positions from `foreach-indexed` start at 0.
