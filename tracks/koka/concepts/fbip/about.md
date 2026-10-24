# About

## Perceus

Koka compiles to C and manages memory with Perceus, a precise reference-counting scheme. The compiler inserts
`dup` and `drop` operations so that every heap cell is freed as soon as its last reference disappears, and it
moves the `drop`s as early as possible. There is no tracing garbage collector and no pause.

Because the counts are precise, a cell with a count of one is known to be _unique_. Perceus uses that in _reuse
analysis_: when a branch of a `match` takes apart a cell that is unique and builds a constructor of the same
size, the old cell's memory is reused for the new one. The check for uniqueness happens at runtime, so the same
code updates in place when it can and copies when the value is shared, keeping the persistence of immutable
data.

## The FBIP style

Functional-but-in-place code follows a few rules:

- match on the data being transformed, and use every bound variable exactly once;
- in each branch, build constructors of the same size as the ones matched (a `Cons` for a `Cons`, a `Node` for
  a `Node`), so each can reuse a matched cell;
- recurse with tail calls, using accumulators or zippers instead of the call stack. A recursive call that is the
  last field of a constructor (`Cons(x, f(rest))`) also counts: Koka compiles _tail recursion modulo cons_ into a
  loop.

Algorithms that look imperative — in-place list reversal, tree insertion, red-black tree rebalancing, even
tree traversals with constant stack (via a zipper, as in Morris traversal) — can be written this way. The Koka
book's FBIP section and the `samples/learn/fip.kk` and `samples/basic/rbtree-fbip.kk` samples show examples.

## Annotations

| Keyword | Allocation | Deallocation | Stack |
|---|---|---|---|
| `fip fun` | none | none | constant |
| `fbip fun` | none | allowed | any |
| `fip(n) fun`, `fbip(n) fun` | at most `n` constructors | as above | as above |

The guarantee holds when the function's owned parameters are unique at runtime; with shared arguments the
function still works, copying where needed. A `fip` function may only call `fip` functions (or its borrowed
function parameters).

Violations are reported as **warnings**, each naming the problem: "function allocates at most 1 but was
declared as allocating nothing", "the variable xs is unused (causing deallocation)", "the matched constructor
Cons is not reused", "non-tail call to a (mutually) recursive function", "calling a non-fip function".

## Borrowing

Parameters are owned by default: the function is responsible for them, and one it does not use is dropped. A
parameter marked with `^` is _borrowed_: the caller keeps ownership, the function may inspect it but not reuse
it, and no reference-count traffic is needed for it. Borrowing suits values a function only reads, such as a
comparison function (`^?cmp : (a, a) -> order`) or a list it only scans:

```koka
fip fun all-positive(^xs : list<int>) : bool
  match xs
    Cons(x, rest) -> x > 0 && all-positive(rest)
    Nil -> True
```

## Pitfalls

- Using a value again after passing it to an in-place function makes it shared, so the call copies. Order
  matters: compute what you need from the old value (its length, say) after the last use of it, or before
  passing it on.
- A wildcard `_` over a heap value drops it, and returning the matched value itself from one branch while
  another takes it apart shares it; rebuild it from its parts instead.
- Annotations only check; reuse happens with or without them.
