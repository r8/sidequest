# Slots are numbered from 0; products and prices are lists in slot order.
perRow ← 3
width ← 8

# slot Product products → the product in that slot
Product ⇐ {𝕨 ⊑ 𝕩}

# slots Order products → the product in each of the slots, in the order given
Order ⇐ {𝕨 ⊏ 𝕩}

# Newest products → the product in the last slot
Newest ⇐ {¯1 ⊑ 𝕩}

# prices PriceOf code → the price in the slot with that code ("A1" is slot 0; three slots per row)
PriceOf ⇐ {((perRow × (⊑ 𝕩) - 'A') + (1 ⊑ 𝕩) - '1') ⊑ 𝕨}

# message Window start → the 8 characters of message from start on, wrapping around
Window ⇐ {((≠ 𝕨) | 𝕩 + ↕ width) ⊏ 𝕨}
