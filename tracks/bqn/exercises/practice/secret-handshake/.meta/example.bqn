actions ← "wink"‿"double blink"‿"close your eyes"‿"jump"

# Commands number → the list of actions for bits 1 "wink", 2 "double blink", 4 "close your eyes" and 8 "jump",
# in that order, reversed when bit 16 is set
Commands ⇐ {
  b ← 2 | ⌊ 𝕩 ÷ 2⋆↕5
  ⌽⍟(4⊑b) (4↑b) / actions
}
