# Integers and bytes are lists of numbers; each integer fits in 32 bits, each byte in 8.

# Encode integers → the VLQ bytes of each integer, in order
Encode ⇐ {∾ {𝕩 + 128×«1¨𝕩} ∘ Septets¨ 𝕩}

# Decode bytes → the integers they encode; errors with "incomplete sequence" if the last byte has
# its high bit set
Decode ⇐ {
  "incomplete sequence" ! 128 > ¯1⊑0∾𝕩
  {+´𝕩×128⋆⌽↕≠𝕩}¨ (+`»𝕩<128) ⊔ 128|𝕩
}

# Septets n → the 7-bit groups of n, most significant first (at least one)
Septets ← {128 | ⌊𝕩 ÷ 128 ⋆ ⌽↕1 + +´𝕩 ≥ 128⋆1+↕7}
