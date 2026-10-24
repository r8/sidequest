# A train is a list of car numbers, the locomotive first; 0 is an empty slot.

# count Front train → the first count cars
Front ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# count Uncouple train → the train without its last count cars
Uncouple ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# Turn train → the locomotive, then the other cars in reverse order
Turn ⇐ {𝕊 𝕩: "implement me" ! 0}

# steps Turntable bays → the bays turned steps places towards the front
Turntable ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# car Siding siding → the siding after pushing car in at the front, the last slot rolling out
Siding ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# length Platform train → the last length cars of the train, padded with empty slots in front
Platform ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
