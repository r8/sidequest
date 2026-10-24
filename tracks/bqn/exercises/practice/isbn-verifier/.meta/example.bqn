# IsValid isbn → 1 if it is a valid ISBN-10 (dashes optional, X only as the check digit), else 0
IsValid ⇐ {
  v ← "0123456789X" ⊐ 𝕩 /˜ '-' ≠ 𝕩   # 10 is X, 11 anything else
  10 = ≠v ? (∧´ (10 > ¯1↓v) ∾ 11 > ¯1⊑v) ∧ 0 = 11 | +´ v × 10-↕10 ;
  0
}
