# rails Rail length → the rail each position of the zig-zag lands on
Rail ← {p ← 1⌈2×𝕨-1 ⋄ (⊢⌊p⊸-) p|↕𝕩}

# Encode: rails Encode message → the message written in a zig-zag over that many rails, read off
# rail by rail
Encode ⇐ {𝕩 ⊏˜ ⍋ 𝕨 Rail ≠𝕩}

# Decode: rails Decode ciphertext → the message that Encode turns into the ciphertext
Decode ⇐ {𝕩 ⊏˜ ⍋⍋ 𝕨 Rail ≠𝕩}
