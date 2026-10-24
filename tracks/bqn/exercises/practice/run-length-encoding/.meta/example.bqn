IsDigit ← ('0'≤⊢)∧≤⟜'9'

# Encode string → each run of a repeated character as its length and the character; runs of
# one character are written without the length
Encode ⇐ {
  runs ← (¯1 + +`(0=↕≠𝕩) ∨ 𝕩≠»𝕩) ⊔ 𝕩
  ∾ {((1<≠𝕩)/•Fmt ≠𝕩) ∾ 1↑𝕩}¨ runs
}

# Decode encoded → the string that Encode turns into encoded
Decode ⇐ {
  runs ← (+`»¬IsDigit 𝕩) ⊔ 𝕩
  ∾ {(1 ⌈ 0 {𝕨+10×𝕩}´ ⌽ '0' -˜ ¯1↓𝕩) / ¯1↑𝕩}¨ runs
}
