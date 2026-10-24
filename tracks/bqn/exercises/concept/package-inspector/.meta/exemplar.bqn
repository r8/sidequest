# CheckWeight kg → kg; errors with "weight must be positive" (0 or less) or "too heavy" (over 30)
CheckWeight ⇐ {
  "weight must be positive" ! 𝕩 > 0
  "too heavy" ! 𝕩 ≤ 30
  𝕩
}

# Volume length‿width‿height → their product; errors with "sides must be positive", then "too big" (sum over 150)
Volume ⇐ {𝕊 l‿w‿h:
  "sides must be positive" ! (l > 0) ∧ (w > 0) ∧ h > 0
  "too big" ! 150 ≥ l + w + h
  l × w × h
}

# rate Postage kg → rate × kg, raising CheckWeight's errors for an invalid kg
Postage ⇐ {𝕨 × CheckWeight 𝕩}

# SafeWeight kg → kg if CheckWeight accepts it, else 0
SafeWeight ⇐ CheckWeight⎊0

# Inspect length‿width‿height → "ok" if Volume accepts the sides, else the message of its error
Inspect ⇐ {Volume 𝕩 ⋄ "ok"}⎊{𝕊: •CurrentError @}
