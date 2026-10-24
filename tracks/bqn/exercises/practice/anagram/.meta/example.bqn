# subject FindAnagrams candidates → the candidates that are anagrams of subject, in their given order;
# letter case doesn't matter, and a word is not an anagram of itself
Lower ← {𝕩 + 32 × (('A'≤𝕩)∧𝕩≤'Z') ∨ ('Α'≤𝕩)∧𝕩≤'Ω'}   # ASCII and Greek capitals
FindAnagrams ⇐ {
  s ← Lower 𝕨
  {(s ≢ w) ∧ (∧s) ≡ ∧w ← Lower 𝕩}¨⊸/ 𝕩
}
