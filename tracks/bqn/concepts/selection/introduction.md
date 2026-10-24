# Introduction

Indices count from `0`, and negative indices count from the end (`¯1` is the last element).

_Pick_ `i ⊑ list` returns the element at index `i`; `⊑ list` returns the first element. _Select_
`indices ⊏ list` returns a list with the element at each index, in the order of the indices, so it can reorder and
repeat:

```bqn
p ← "cola"‿"chips"‿"gum"
1 ⊑ p          # "chips"
¯1 ⊑ p         # "gum"
2‿0‿2 ⊏ p      # ⟨"gum", "cola", "gum"⟩
```

An index outside the list is an error. With a single index, `⊏` returns the element inside an array rather than
the element itself, so use `⊑` for one element and `⊏` for many.
