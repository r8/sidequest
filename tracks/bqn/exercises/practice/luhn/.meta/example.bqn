# Valid number → 1 if the digits (spaces allowed) pass the Luhn check, else 0; fewer than two digits or any other character is invalid
Valid ⇐ {
  s ← 𝕩 /˜ ' ' ≠ 𝕩
  (2 ≤ ≠s) ∧ ∧´ s ∊ '0'+↕10 ?
    d ← (1 + 2|↕≠s) × ⌽ s - '0'
    0 = 10 | +´ d - 9 × d > 9
  ;
  0
}
