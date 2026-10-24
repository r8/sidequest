# Introduction

`∧ 𝕩` sorts a list ascending and `∨ 𝕩` descending. Any values can be sorted: numbers before characters,
characters by code point, lists element by element, so lists of strings sort alphabetically (capitals first).

`⍋ 𝕩` (grade up) and `⍒ 𝕩` (grade down) return the _indices_ that would sort `𝕩`. Selecting with them sorts
another list by the values of this one:

```bqn
times ← 31‿27‿35‿27
⍋ times                        # ⟨ 1 3 0 2 ⟩
(⍋ times) ⊏ "Ana"‿"Ben"‿"Cy"‿"Dee"   # ⟨ "Ben" "Dee" "Ana" "Cy" ⟩
```

Grades are stable, so equal values keep their order. `⍋ ⍋ 𝕩` gives each element's place in the sorted order.
