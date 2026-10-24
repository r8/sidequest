# SquareRoot n → the whole-number square root of the perfect square n, without using √ or ⋆
# One bit at a time, from 2⋆26 down (´ folds from the right), keeping each bit that leaves the
# square at most n; every n below 2⋆53 has its root below 2⋆27.
SquareRoot ⇐ {n ← 𝕩 ⋄ 0 {b 𝕊 r: r + b × n ≥ ×˜ r+b}´ ×`1∾26⥊2}
