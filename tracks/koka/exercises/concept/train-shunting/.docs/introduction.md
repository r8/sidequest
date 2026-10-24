# Introduction

## Reference counting

Koka manages memory with _Perceus_ reference counting. The compiler inserts the bookkeeping: every heap value
(a `Cons` cell, a `Node`, a tuple) knows how many references to it exist, and the moment the count drops to zero
its memory is freed. There is no garbage collector that runs now and then.

Counting has a useful side effect: at runtime Koka knows when a value is _unique_, referenced only once. When a
function matches on a unique value and the matched cell is not needed any more, its memory can be _reused_ for a
new constructor of the same size built in that branch, so a new value costs no allocation at all:

```koka
type tree
  Node(left : tree, value : int, right : tree)
  Leaf

fun mirror(t : tree) : tree
  match t
    Node(l, v, r) -> Node(mirror(r), v, mirror(l))
    Leaf -> Leaf
```

If the tree passed to `mirror` is unique, each `Node` is updated in place: purely functional code, running like
an imperative one. If the tree is still used elsewhere, the cells are shared, so Koka copies them instead, and
the old tree stays as it was. You do not choose between a persistent and an in-place version; the same function
is both, depending on how it is called.

Writing code so that this reuse can happen is called FBIP: _functional but in-place_. The recipe is to match on
a value, and in each branch build constructors of the same size as the ones matched, using each matched variable
once.

## Checking it: `fip` and `fbip`

Reuse happens without any annotation. To have the compiler check that a function is written in this style, put
a keyword in front of `fun`:

- `fip fun` — _fully in-place_: if its arguments are unique, the function allocates nothing, frees nothing, and
  runs in constant stack space. It may only call other `fip` functions.
- `fbip fun` — the weaker form: it allocates nothing, but may free memory and use stack space for recursion.

```koka
fip fun swap(p : (a, b)) : (b, a)
  match p
    (x, y) -> (y, x)

fbip fun mirror(t : tree) : tree
  match t
    Node(l, v, r) -> Node(mirror(r), v, mirror(l))
    Leaf -> Leaf
```

`mirror` is `fbip` rather than `fip` because its first recursive call is not a tail call, so it needs stack.

A recursive call that is the last thing a branch does is a loop and uses no stack. That includes a call that is
the last field of a constructor, such as `Cons(x, f(rest))`: Koka compiles this _tail recursion modulo cons_ into
a loop as well.

When a function breaks the rules, the compiler says so with a **warning**, not an error, naming the problem:

```koka
fip fun prepend-zero(xs : list<int>) : list<int>
  Cons(0, xs)
// warning: fip fun prepend-zero: function allocates at most 1 but was declared as allocating nothing
```

`fip(n)` and `fbip(n)` allow up to `n` allocations, for functions that must build something new, so
`fip(1) fun prepend-zero` is accepted.

## Owned and borrowed parameters

A `fip` function owns its parameters: it must use each one exactly once, either passing it on or reusing its
memory. A variable left unused would be freed, and the compiler warns ("the variable xs is unused (causing
deallocation)"). A parameter the function only looks at can be marked _borrowed_ with `^`: the caller keeps
ownership, and the function may read it without consuming it:

```koka
fip fun all-positive(^xs : list<int>) : bool
  match xs
    Cons(x, rest) -> x > 0 && all-positive(rest)
    Nil -> True
```

Small integers, characters, booleans and constructors without fields (`Nil`, `Leaf`) are not heap cells, so
they can be used, or left unused, freely.

## Pitfalls

- A wildcard `_` that matches a heap value, or a branch that returns the matched value itself while another
  branch takes it apart, frees or shares memory: name the parts and rebuild them instead.
- Reuse needs uniqueness at runtime. Keeping another reference to a value (using it again after the call) makes
  the call copy instead; the result is still right, only slower.
- The warnings appear when the module is compiled (`koka -l <file>` compiles one on its own). Read them: they are
  the only sign that a `fip` promise is not kept.
