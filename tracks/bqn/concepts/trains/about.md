# About

## Forks and atops

A **3-train** `F G H` applies `F` and `H` to the arguments and combines the results with `G`. A **2-train**
`G H` applies `G` to the result of `H`. Both work with one or two arguments, passing every argument to the
outer functions (`F` and `H`); `G` only ever sees their results.

| train | `x` | `w … x` |
| --- | --- | --- |
| `F G H` | `(F x) G (H x)` | `(w F x) G (w H x)` |
| `G H` | `G (H x)` | `G (w H x)` |
| `n G H` | `n G (H x)` | `n G (w H x)` |

## Reading long trains

A train is split into 3-trains from the right: `A B C D E` is `A B (C D E)`, and `B C D E` is
`B (C D E)`. The parts in odd positions from the right (the 1st, 3rd, 5th, …) are applied to the arguments;
the parts between them combine. An even-length train has a 2-train at its left end.

When a train gets hard to read, name its pieces: `Mean ← +´÷≠` and then `Deviations ← ⊢ - Mean` is easier than
the five-part version.

## Constants and Nothing

The leftmost part of a 3-train can be a subject: `(1 + ⊢)`, `("> " ∾ ⊢)`. A subject anywhere else is not part
of a train: `⊢ + 1` evaluates `+ 1` at once. Use a bound function (`+⟜1`) or the constant modifier (`1˙`) to
put a constant on the right: `(⊢ + 1˙)`.

`·` (Nothing) as the left part of a 3-train makes it a 2-train: `(· F G)` is `(F G)`. It exists so that a
train can always be written in 3-train groups; most people write the 2-train directly.

## Trains or combinators

`F∘G`, `F⊸G` and `F⟜G` can all be written as trains, and vice versa:

| combinator | train, one argument | train, two arguments |
| --- | --- | --- |
| `F∘G` | `F G` | `F G` |
| `F⊸G` | `F G ⊢` | `(F⊣) G ⊢` |
| `F⟜G` | `⊢ F G` | `⊣ F (G⊢)` |
| `F○G` | `F G` | `(G⊣) F (G⊢)` |

Choose by what reads best: trains for "this combined with that", combinators for "first do this".

## Common trains

- `+´÷≠`: mean
- `⌈´-⌊´`: range
- `+´<` and `+´=`: count values above, count equal values
- `⊢÷+´`: fractions of the total
- `∧´∘∊`: are all elements of `w` in `x`

## Pitfalls

- A train only forms where there is no argument: `(+´÷≠) 1‿2` works, `+´÷≠ 1‿2` does not.
- Every outer part gets both arguments in a dyadic call. Use `⊣` or `⊢` to pick one: `+´∘⊣` sums `w` only.
