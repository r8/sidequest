# Introduction

## Types that contain themselves

A constructor's fields can have any type — including the type being declared. Such a _recursive type_ describes
data of any size built from smaller pieces of the same kind. The list is the best-known example: a `list<a>` is
either `Nil` or a `Cons` holding one element and _another list_. Your own types can do the same:

```koka
type tree
  Leaf
  Node(left : tree, value : int, right : tree)
```

A `tree` is either an empty `Leaf`, or a `Node` with a value and two smaller trees. Values are built from the inside
out, by nesting constructor calls:

```koka
val small = Node(Leaf, 3, Leaf)
val bigger = Node(small, 5, Node(Leaf, 8, Leaf))
//        5
//       / \
//      3   8
```

There must be at least one constructor that does not mention the type (here `Leaf`), or no value could ever be
finished.

## Recursion follows the type

A function over a recursive type usually has one branch per constructor and calls itself on the smaller pieces —
exactly as a function on lists calls itself on the tail:

```koka
fun total(t : tree) : int
  match t
    Leaf -> 0
    Node(l, v, r) -> total(l) + v + total(r)
```

Read it as a definition: the total of an empty tree is 0, and the total of a node is the totals of its two
subtrees plus its own value. Each call works on a part of its argument, so the recursion always reaches the
leaves and stops.

Koka sees that too. Recursion on a pattern-matched part of the argument is _structural_, and a function that only
recurses structurally is known to terminate: its type stays `int`, with no `div` effect, even though it calls
itself twice. Recursion on something computed, like `n - 1`, is what needs `div`.

## Building new trees

Functions can return recursive values as well as consume them. To transform a tree, match on it, transform the
pieces recursively, and put them back together with a constructor:

```koka
fun double-all(t : tree) : tree
  match t
    Leaf -> Leaf
    Node(l, v, r) -> Node(double-all(l), v * 2, double-all(r))
```

Nothing is modified; the result is a new tree of the same shape.

Sometimes the new value depends on what the transformed pieces turned out to be. Matching on a tuple of the
results looks at both at once:

```koka
fun prune(t : tree) : tree
  match t
    Leaf -> Leaf
    Node(l, v, r) ->
      match (prune(l), prune(r))
        (Leaf, Leaf) | v == 0 -> Leaf        // a lone zero disappears
        (pl, pr) -> Node(pl, v, pr)
```

## Patterns can look deep

Since the fields of a constructor are themselves patterns, one branch can recognise a whole shape:

```koka
match t
  Node(Leaf, v, Leaf) -> "a single value " ++ v.show
  Node(Node(_, a, _), b, _) -> "has a left child " ++ a.show ++ " under " ++ b.show
  _ -> "something else"
```

## Pitfalls

- **Forgetting the base case.** Every constructor needs a branch; the ones without the type in their fields are
  where the recursion ends.
- **Recursing on the whole value.** Calling `total(t)` inside `total(t)` never ends, and Koka will demand `div` in
  the type. Recurse on the parts the pattern gave you.
- **Mutual recursion.** When two functions call each other (one for a tree, one for a list of trees, say), Koka
  cannot prove they stop and infers `div` for both.
- **Missing `show` and `==`.** As with every type you declare, Koka does not write them for you; a recursive
  `show` is a function like `total` that builds a string.
