# About

## Reverse and rotate

`⌽` reverses the first axis of its argument: the order of a list's elements, or the order of a table's rows (not
the characters in each row). Reversing twice gives back the original.

`n ⌽ l` rotates by `n`, wrapping modulo the length, so `(n + ≠l) ⌽ l` is the same as `n ⌽ l` and rotating an
empty list does nothing. Nothing is lost, unlike `↓`. On a table, a list of counts rotates several axes at once:
`1‿2 ⌽ table` rotates the rows by one and the columns by two.

## Shifts

`» l` and `« l` shift by one place and fill the gap with the fill element (`0` or a space). With a left argument,
`x » l` joins `x` in front and keeps the first `≠l` elements, while `x « l` joins `x` at the back and keeps the
last `≠l`. The result always has the length of the right argument.

Shifts are the array way to compare each element with its neighbour:

```bqn
l ← 3‿5‿4‿8
l - » l     # ⟨3, 2, ¯1, 4⟩: each element minus the one before (0 before the first)
(« l) - l   # ⟨2, ¯1, 4, ¯8⟩: the next element minus each one
```

When the boundary value matters, give it explicitly: `(⊑l) » l` repeats the first element instead of using `0`.

## Choosing between them

- Use `⌽` with a count when every element must survive, as in a ring buffer or a cipher alphabet.
- Use `»` and `«` when the list must keep its length and elements may fall off, as in a sliding window or a
  comparison with neighbours.
- Use `↑` and `↓` when the length should change.
