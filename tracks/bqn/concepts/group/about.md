# About

## Dyadic group

`𝕨 ⊔ 𝕩` takes a list of group indices `𝕨` and the list `𝕩` to be grouped, of the same length. The result has
`1 + ⌈´𝕨` groups (none when `𝕨` is empty); group `g` is `(𝕨 = g) / 𝕩`. Indices must be integers, at least `¯1`;
elements with index `¯1` are left out.

If `𝕨` has one more element than `𝕩`, that last element is not a group index but the minimum length of the
result. This is the usual way to make sure every key gets a group, even the last ones with nothing in them:

```bqn
keys ← "Ana"‿"Bo"‿"Cy"
((keys ⊐ names) ∾ ≠keys) ⊔ names
```

When some values may not be among the keys, `keys ⊐ names` gives them the index `≠keys`, which makes one
extra group at the end; drop it, or turn the index into `¯1` first.

## Monadic group

`⊔ 𝕩` is `𝕩 ⊔ ↕≠𝕩`: it groups positions. It is the inverse of "which group is each element in": `⊔` turns a
list of group numbers into the members of each group. Its sizes, `≠¨⊔𝕩`, are a histogram of `𝕩`, also written
`/⁼𝕩`.

## Common idioms

| goal | expression |
| --- | --- |
| group equal values, in order of appearance | `(⊐𝕩) ⊔ 𝕩` |
| the distinct values and their groups | `⍷𝕩` and `(⊐𝕩) ⊔ 𝕩` |
| group one list by another | `(⊐keys) ⊔ values` |
| split into chunks of `n` | `(⌊n ÷˜ ↕≠𝕩) ⊔ 𝕩` |
| split a string at spaces | see below |

Splitting on a separator is grouping where each element's index is the number of separators before it, and
the separators themselves get `¯1`:

```bqn
s ← "to be or"
m ← s = ' '
(m × ¯1) + (¬m) × +`m      # ⟨ 0 0 ¯1 1 1 ¯1 2 2 ⟩
((m × ¯1) + (¬m) × +`m) ⊔ s  # ⟨ "to" "be" "or" ⟩
```

## Higher ranks

`𝕨` can be a list of lists of indices, one per axis of `𝕩`, to group a table along both axes at once; and a
plain list `𝕨` groups the rows of a table. The result's groups are then tables too.
