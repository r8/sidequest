# Rotate: shiftKey Rotate text → text with every letter shifted shiftKey places along the
# alphabet, keeping its case; other characters are unchanged
lower‿upper ← 'a'‿'A' + <↕26

# Each character of 𝕩 is looked up in from∾𝕩: letters are found in from and replaced from to,
# anything else finds itself.
Rotate ⇐ {
  from ← lower∾upper
  to ← (𝕨⌽lower)∾𝕨⌽upper
  (to∾𝕩) ⊏˜ (from∾𝕩)⊐𝕩
}
