# basePrices Prices tintPrices → the price of every base with every tint: a row per base, a column per tint
Prices ⇐ {𝕨 +⌜ 𝕩}

# litres Costs pricePerLitre → the price of every tin size of every paint: a row per size, a column per paint
Costs ⇐ {𝕨 ×⌜ 𝕩}

# shades MixNames colours → "shade colour" for every pair: a row per shade, a column per colour
MixNames ⇐ {𝕨 {𝕨 ∾ " " ∾ 𝕩}⌜ 𝕩}

# shelf Matches orders → 1 where a tin's code equals an order's code: a row per tin, a column per order
Matches ⇐ {𝕨 =⌜ 𝕩}
