# Allergens, by score bit: "eggs" 1, "peanuts" 2, "shellfish" 4, "strawberries" 8, "tomatoes" 16, "chocolate" 32, "pollen" 64, "cats" 128;
# higher bits of the score are ignored.
allergens ← "eggs"‿"peanuts"‿"shellfish"‿"strawberries"‿"tomatoes"‿"chocolate"‿"pollen"‿"cats"
Bits ← {2 | ⌊ 𝕩 ÷ 2⋆↕8}

# AllergicTo: score AllergicTo item → 1 if the score includes that allergen, else 0
AllergicTo ⇐ {(⊑ allergens ⊐ <𝕩) ⊑ Bits 𝕨}

# List score → the allergens the score includes, in the order above
List ⇐ {(Bits 𝕩) / allergens}
