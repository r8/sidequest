bands ← "black"‿"brown"‿"red"‿"orange"‿"yellow"‿"green"‿"blue"‿"violet"‿"grey"‿"white"
units ← "ohms"‿"kiloohms"‿"megaohms"‿"gigaohms"

# Label colors → value‿unit for the first three band colors (a list of strings), e.g. 33‿"ohms" or 2‿"kiloohms":
# the unit is "ohms", "kiloohms", "megaohms" or "gigaohms", the largest that keeps value a whole number; later bands are ignored
Label ⇐ {
  a‿b‿c ← bands ⊐ 3↑𝕩
  ohms ← (b + 10×a) × 10⋆c
  k ← (ohms > 0) × +´ ∧` 0 = (1000⋆1+↕3) | ohms
  (ohms ÷ 1000⋆k)‿(k⊑units)
}
