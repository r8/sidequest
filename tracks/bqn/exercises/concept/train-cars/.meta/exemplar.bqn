# A train is a list of car numbers, the locomotive first; 0 is an empty slot.

# count Front train → the first count cars
Front ⇐ {𝕨 ↑ 𝕩}

# count Uncouple train → the train without its last count cars
Uncouple ⇐ {(-𝕨) ↓ 𝕩}

# Turn train → the locomotive, then the other cars in reverse order
Turn ⇐ {(1 ↑ 𝕩) ∾ ⌽ 1 ↓ 𝕩}

# steps Turntable bays → the bays turned steps places towards the front
Turntable ⇐ {𝕨 ⌽ 𝕩}

# car Siding siding → the siding after pushing car in at the front, the last slot rolling out
Siding ⇐ {𝕨 » 𝕩}

# length Platform train → the last length cars of the train, padded with empty slots in front
Platform ⇐ {(-𝕨) ↑ 𝕩}
