# Slices: length Slices series → every contiguous substring of that length, in order (a list of strings);
# errors with "series cannot be empty", "slice length cannot be greater than series length",
# "slice length cannot be zero" or "slice length cannot be negative"
Slices ⇐ {
  "series cannot be empty" ! 0 < ≠𝕩
  "slice length cannot be greater than series length" ! 𝕨 ≤ ≠𝕩
  "slice length cannot be zero" ! 𝕨 ≠ 0
  "slice length cannot be negative" ! 𝕨 > 0
  <˘ 𝕨 ↕ 𝕩
}
