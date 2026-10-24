# About

## The rule

`e.f(a, b)` is `f(e, a, b)`, and `e.f` is `f(e)`. That is all dot-selection is: syntax for a call. Any function
can be called either way — the standard library's, your own, local functions — and named and default arguments
work as usual: `3.postage(express = True)` is `postage(3, express = True)`.

## Why it matters

Koka has no classes or methods, yet code reads much like method chaining in object-oriented languages, because
library functions put "the thing being worked on" first:

```koka
"  Hello  ".trim.to-upper.count     // count(to-upper(trim("  Hello  "))), which is 5
[3, 1, 2].reverse.take(2)           // take(reverse([3, 1, 2]), 2)
```

Each step's result becomes the next step's first argument, in reading order.

## Precedence

Dot-selection binds more tightly than any operator, so it applies to the atom just before the dot:

| written | means |
| --- | --- |
| `1 + 2.double` | `1 + double(2)` |
| `(1 + 2).double` | `double(1 + 2)` |
| `-4.abs` | `abs(-4)` — `-4` is a single literal |
| `x.f.g(y)` | `g(f(x), y)` |

## Overloaded names

When several functions share a name, such as `show` or `count` for different types, Koka chooses by the type of
the value before the dot, just as it would for the first argument of an ordinary call. Dot-selection also
works with qualified names: `x.int/show`.

## Style

Prefer dot-selection for pipelines and for functions with an obvious subject (`s.count`, `xs.length`,
`n.is-even`), and the plain form for functions of equal arguments (`max(a, b)`, `area(w, h)`) or when the first
argument is a long expression.
