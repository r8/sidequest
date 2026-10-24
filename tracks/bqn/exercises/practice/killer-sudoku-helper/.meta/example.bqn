# Combinations sum‿size‿exclude → every set of size distinct digits 1–9 adding up to sum and
# using none of exclude, each ascending, in ascending order
subsets ← (<˘2|⌊(↕512)÷⌜2⋆↕9) /¨ <1+↕9

Combinations ⇐ {s‿n‿ex:
  ∧ subsets /˜ {(n=≠𝕩) ∧ (s=+´𝕩) ∧ ¬∨´𝕩∊ex}¨ subsets
}
