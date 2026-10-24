# About

## The type

`list<a>` is a type with two constructors, defined in `std/core/types`:

```koka
type list<a>
  Nil
  Cons(head : a, tail : list<a>)
```

So a list is a chain of `Cons` cells ending in `Nil`, and `[x, y]` is notation for `Cons(x, Cons(y, Nil))`. The
lesson on pattern matching shows how to take a list apart by these two shapes, which is how most list functions
are written.

## Costs

Because a list is a chain, the front is cheap and everything else walks the chain:

| operation | cost |
| --- | --- |
| `Cons(x, xs)` | constant: the new list shares `xs` |
| `xs ++ ys` | proportional to `xs.length` (it is copied); `ys` is shared |
| `xs.length`, `xs.contains(x)`, `xs.reverse`, `xs.sum` | proportional to the length |
| `xs.take(n)`, `xs.drop(n)` | proportional to `n` |

Building a long list by repeatedly appending at the end is therefore slow; build it at the front and `reverse`
it once at the end. (Koka can often reuse a list's cells in place when nothing else refers to it, which a later
lesson on FBIP explains, but the costs above are the ones to plan for.)

## Common functions

From `std/core/list`, all usable with dot-selection:

- `length`, `is-empty`, `reverse`, `++` (also `append`), `concat` (a list of lists into one);
- `take(n)`, `drop(n)`, `split(n)` (both at once, as a pair);
- `sum`, `minimum`, `maximum` (for `list<int>`; `0` for an empty list);
- `contains(x)`, for element types that have `==`;
- `join(sep)` and `join()` for `list<string>`;
- `replicate(x, n)`, a list of `n` copies of `x`;
- `list(lo, hi)` and `list(lo, hi, stride)`, ranges of integers (`list(5, 1)` is `[]`).

`take` and `drop` are forgiving: they stop at the end of the list rather than failing.

Many more list functions take another function as an argument — `map`, `filter`, `foldl`, `any`, `all`,
`find`. They are the subject of the lesson on higher-order functions.

## Partial functions return maybe

`head`, `last` and indexing `xs[i]` return a `maybe<a>`: `Just(x)` when there is such an element, `Nothing`
when there is not. Koka has no exception-throwing `head`.

## Equality and showing

Two lists are `==` when they have the same elements in the same order (for element types that have `==`), and
`show` gives `"[1,2,3]"` (strings in the list are shown quoted). Both are found through implicit parameters, a
later lesson.

## Empty lists and inference

`[]` has the type `list<a>` for any `a`. When nothing else fixes the element type — an `assert-equal([], …)`
with nothing typed, or a `val` that is never used — annotate it: `([] : list<int>)`.
