# Introduction

A recursive type has constructors whose fields mention the type itself, so its values can be any size:

```koka
type tree
  Leaf
  Node(left : tree, value : int, right : tree)
```

Values are built by nesting constructors, `Node(Node(Leaf, 3, Leaf), 5, Leaf)`, and at least one constructor
(`Leaf`) must not mention the type. Functions over such a type match on it and call themselves on the parts the
pattern gives them:

```koka
fun total(t : tree) : int
  match t
    Leaf -> 0
    Node(l, v, r) -> total(l) + v + total(r)
```

Recursion on matched parts is structural, so Koka knows it terminates and the function stays total, without `div`.
