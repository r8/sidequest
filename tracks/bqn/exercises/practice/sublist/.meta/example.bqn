# listOne Sublist listTwo → "equal", "sublist" (listOne appears contiguously in listTwo),
# "superlist" (listTwo appears in listOne) or "unequal"
Sublist ⇐ {
  𝕨 ≡ 𝕩 ? "equal" ;
  ∨´ 𝕨⍷𝕩 ? "sublist" ;
  ∨´ 𝕩⍷𝕨 ? "superlist" ;
  "unequal"
}
