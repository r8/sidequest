# Results are value‿factors: the palindrome and every factor pair a‿b of it with min≤a≤b≤max, ordered
# by a; @‿⟨⟩ when no product in the range is a palindrome.

# Smallest min‿max → the smallest palindrome that is a product of two numbers from min to max;
# errors with "min must be <= max" otherwise
Smallest ⇐ {𝕩 First Palindromes 𝕩}

# Largest min‿max → the largest such palindrome; errors with "min must be <= max" otherwise
Largest ⇐ {𝕩 First ⌽Palindromes 𝕩}

# Palindromes min‿max → the palindromes from min×min to max×max, ascending
Palindromes ← {𝕊 lo‿hi:
  "min must be <= max" ! lo ≤ hi
  lo‿hi ×˜↩
  # all palindromes with 𝕩 digits: the first half, then the rest mirrored
  OfLength ← {n ← ⌈𝕩÷2 ⋄ h ← •Fmt¨ (10⋆n-1) + ↕9×10⋆n-1 ⋄ •ParseFloat¨ h ∾¨ (2|𝕩)↓¨⌽¨h}
  dl‿dh ← ≠∘•Fmt¨ lo‿hi
  # 0 is a palindrome too, but no first half of one starts with 0
  p ← ((0=lo)⥊0) ∾ ∾ OfLength¨ dl + ↕1+dh-dl
  ((p≥lo)∧p≤hi) / p
}

# min‿max Factors p → the factor pairs a‿b of p with min≤a≤b≤max
Factors ← {
  # 0 is only in range when min is 0, and 0 times any b is 0
  min‿max 𝕊 0: 0 ⋈¨ min + ↕1+max-min ;
  min‿max 𝕊 p:
  a ← lo + ↕0 ⌈ 1 + (max⌊⌊√p) - lo ← min⌈⌈p÷max
  (0=a|p) / a ⋈¨ p÷a
}

# range First palindromes → value‿factors for the first palindrome that has factors in range,
# trying them 256 at a time so the search stops early
First ← {
  0=≠𝕩 ? @‿⟨⟩ ;
  f ← 𝕨⊸Factors¨ b ← (256⌊≠𝕩)↑𝕩   # not 256↑𝕩, which pads a short list with 0s
  i ← ⊑ (0<≠¨f) ⊐ 1
  i < ≠b ? (i⊑b)‿(i⊑f) ;
  𝕨 𝕊 256↓𝕩
}
