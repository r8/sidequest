# Introduction

`⌽ list` reverses a list. `n ⌽ list` rotates it as a ring: the first `n` elements move to the end, and a
negative `n` moves the last elements to the front. The count wraps around the length.

```bqn
⌽ 1‿2‿3‿4       # ⟨4, 3, 2, 1⟩
1 ⌽ 1‿2‿3‿4     # ⟨2, 3, 4, 1⟩
```

The shifts keep a list's length while moving its elements one place: `» list` moves them right, a fill element
coming in at the front, and `« list` moves them left. With a left argument, that argument is shifted in instead:
`9 » 1‿2‿3` is `⟨9, 1, 2⟩`.
