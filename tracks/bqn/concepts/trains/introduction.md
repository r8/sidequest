# Introduction

A train is a sequence of functions with no argument to their right. It defines a new function:

```bqn
(F G H) x    ←→  (F x) G (H x)          # 3-train, or fork
w (F G H) x  ←→  (w F x) G (w H x)
(G H) x      ←→  G (H x)                # 2-train, or atop
w (G H) x    ←→  G (w H x)
```

`+´ ÷ ≠` is the mean, `⌈´ - ⌊´` the range, and `+´ <` (called with two arguments) counts the values above a
mark. Longer trains split into 3-trains from the right, so `⊢ - +´ ÷ ≠` is `⊢ - (+´ ÷ ≠)`: each value minus
the mean. `⊢` and `⊣` stand for the right and left arguments, and the leftmost part of a 3-train may be a
constant, as in `1 + ⊢`.
