# coins FindFewestCoins target → the fewest coins adding up to target, in ascending order; errors with
# "target can't be negative" or "can't make target with given coins"
FindFewestCoins ⇐ {coins 𝕊 target:
  "target can't be negative" ! target ≥ 0
  # Extend best (for each amount below this one: its fewest coins, or @ if it can't be made) by one
  # amount: one more coin on top of the best way to make the rest
  Next ← {amount 𝕊 best:
    c ← (coins ≤ amount) / coins
    ok ← @ ≢¨ rest ← (amount-c) ⊏ best
    ways ← ∧¨ (ok/c) ∾¨ ok/rest
    best ∾ < {0=≠𝕩 ? @ ; (⊑⍋≠¨𝕩) ⊑ 𝕩} ways
  }
  r ← ¯1 ⊑ ⟨⟨⟩⟩ Next´ ⌽1+↕target
  "can't make target with given coins" ! @ ≢ r
  r
}
