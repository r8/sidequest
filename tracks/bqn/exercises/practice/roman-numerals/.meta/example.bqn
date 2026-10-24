# Roman number → number (1 to 3999) in Roman numerals
Roman ⇐ {
  d ← '0' -˜ •Fmt 𝕩
  ∾ (2×⌽↕≠d) {"IVXLCDM" ⊏˜ 𝕨 + 𝕩⊑patterns}¨ d
}

# Each decimal digit as a pattern of the place's one, five and ten symbols.
patterns ← ⟨⟨⟩, ⟨0⟩, 0‿0, 0‿0‿0, 0‿1, ⟨1⟩, 1‿0, 1‿0‿0, 1‿0‿0‿0, 0‿2⟩
