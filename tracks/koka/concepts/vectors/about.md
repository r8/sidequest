# About

## Lists or vectors

Lists are Koka's everyday sequence: they are built and taken apart by pattern matching, grow at the front in
constant time, and share their tails. Vectors suit data of a fixed size that is read by position — a board, a row
of seats, a lookup table — because `v[i]` and `v.length` take constant time, where a list needs time proportional
to the index or the length.

## Making and converting

| Expression | Result |
| --- | --- |
| `vector(n, x)` | `n` copies of `x` |
| `vector-init(n, f)` | `f(0)`, …, `f(n - 1)`; `f` may have effects |
| `vector-init-total(n, f)` | the same, for a total `f` |
| `xs.vector` | the elements of the list `xs` |
| `v.list` | the elements of `v` as a list |
| `vector/empty()` | a vector with no elements |

Vectors have no `show`, `==` or `cmp`; compare and print `v.list`.

## Reading

`v[i]` has the `exn` effect: past the end it throws `index out of bounds` (with the `ExnRange` info).
`v.at(i)` is total and returns `Nothing` instead. In Koka 3.2.9 neither rejects a negative index — the result is
undefined — so guard indices that can be negative with `i >= 0`.

## Traversing

`foreach`, `foreach-indexed` and `foreach-while` run a function on the elements in order; `map` builds a new
vector. For anything more, such as `filter` or `foldl`, convert to a list.

## Updating in place

A vector, like every Koka value, is immutable from the outside: a function given a vector cannot change what its
caller sees. Inside a function, a vector held in a `var` can be assigned to by index:

```koka
fun swap-ends(v : vector<a>) : exn vector<a>
  var w := v
  val first = w[0]
  w[0] := w[w.length - 1]
  w[w.length - 1] := first
  w
```

Koka manages memory by reference counting (Perceus). When `w` holds the only reference to the vector, `w[i] := x`
writes into it directly; when the vector is shared — the caller still uses it — the first assignment copies it.
So `v.swap-ends` costs a copy if `v` is used afterwards and nothing otherwise. Writing code so that big vectors are
not shared while they are updated is what makes such functions run as fast as their imperative counterparts.
