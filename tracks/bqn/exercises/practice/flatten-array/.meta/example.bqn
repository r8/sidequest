# Flatten array → the atoms of the nested list array, in order, with every @ (standing in for null)
# left out: Flatten ⟨1, ⟨2, @, ⟨3⟩⟩⟩ → 1‿2‿3
Atoms ← {0=≡𝕩 ? ⋈𝕩 ; ∾𝕊¨𝕩}
Flatten ⇐ (@≢¨⊢)⊸/ Atoms
