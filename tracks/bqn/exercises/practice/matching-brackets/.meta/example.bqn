# IsPaired text → 1 if its (), [] and {} are all matched and correctly nested, else 0; other characters are ignored
IsPaired ⇐ {
  v ← (6 > ⊢)⊸/ "([{)]}" ⊐ 𝕩      # openers 0 1 2, closers 3 4 5
  o ← v < 3
  level ← (+` ¯1 + 2×o) - o        # nesting level of each bracket
  (0 ≤ ⌊´ level) ∧ 0 = +´ ¯1 + 2×o ?
    # at each level brackets alternate opener, closer: each closer must match its opener
    ∧´ {∧´ 3 = -˝˘ ⌽˘ ⌊‿2 ⥊ 𝕩}¨ level ⊔ v
  ;
  0
}
