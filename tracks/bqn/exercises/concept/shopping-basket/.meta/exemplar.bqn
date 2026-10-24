# A basket is a list of prices in cents.

# Total basket → the sum of the prices (0 for an empty basket)
Total ⇐ {+´ 𝕩}

# MostExpensive basket → the highest price in a non-empty basket
MostExpensive ⇐ {⌈´ 𝕩}

# AllInStock counts → 1 if every count is at least 1, else 0
AllInStock ⇐ {∧´ 0 < 𝕩}

# price Discounted discounts → the price multiplied by every discount
Discounted ⇐ {𝕨 × ×´ 𝕩}

# PackingList items → the item names joined with ", "
PackingList ⇐ {{𝕨 ∾ ", " ∾ 𝕩}´ 𝕩}

# BasketTotals baskets → the total of each basket
BasketTotals ⇐ {Total¨ 𝕩}
