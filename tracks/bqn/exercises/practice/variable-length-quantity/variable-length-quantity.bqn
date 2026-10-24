# Integers and bytes are lists of numbers; each integer fits in 32 bits, each byte in 8.

# Encode integers → the VLQ bytes of each integer, in order
Encode ⇐ {𝕊 𝕩: "implement me" ! 0}

# Decode bytes → the integers they encode; errors with "incomplete sequence" if the last byte has
# its high bit set
Decode ⇐ {𝕊 𝕩: "implement me" ! 0}
