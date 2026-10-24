# Slots are numbered from 0; products and prices are lists in slot order.

# slot Product products → the product in that slot
Product ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# slots Order products → the product in each of the slots, in the order given
Order ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# Newest products → the product in the last slot
Newest ⇐ {𝕊 𝕩: "implement me" ! 0}

# prices PriceOf code → the price in the slot with that code ("A1" is slot 0; three slots per row)
PriceOf ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# message Window start → the 8 characters of message from start on, wrapping around
Window ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
