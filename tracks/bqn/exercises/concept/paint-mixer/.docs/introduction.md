# Introduction

## Every pair

Arithmetic on two lists pairs their elements up position by position, so the lists must be the same length:

```bqn
1‿2 + 10‿20        # ⟨ 11 22 ⟩
```

Often you want something else: every element of one list combined with every element of the other. A times
table is the classic example, and so is a price list for every size of every product. BQN writes this with
`⌜` (table):

```bqn
1‿2‿3 ×⌜ 1‿2‿3‿4
# ┌─
# ╵ 1 2 3  4
#   2 4 6  8
#   3 6 9 12
#            ┘
```

## Table is a modifier

`⌜` is not a function but a _1-modifier_: it is written just after a function, its _operand_, and makes a new
function out of it. `×⌜` is the function "multiply every pair", `+⌜` "add every pair", `=⌜` "compare every
pair". The new function is called like any other, with its arguments on either side:

```bqn
10‿20 +⌜ 1‿2‿3
# ┌─
# ╵ 11 12 13
#   21 22 23
#            ┘
```

Each _row_ of the result belongs to one element of the left argument, and each _column_ to one element of the
right argument. Row `i`, column `j` holds `(i⊑𝕨) F (j⊑𝕩)`.

## The shape of a table

The result's shape is the shape of `𝕨` followed by the shape of `𝕩`. For two lists of lengths 3 and 4 that is a
table of shape `3‿4`. If one list is empty, the table has no elements, but it still has a shape:

```bqn
≢ 1‿2‿3 ×⌜ 1‿2‿3‿4    # ⟨ 3 4 ⟩
≢ ⟨⟩ +⌜ 1‿2‿3         # ⟨ 0 3 ⟩
```

If `𝕨` is itself a table, the result has rank 3, and so on: table works on the _elements_ of its arguments,
whatever their shapes.

## Any function

The operand can be any function, including one you write as a block. `𝕨` and `𝕩` inside the block are then
single elements of the outer arguments:

```bqn
"pale"‿"deep" {𝕨 ∾ " " ∾ 𝕩}⌜ "blue"‿"red"
# ┌─
# ╵ "pale blue" "pale red"
#   "deep blue" "deep red"
#                         ┘
```

This works because `∾` is not pervasive: it joins the two whole strings it is given. With an arithmetic
function, table applies the function to whole elements too, and the arithmetic then goes into them as usual.

Characters are elements like any other, so a table over two strings compares or combines every pair of
characters:

```bqn
"RGB" =⌜ "BRR"
# ┌─
# ╵ 0 1 1
#   0 0 0
#   1 0 0
#         ┘
```

## Pitfalls

- `𝕨 F⌜ 𝕩` and `𝕩 F⌜ 𝕨` are transposes of each other: the left argument chooses the rows.
- Don't confuse `+` with `+⌜`: one pairs positions and needs equal lengths, the other pairs everything.
- A string is a list of characters, so `"pale" ∾⌜ "red"` combines characters, not words. Put words in a list,
  `⟨"pale"⟩`, to treat each as one element.
