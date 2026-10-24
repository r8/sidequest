# Introduction

Every element of a list has an _index_, its position counting from `0`: in a list of length `n`, the first
element has index `0` and the last has index `n-1`. BQN has two functions for getting elements by index, pick `⊑`
and select `⊏`.

## Pick

`i ⊑ list` picks the element at index `i`:

```bqn
p ← "cola"‿"chips"‿"gum"‿"water"
1 ⊑ p        # "chips"
0 ⊑ "chips"  # 'c'
```

A negative index counts from the end: `¯1` is the last element, `¯2` the one before it.

```bqn
¯1 ⊑ p       # "water"
```

Without a left argument, `⊑` picks the first element: `⊑ p` is `"cola"`, and `⊑ "chips"` is the character `'c'`.

An index must be a whole number from `-n` to `n-1`; anything else is an error
(`𝕨⊑𝕩: indexing out-of-bounds`). Picking from an empty list is always an error.

## Select

`indices ⊏ list` selects several elements at once. The result has one element for each index, in the order of the
indices, so it can reorder, repeat or leave out elements:

```bqn
2‿0‿2 ⊏ p           # ⟨"gum", "cola", "gum"⟩
¯2‿¯1 ⊏ p           # ⟨"gum", "water"⟩
3‿0 ⊏ "hello"       # "lh"
⟨⟩ ⊏ p              # ⟨⟩
```

Selecting from a string gives a string, and the indices can be computed. Arithmetic on `↕` gives runs of indices:

```bqn
2 + ↕3              # ⟨2, 3, 4⟩
(2 + ↕3) ⊏ "vending"  # "ndi"
```

## Pick or select?

The difference shows with a single index. `1 ⊑ p` returns the element itself, the string `"chips"`. `1 ⊏ p`
returns an array holding that element, which prints as a box around `"chips"`; it is not the same value, and
comparing it with `"chips"` will disappoint. Use `⊑` to get one element and `⊏` with a list of indices to get a
list:

```bqn
1 ⊑ p         # "chips"
⟨1⟩ ⊏ p       # ⟨"chips"⟩
```

## Indices that wrap around

Modulus keeps computed indices in range. `(≠list) | i` is always between `0` and `≠list - 1`, so a list of indices
can run past the end and come back to the start:

```bqn
m ← "HELLO "
((≠m) | 4 + ↕8) ⊏ m     # "O HELLO "
```

## Characters as indices

Characters subtract to give numbers, so letters and digits in a code can be turned into indices: `'C' - 'A'` is
`2` and `'7' - '0'` is `7`. Pick the characters out of the code first, then do the arithmetic.

```bqn
code ← "C7"
(⊑ code) - 'A'        # 2
(1 ⊑ code) - '0'      # 7
```
