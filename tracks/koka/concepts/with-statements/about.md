# About

## The translation

`with` is pure syntax. It takes every statement after it, up to the end of the enclosing block, and turns them
into a function passed as the last argument of its call:

| written | means |
| --- | --- |
| `with f(a, b)` ⏎ `rest` | `f(a, b, fn() { rest })` |
| `with f` ⏎ `rest` | `f(fn() { rest })` |
| `with x <- f(a)` ⏎ `rest` | `f(a, fn(x) { rest })` |
| `with x <- xs.foreach` ⏎ `rest` | `xs.foreach(fn(x) { rest })` |

Consecutive `with` statements nest, the first one outermost:

```koka
with r <- for(1, rows)
with c <- for(1, cols)
println(r.show ++ "," ++ c.show)
```

is `for(1, rows) fn(r) for(1, cols) fn(c) println(…)`.

## Scope

The body of a `with` is _everything_ below it in its block, so a final `result` line written after it is part of
the body too. The usual cure is to start a block of its own, with a trailing lambda or a helper function:

```koka
fun total(xs : list<int>) : int
  var sum := 0
  xs.foreach fn(x)
    with twice
    sum := sum + x
  sum
```

`with … in expr` scopes a `with` to a single expression: `with twice in sum := sum + 1`.

## Bindings

The binding before `<-` is one name. A tuple pattern there is not supported (Koka 3.2 even fails with an internal
error); bind a name and destructure it with `val (a, b) = pair` on the next line. When the compiler cannot work
out the parameter's type early enough to resolve an overloaded name such as `show`, annotate it:
`with r : int <- for(1, n)`.

## Building control structures

Because `with` accepts any function whose last parameter is a function, small higher-order functions read like
new statements:

```koka
fun twice(action : () -> e ()) : e ()
  action()
  action()

fun retry-later() : console ()
  with twice
  println("trying…")
```

Give such functions effect-polymorphic parameter types (`() -> e ()`) so the body may use `var`s, print, or
throw.

## With handlers

The main use of `with` is installing effect handlers: a handler is a function that takes the computation it
handles as its last argument, so `with handler { … }` handles the rest of the block. Koka also lets the
`handler` keyword be dropped for one operation (`with fun op(x) …`, `with val v = …`, `with ctl op() …`), and
`with finally { … }` runs clean-up code when the rest of the block finishes. The lessons on effect handlers use
all of these.
