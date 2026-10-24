# Introduction

Koka frees memory with Perceus reference counting, which also tells it at runtime when a value is referenced
only once. A function that matches on such a unique value can reuse the matched cell's memory for a new
constructor of the same size, so purely functional code updates data in place; when the value is shared, it is
copied instead and the original is left intact.

Writing code that allows this is FBIP, _functional but in-place_: match, and in each branch rebuild constructors
of the same size from the parts, using each part once.

```koka
type tree
  Node(left : tree, value : int, right : tree)
  Leaf

fbip fun mirror(t : tree) : tree
  match t
    Node(l, v, r) -> Node(mirror(r), v, mirror(l))
    Leaf -> Leaf
```

`fip fun` asks the compiler to check that a function allocates and frees nothing and uses constant stack;
`fbip fun` allows freeing and stack use; `fip(n)` allows `n` allocations. Broken promises are warnings.
