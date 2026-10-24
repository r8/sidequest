# Introduction

## Fold

_Fold_ `´` is a 1-modifier, like each `¨`. It takes a function of two arguments and puts it between all the
elements of a list:

```bqn
+´ 1‿2‿3‿4        # 10, which is 1 + 2 + 3 + 4
×´ 1‿2‿3‿4        # 24
⌈´ 3‿9‿2          # 9, the largest element
⌊´ 3‿9‿2          # 2, the smallest
```

Fold is BQN's way of reducing a whole list to one value. With the right operand it answers many common
questions:

| fold | gives |
| --- | --- |
| `+´` | the sum |
| `×´` | the product |
| `⌈´` and `⌊´` | the largest and smallest element |
| `∧´` | `1` if every element is `1` (all) |
| `∨´` | `1` if any element is `1` (any) |

Combine fold with comparison to ask about every element: `∧´ 0 < prices` asks whether every price is positive,
and `+´ prices > 100` counts the prices above 100, since a boolean is just the number `1` or `0`.

## Right to left

Like the rest of BQN, fold works from right to left. `-´ 1‿2‿3‿4` is `1 - 2 - 3 - 4`, which BQN reads as
`1 - (2 - (3 - 4))`, so the result is `¯2`, not `¯8`. For `+`, `×`, `⌈`, `⌊`, `∧` and `∨` the grouping makes no
difference, but for `-`, `÷` and for your own blocks it does.

Any function of two arguments can be folded, including a block. `𝕨` is an element and `𝕩` the result of folding
everything to its right:

```bqn
{𝕨 ∾ ", " ∾ 𝕩}´ "apples"‿"bread"‿"milk"     # "apples, bread, milk"
{"(" ∾ 𝕨 ∾ 𝕩 ∾ ")"}´ "a"‿"b"‿"c"            # "(a(bc))"
```

## Empty lists and the initial value

Folding an empty list returns the operand's _identity_: the value that changes nothing when combined with
another. BQN knows the identities of its arithmetic functions:

```bqn
+´ ⟨⟩     # 0
×´ ⟨⟩     # 1
∧´ ⟨⟩     # 1: every element of nothing is true
∨´ ⟨⟩     # 0
⌈´ ⟨⟩     # ¯∞
```

A block has no known identity, so folding it over an empty list is an error (`Identity not found`).

A fold can also be given a starting value as its left argument. The value goes in at the right end, before
anything else is combined:

```bqn
10 +´ 1‿2‿3       # 16, which is 1 + 2 + 3 + 10
10 -´ 1‿2‿3       # ¯8, which is 1 - (2 - (3 - 10))
```

With a starting value, an empty list simply returns the starting value.

## Folding nested lists

Fold combines the elements of a list, whatever they are. With each, it can sum every list in a list of lists:

```bqn
+´¨ ⟨1‿2, ⟨⟩, ⟨5⟩⟩     # ⟨3, 0, 5⟩
```

Fold needs a list; `+´ 5` is an error, since a single number is not a list.
