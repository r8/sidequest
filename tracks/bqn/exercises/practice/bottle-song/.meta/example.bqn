# Recite start‿count → the lines of count verses counting down from start bottles, with an empty
# line between verses
Recite ⇐ {s‿n: 1↓∾ (⋈"")⊸∾¨ Verse¨ s - ↕n}

numbers ← "no"‿"one"‿"two"‿"three"‿"four"‿"five"‿"six"‿"seven"‿"eight"‿"nine"‿"ten"
Bottles ← {(𝕩⊑numbers) ∾ " green bottle" ∾ (𝕩≠1)/"s"}
Cap ← -⟜32⌾⊑

Verse ← {
  wall ← (Cap Bottles 𝕩) ∾ " hanging on the wall,"
  ⟨wall, wall, "And if one green bottle should accidentally fall,", "There'll be "∾(Bottles 𝕩-1)∾" hanging on the wall."⟩
}
