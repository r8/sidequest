# Keys and primes are numbers; p must be small enough that p×p stays below 2⋆53.

# PrivateKey p → a random integer greater than 1 and less than p
PrivateKey ⇐ {𝕊 𝕩: "implement me" ! 0}

# PublicKey p‿g‿privateKey → g to the power privateKey, modulo p
PublicKey ⇐ {𝕊 𝕩: "implement me" ! 0}

# Secret p‿theirPublicKey‿myPrivateKey → theirPublicKey to the power myPrivateKey, modulo p
Secret ⇐ {𝕊 𝕩: "implement me" ! 0}
