# Translate phrase → the phrase in Pig Latin, word by word; words are lower case and separated
# by whitespace, which is kept as it is

# Word word → the word with its leading consonant cluster (taking a "qu" along whole) moved to
# the end, then "ay"; "xr" and "yt" count as vowels, and so does "y" after the first letter
Word ← {
  vowel ← (𝕩∊"aeiou") ∨ ('y'=𝕩) ∧ 0<↕≠𝕩
  n ← +´ ∧` ¬vowel
  n +↩ (0<n) ∧ "qu" ≡ 2↑(n-1)↓𝕩
  n ×↩ ¬ (<2↑𝕩) ∊ "xr"‿"yt"
  (n⌽𝕩) ∾ "ay"
}

ws ← " " ∾ @+9+↕5

# The runs of whitespace and of other characters in turn; the runs of others are words
Translate ⇐ {∾ {0=≠𝕩 ? 𝕩 ; ∨´ws=⊑𝕩 ? 𝕩 ; Word 𝕩}¨ (+`(»s)≠s←𝕩∊ws) ⊔ 𝕩}
