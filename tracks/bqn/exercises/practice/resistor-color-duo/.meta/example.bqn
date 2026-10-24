bands ← "black"‿"brown"‿"red"‿"orange"‿"yellow"‿"green"‿"blue"‿"violet"‿"grey"‿"white"

# Value colors → the two-digit number from the first two band colors (a list of strings); later bands are ignored
Value ⇐ {+´ 10‿1 × bands ⊐ 2↑𝕩}
