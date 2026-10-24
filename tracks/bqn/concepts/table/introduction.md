# Introduction

`⌜` (table) is a 1-modifier: written after a function, it makes a function that applies it to every pair of
an element of `𝕨` and an element of `𝕩`. Rows belong to elements of `𝕨`, columns to elements of `𝕩`:

```bqn
1‿2‿3 ×⌜ 1‿2‿3‿4     # a 3×4 times table
"RGB" =⌜ "BRR"       # 0 1 1 / 0 0 0 / 1 0 0
```

The result's shape is `(≢𝕨) ∾ ≢𝕩`. The operand can be any function, including a block:
`"pale"‿"deep" {𝕨∾" "∾𝕩}⌜ "blue"‿"red"` names all four mixes.
