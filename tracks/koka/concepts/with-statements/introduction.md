# Introduction

A `with` statement passes the rest of its block, as a function, to the call it names:

```koka
with twice           // twice(fn() { println("hi") })
println("hi")

with x <- xs.foreach // xs.foreach(fn(x) { println(x.show) })
println(x.show)
```

The first `with` is the outermost call, so a column of `with` statements replaces a staircase of nested
trailing lambdas. It works with any function whose last parameter is a function, including your own. The body
runs to the end of the block, so put a `with` inside its own block (or use `with … in expr`) when code must follow
it, and bind a single name before `<-`, not a pattern.
