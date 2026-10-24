# Keys and primes are numbers; p must be small enough that p×p stays below 2⋆53.

# PrivateKey p → a random integer greater than 1 and less than p
PrivateKey ⇐ {2 + •rand.Range 𝕩-2}

# PublicKey p‿g‿privateKey → g to the power privateKey, modulo p
PublicKey ⇐ {p‿g‿a: g‿a ModPow p}

# Secret p‿theirPublicKey‿myPrivateKey → theirPublicKey to the power myPrivateKey, modulo p
Secret ⇐ PublicKey

# base‿exp ModPow m → base⋆exp modulo m, by squaring from the exponent's top bit down, so every
# intermediate product stays below m×m
ModPow ← {b‿e 𝕊 m: 1 {m | (𝕨⊑1‿b) × m|×˜𝕩}´ 2|⌊e÷2⋆↕53}
