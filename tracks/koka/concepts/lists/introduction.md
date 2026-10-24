# Introduction

A `list<a>` is an immutable, ordered sequence of values of one type `a`. It is either empty, `Nil` (or `[]`), or
`Cons(x, rest)`: an element in front of another list. The literal `[1, 2, 3]` is shorthand for
`Cons(1, Cons(2, Cons(3, Nil)))`.

```koka
val songs = ["Blue", "Red"]
Cons("Gold", songs)      // ["Gold", "Blue", "Red"]
songs ++ ["Gold"]        // ["Blue", "Red", "Gold"]
```

Operations return new lists and never change the old one. Everyday functions include `length`, `is-empty`,
`reverse`, `take`, `drop`, `sum`, `contains`, `join` (for `list<string>`) and `list(lo, hi)`.
