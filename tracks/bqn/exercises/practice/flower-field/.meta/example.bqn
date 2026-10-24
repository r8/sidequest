Sum3 ← {(»𝕩)+𝕩+«𝕩}
Box ← ⍉∘Sum3∘⍉∘Sum3          # the 3×3 sum around each cell

# Annotate garden → the garden (a list of row strings) with each empty square holding its number
# of neighbouring flowers ('*'), or staying ' ' when it has none
Annotate ⇐ {
  0=≠𝕩 ? 𝕩 ;
  f ← '*' = >𝕩
  <˘ " 12345678*" ⊏˜ (9×f) ⌈ Box f
}
