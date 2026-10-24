# Introduction

Arithmetic and comparison are _pervasive_: `⟨1‿2, ⟨3⟩⟩ × 10` reaches every number. Most other functions, such as
`≠` and `∾`, see their argument as a whole. To apply one of them to every element, modify it with _each_ `¨`.

`¨` is a 1-modifier: written right after a function (its operand), it makes a new function.

```bqn
≠¨ "Intro"‿"Home"                         # ⟨5, 4⟩
{𝕩 ∾ "!"}¨ "Intro"‿"Home"                 # ⟨"Intro!", "Home!"⟩
"a"‿"b" {𝕨 ∾ "-" ∾ 𝕩}¨ "x"‿"y"           # ⟨"a-x", "b-y"⟩
```

With two arguments, each pairs up elements, so both lists must have the same length. Modifiers can be stacked:
`≠¨¨` reaches one level deeper.
