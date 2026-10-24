# diagram Plants student → the names of the student's four plants ("grass", "clover", "radishes",
# "violets"), front row first. diagram is two rows of plant letters separated by a newline
students ← "Alice"‿"Bob"‿"Charlie"‿"David"‿"Eve"‿"Fred"‿"Ginny"‿"Harriet"‿"Ileana"‿"Joseph"‿"Kincaid"‿"Larry"
names ← "grass"‿"clover"‿"radishes"‿"violets"
Plants ⇐ {
  rows ← 2‿∘ ⥊ (@+10)⊸≠⊸/ 𝕨
  cups ← ⥊ ((2×⊑students⊐<𝕩) + ↕2)⊸⊏˘ rows
  names ⊏˜ "GCRV" ⊐ cups
}
