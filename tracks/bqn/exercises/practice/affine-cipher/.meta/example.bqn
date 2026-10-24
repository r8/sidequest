# The key is a two-element list a‿b. Both functions error with "a and m must be coprime." unless
# a and 26 are coprime.
alpha ← 'a'+↕26
digits ← '0'+↕10
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}
Clean ← (∊⟜(alpha∾digits))⊸/ Lower
Group ← {1↓∾' '∾¨(⌊5÷˜↕≠𝕩)⊔𝕩}

# Maps clean text through the letter permutation 𝕨 (indices into alpha); digits stay.
Through ← {((𝕨⊏alpha)∾digits) ⊏˜ (alpha∾digits)⊐𝕩}

Check ← {"a and m must be coprime." ! ¬∨´0=2‿13|𝕩}

# Encode: a‿b Encode phrase → the lower-case ciphertext of its letters and digits, in groups of
# five separated by spaces
Encode ⇐ {
  a‿b ← 𝕨 ⋄ Check a
  Group (26|b+a×↕26) Through Clean 𝕩
}

# Decode: a‿b Decode ciphertext → the plaintext of its letters and digits, without spaces
Decode ⇐ {
  a‿b ← 𝕨 ⋄ Check a
  inverse ← ⊑ / 1 = 26|a×↕26
  (26|inverse×b-˜↕26) Through Clean 𝕩
}
