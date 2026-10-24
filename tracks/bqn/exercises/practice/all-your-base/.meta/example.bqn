# Rebase inputBase‿digits‿outputBase → the digits of the same number in outputBase, most significant
# first (⟨0⟩ for zero); errors with "input base must be >= 2", "all digits must satisfy 0 <= d < input
# base" or "output base must be >= 2", checked in that order
Rebase ⇐ {𝕊 ib‿ds‿ob:
  "input base must be >= 2" ! ib ≥ 2
  "all digits must satisfy 0 <= d < input base" ! ∧´(ds≥0)∧ds<ib
  "output base must be >= 2" ! ob ≥ 2
  ob Digits 0 {𝕨+ib×𝕩}´ ⌽ds
}

# base Digits n → the digits of n in base, most significant first
Digits ← {𝕩 < 𝕨 ? ⋈𝕩 ; (𝕨 𝕊 ⌊𝕩÷𝕨) ∾ 𝕨|𝕩}
