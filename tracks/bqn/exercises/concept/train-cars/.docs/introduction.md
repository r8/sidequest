# Introduction

BQN has a small family of functions that cut lists apart and move their elements around without looking at
them: take `↑`, drop `↓`, reverse and rotate `⌽`, and the shifts `»` and `«`. All of them keep the elements in
their original order apart from the move they make.

## Take and drop

`n ↑ list` takes the first `n` elements; `n ↓ list` drops them and keeps the rest. A negative count works from
the other end:

```bqn
t ← 10‿20‿30‿40‿50
2 ↑ t      # ⟨10, 20⟩
¯2 ↑ t     # ⟨40, 50⟩: the last two
2 ↓ t      # ⟨30, 40, 50⟩
¯2 ↓ t     # ⟨10, 20, 30⟩: all but the last two
```

Dropping more elements than there are gives an empty list, `9 ↓ t` is `⟨⟩`. Taking more than there are does not
fail: it pads the list with a _fill_ element, which is `0` for a list of numbers (and a space for a string).
With a negative count the padding goes at the front:

```bqn
7 ↑ t      # ⟨10, 20, 30, 40, 50, 0, 0⟩
¯7 ↑ t     # ⟨0, 0, 10, 20, 30, 40, 50⟩
```

So `n ↑ list` always has exactly `n` elements, which makes take handy for fixing a length. The count must be a
whole number; `2.5 ↑ t` is an error.

A count usually comes from a computation. Remember that functions take everything on their right: `-𝕨 ↓ 𝕩`
negates the result of the drop. Put the count in parentheses, `(-𝕨) ↓ 𝕩`.

## Reverse and rotate

`⌽ list` reverses a list. With a left argument, `n ⌽ list` rotates it: the first `n` elements move to the end,
as if the list were a ring. A negative count rotates the other way, and the count wraps around the length:

```bqn
⌽ t        # ⟨50, 40, 30, 20, 10⟩
2 ⌽ t      # ⟨30, 40, 50, 10, 20⟩
¯1 ⌽ t     # ⟨50, 10, 20, 30, 40⟩
7 ⌽ t      # ⟨30, 40, 50, 10, 20⟩, the same as 2 ⌽ t
```

Rotating never loses an element; every element is still there, only the starting point has moved.

## Shifts

`»` and `«` shift a list one place to the right or left, keeping its length: an element falls off one end and a
fill element comes in at the other.

```bqn
» t        # ⟨0, 10, 20, 30, 40⟩
« t        # ⟨20, 30, 40, 50, 0⟩
```

With a left argument, the left argument is what is shifted in instead of the fill, and as many elements fall
off the other end as come in:

```bqn
5 » 1‿2‿3         # ⟨5, 1, 2⟩
8‿9 » 1‿2‿3       # ⟨8, 9, 1⟩
1‿2‿3 « 8‿9       # ⟨2, 3⟩: 8‿9 followed by 1‿2‿3, keeping the last two
```

The arrow points the way the elements move: in `x » list`, `x` enters from the left and the list moves right.

## Putting them together

These functions combine well with join `∾`. To keep the first element in place and reverse the rest, take it
off, reverse what is left and join them again:

```bqn
(1 ↑ t) ∾ ⌽ 1 ↓ t    # ⟨10, 50, 40, 30, 20⟩
```

Each of these functions returns a new list. The original list is never changed, so `t` is still
`10‿20‿30‿40‿50` after all of the above.
