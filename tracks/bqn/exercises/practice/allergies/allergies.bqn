# Allergens, by score bit: "eggs" 1, "peanuts" 2, "shellfish" 4, "strawberries" 8, "tomatoes" 16, "chocolate" 32, "pollen" 64, "cats" 128;
# higher bits of the score are ignored.

# AllergicTo: score AllergicTo item → 1 if the score includes that allergen, else 0
AllergicTo ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# List score → the allergens the score includes, in the order above
List ⇐ {𝕊 𝕩: "implement me" ! 0}
