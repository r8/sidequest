# Modifier score → the ability modifier for score: (score - 10) ÷ 2, rounded down
Modifier ⇐ {⌊(𝕩-10)÷2}
# Ability @ → a random ability score: the sum of the largest three of four rolls of a six-sided die
Ability ⇐ {𝕊: +´ 1↓∧ 1 + 4 •rand.Range 6}
# Character @ → a new random character: a namespace with the fields strength, dexterity,
# constitution, intelligence, wisdom, charisma (each an Ability) and hitpoints
# (10 + the constitution modifier)
Character ⇐ {𝕊:
  strength‿dexterity‿constitution‿intelligence‿wisdom‿charisma ⇐ Ability¨ 6⥊@
  hitpoints ⇐ 10 + Modifier constitution
}
