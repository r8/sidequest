# Introduction

## Lists

A list holds any number of values of one type, in order. Its type names the type of its elements in angle
brackets: `list<int>` is a list of integers, `list<string>` a list of strings. A list literal is written in
square brackets:

```koka
val primes = [2, 3, 5, 7]           // list<int>
val colors = ["red", "green"]       // list<string>
val nothing : list<int> = []
```

All the elements must have the same type: `[1, "two"]` is a type error.

## How lists are built

A list is either empty, written `Nil` (or `[]`), or an element followed by the rest of the list, written
`Cons(element, rest)`. `[1, 2, 3]` is just a shorter way to write

```koka
Cons(1, Cons(2, Cons(3, Nil)))
```

So `Cons` puts an element at the front of an existing list. It does this without copying: the new list shares
the old one as its rest, which makes adding to the front cheap however long the list is.

```koka
val rest = [2, 3]
Cons(1, rest)     // [1, 2, 3]
```

Lists are immutable. No operation changes a list; operations return a new list, and the original stays as it
was. `rest` above is still `[2, 3]`.

## Working with lists

The standard library has many list functions, usually called with dot-selection:

| expression | result |
| --- | --- |
| `[1, 2] ++ [3]` | `[1, 2, 3]`, the two lists joined |
| `[5, 6, 7].length` | `3` |
| `[].is-empty` | `True` |
| `[1, 2, 3].reverse` | `[3, 2, 1]` |
| `[1, 2, 3].take(2)` | `[1, 2]`, the first two elements |
| `[1, 2, 3].drop(2)` | `[3]`, all but the first two |
| `[4, 5, 6].sum` | `15`, for a `list<int>` |
| `[4, 5, 6].contains(5)` | `True` |
| `list(1, 4)` | `[1, 2, 3, 4]`, the integers from 1 to 4 |

`take` and `drop` never fail: taking more elements than a list has gives the whole list, and dropping more gives
`[]`.

`++` copies its left list (it has to build a new list that ends in the right one), so adding at the end of a
long list costs more than adding at the front with `Cons`.

### Lists of strings

`join(separator)` joins a `list<string>` into one string, with the separator between the elements:

```koka
["red", "green", "blue"].join(", ")    // "red, green, blue"
["a", "b"].join                         // "ab"
```

Lists can be shown too: `[1, 2].show` is `"[1,2]"`.

### First and last

Asking for the first or the last element of a list, with `head` or `last`, cannot always succeed — the list may
be empty — so those functions return a _maybe_ value rather than an element. The lesson on maybe explains how to
use them; this lesson does not need them.

## Pitfalls

- An empty list on its own has no element type to infer. Where Koka cannot tell it from the context, annotate
  it: `val none : list<string> = []`.
- `xs ++ [x]` needs the brackets: `++` joins two lists, and `x` alone is not a list.
- Every operation returns a new list; `songs.reverse` on a line of its own changes nothing. Bind or return the
  result.
