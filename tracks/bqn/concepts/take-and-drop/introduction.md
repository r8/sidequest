# Introduction

`n ↑ list` takes the first `n` elements of a list and `n ↓ list` drops them, keeping the rest. A negative count
works from the end: `¯2 ↑ list` is the last two elements, `¯2 ↓ list` all but the last two.

```bqn
2 ↑ 10‿20‿30‿40    # ⟨10, 20⟩
¯1 ↓ 10‿20‿30‿40   # ⟨10, 20, 30⟩
```

Dropping more than there is gives an empty list. Taking more than there is pads with a fill element (`0` for
numbers, a space for strings), at the back for a positive count and at the front for a negative one, so
`n ↑ list` always has length `|n`.
