# About

## Inductive data

`list<a>` is the standard library's recursive type (`Nil`, or `Cons(head, tail)` with a `list<a>` tail), and any
type may refer to itself in the same way: trees, expressions, file systems, JSON values. Koka calls these
_inductive_ types: every value is finite, built up from the constructors that do not mention the type.

```koka
pub type json
  JNull
  JNum(n : int)
  JText(s : string)
  JArray(items : list<json>)
```

A type may also be recursive through another type, as `json` is through `list<json>`.

## Structural recursion and termination

The natural function over a recursive type has one branch per constructor and recurses on the fields of the
matched value. Koka recognises that pattern: a function whose recursive calls all take a sub-term of its argument
must terminate, so its inferred effect is `total`. Any other recursion — on the whole argument, on a value
computed from it, or through a group of mutually recursive functions — gets the `div` effect, which the function's
type then has to declare:

```koka
fun count(j : json) : div int
  match j
    JArray(items) -> 1 + count-all(items)
    _ -> 1

fun count-all(js : list<json>) : div int
  match js
    Nil -> 0
    Cons(j, rest) -> count(j) + count-all(rest)
```

Passing the function to a higher-order function, as in `items.map(count)`, is not structural either, and also
needs `div`.

## Transforming

Since values never change, a transformation rebuilds the structure: match, transform the parts, apply a
constructor to the results. Unchanged parts can be returned as they are — matching `Num -> e` and returning `e`
shares the original value instead of building a copy. When the result depends on the transformed parts, match on
a tuple of them:

```koka
match (simplify(l), simplify(r))
  (Num(0), r2) -> r2
  (l2, r2) -> Add(l2, r2)
```

Koka's reference counting reuses the memory of a matched constructor for the new one when the old value is not
shared, so such rebuilding is often done in place (see the FBIP lesson).

## Deep patterns

Patterns nest as deep as the data: `Node(Leaf, v, Leaf)` recognises a single-value tree, `Add(Num(0), x)` an
addition of zero. Branches are tried top to bottom.

## Stack depth

Each non-tail recursive call uses stack space, so a very deep structure — a degenerate tree a million levels
deep — needs a deep stack. Balanced trees and expressions typed by people are never that deep; for lists, Koka's
standard functions are written to avoid the problem.
