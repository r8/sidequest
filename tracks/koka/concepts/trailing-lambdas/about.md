# About

## The syntax

A call `f(a, b, fn(x) body)` can be written `f(a, b) fn(x) body`. If no arguments remain in the parentheses,
they go too: `xs.map(fn(x) …)` becomes `xs.map fn(x) …`. The lambda's body can continue on indented lines:

```koka
val labels = xs.map fn(x)
  val doubled = x * 2
  doubled.show ++ " apples"
```

A zero-parameter function may be written as a block: `{ body }` means `fn() body`, and it can trail a call
just the same, as `repeat(3) { println("hi") }` or `test("name") { assert-true(x) }` do. Blocks can also
span several indented lines between their braces.

## Why it matters

Trailing lambdas make higher-order functions read like built-in control structures. Koka has very few
statements of its own: loops such as `for` and `while` and even exception handlers are library functions
taking a function as their last argument, and trailing lambdas make calling them look natural. A later lesson
shows the `with` statement, which goes one step further and turns the rest of a block into the trailing
lambda.

## Style

- Use the trailing form for lambdas longer than a few words, and always for multi-line bodies.
- Keep short lambdas inside the parentheses when more arguments follow or when the call is part of a longer
  expression: `xs.map(fn(x) x + 1).sum`.
- Several function arguments can trail when each is delimited by braces: `both(1) { 2 } { 3 }`, or
  `pair(x) fn(a){ a + 1 } fn(b){ b * 2 }`. This is how `while { n > 0 } { … }` passes its condition and its
  body. A `fn` without braces runs to the end of its body, so it can only be the last.
