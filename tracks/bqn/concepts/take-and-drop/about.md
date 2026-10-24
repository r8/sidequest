# About

## Counts

The left argument of `↑` and `↓` is a whole number; a fraction is an error. Positive counts work from the
front and negative ones from the back. A count of zero takes nothing (`0 ↑ l` is empty) or drops nothing.

`↓` never pads: dropping at least as many elements as the list has gives an empty list. `↑` always returns
exactly `|n` elements, padding with the list's fill element when it runs out: zeros for numbers, spaces for
characters.

```bqn
7 ↑ 1‿2‿3       # ⟨1, 2, 3, 0, 0, 0, 0⟩
¯3 ↑ "ab"       # " ab"
```

Fills are a property of the array, not of the elements; a list whose elements are themselves lists may have no
known fill, and overtaking it is then an error (`Fill element of 𝕩 needed for overtaking`). Prefer taking at most
`≠list` elements from such lists, or join the padding yourself.

## Several axes

On a table or higher-rank array, a list of counts applies one count per leading axis: `2‿1 ↑ table` is the top
left 2-by-1 corner, and `1 ↓ table` drops the first row. Axes without a count are kept whole.

## Monadic forms

Without a left argument, `↑ list` gives every prefix and `↓ list` every suffix:

```bqn
↑ 1‿2‿3    # ⟨⟨⟩, ⟨1⟩, ⟨1, 2⟩, ⟨1, 2, 3⟩⟩
↓ 1‿2‿3    # ⟨⟨1, 2, 3⟩, ⟨2, 3⟩, ⟨3⟩, ⟨⟩⟩
```

## Idioms

- `(-n) ↓ l` removes the last `n` elements; the parentheses are needed because `-n ↓ l` negates the result.
- `(1 ↑ l) ∾ x ∾ 1 ↓ l` inserts `x` after the first element.
- `n ↑ l` with `n ≥ ≠l` pads a list to a fixed width, as when padding a string with spaces.
