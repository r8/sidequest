bands ← "black"‿"brown"‿"red"‿"orange"‿"yellow"‿"green"‿"blue"‿"violet"‿"grey"‿"white"

# ColorCode color → the band's digit, 0 for "black" to 9 for "white"
ColorCode ⇐ {⊑ bands ⊐ <𝕩}

# Colors @ → the list of band colors, in digit order
Colors ⇐ {𝕊: bands}
