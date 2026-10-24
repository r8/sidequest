# Rows letter → the rows of the diamond whose widest row has letter
Rows ⇐ {
  n ← 𝕩-'A'
  a ← |n - ↕1+2×n
  <˘ ' ' + (n = a+⌜a) ×⎉1 ('A'-' ') + a
}
