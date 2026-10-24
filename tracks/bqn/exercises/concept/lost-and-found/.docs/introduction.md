# Introduction

## Filtering with a mask

Comparisons on a list give a list of `1`s and `0`s, one per element. _Replicate_ `/` uses such a list, called a
_mask_, to choose elements: `mask / list` keeps the elements where the mask is `1` and drops those where it is
`0`, in their original order.

```bqn
items ← "umbrella"‿"glove"‿"phone"‿"scarf"
1‿0‿1‿0 / items          # ⟨"umbrella", "phone"⟩
(¬ 1‿0‿1‿0) / items      # ⟨"glove", "scarf"⟩
```

The mask usually comes from a comparison on the list itself or on a list of the same length:

```bqn
days ← 3‿12‿40‿8
(days > 10) / days       # ⟨12, 40⟩
(days > 10) / items      # ⟨"glove", "phone"⟩
```

Mind the parentheses. Read right to left, `days > 10 / days` would first compute `10 / days` and then compare, which
is not what you meant. The mask always goes in parentheses (or in a name) when it is computed.

The mask and the list must have the same length; `1‿0 / "abc"` is an error. Since a string is a list of
characters, the same works on strings:

```bqn
t ← "A-12 / 7"
(('0' ≤ t) ∧ t ≤ '9') / t     # "127"
```

## Replicating with counts

The left argument does not have to be a mask. Any list of whole numbers that are not negative works: each one
says how many copies of the matching element to keep. A mask is just the special case of `0` or `1` copies.

```bqn
2‿0‿1 / "abc"           # "aac"
3‿1 / 10‿20             # ⟨10, 10, 10, 20⟩
```

A single number on the left copies every element that many times: `3 / "ab"` is `"aaabbb"`.

## Indices

With only a right argument, `/` gives _indices_. For a mask, these are the positions of the `1`s, counting from
`0`:

```bqn
/ 0‿1‿1‿0‿1             # ⟨1, 2, 4⟩
/ days > 10             # ⟨1, 2⟩: positions of the days above 10
```

Like everything in BQN, positions count from `0`: the first element is at index `0`, the last at `n-1` for a list
of length `n`. `↕ n` lists all of them.

Monadic `/` is the same as replicating the indices: `/ counts` is `counts / ↕ ≠counts`. With counts other than
`0` and `1`, each index appears as many times as its count says:

```bqn
/ 2‿0‿1                 # ⟨0, 0, 2⟩
```

Read this as "index `0` twice, index `1` never, index `2` once". It is a useful way to label things: if box `i`
holds `counts[i]` items, `/ counts` gives the box number of every item, in order.

## Empty results

When nothing is selected, the result is an empty list: `0‿0 / "ab"` and `/ 0‿0‿0` are both empty, and an
empty list matches `""` and `⟨⟩` alike. Empty results
are normal, not errors, and the functions you write with `/` should return them without any special handling.
