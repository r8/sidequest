alpha ← 'a'+↕26
digits ← '0'+↕10
Lower ← {𝕩 + 32×('A'≤𝕩)∧𝕩≤'Z'}
Clean ← (∊⟜(alpha∾digits))⊸/ Lower
Flip ← ((⌽alpha)∾digits) ⊏˜ (alpha∾digits)⊸⊐
Group ← {1↓∾' '∾¨(⌊5÷˜↕≠𝕩)⊔𝕩}

# Encode phrase → the lower-case Atbash ciphertext of its letters and digits, in groups of five
# separated by spaces
Encode ⇐ Group Flip∘Clean

# Decode ciphertext → the plaintext of its letters and digits, without spaces
Decode ⇐ Flip∘Clean
